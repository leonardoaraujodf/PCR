----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.07.2019 09:28:40
-- Design Name: 
-- Module Name: adder_tmr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.fpupack.all;
use IEEE.NUMERIC_STD.ALL;

entity adder_tmr is
    Port ( clk_in : in STD_LOGIC;
           enable_in : in STD_LOGIC;
           reset_in : in STD_LOGIC;
           op_sel : in STD_LOGIC;
           a_in : in STD_LOGIC_VECTOR(FP_WIDTH-1 downto 0);
           b_in : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           fault_in : in STD_LOGIC_VECTOR (1 downto 0); -- insert a fault manually
           o_out : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           fault_out : out STD_LOGIC_VECTOR(2 downto 0);
           ready_out : out STD_LOGIC);
end adder_tmr;

architecture Behavioral of adder_tmr is

component addsubfsm_v6 is
port (  reset :  in std_logic;
        clk : in std_logic;
        op : in std_logic;
        op_a : in std_logic_vector(FP_WIDTH-1 downto 0);
        op_b : in std_logic_vector(FP_WIDTH-1 downto 0);
        start_i : in std_logic;
        addsub_out : out std_logic_vector(FP_WIDTH-1 downto 0);
        ready_as : out std_logic);
end component;

signal ready_adder1 : std_logic := '0';
signal ready_adder2 : std_logic := '0';
signal ready_adder3 : std_logic := '0';
signal all_readys_on : std_logic := '0';
signal ready_after_fault_in : std_logic := '0';

signal out_adder1 : std_logic_vector(FP_WIDTH-1 downto 0);
signal out_adder2 : std_logic_vector(FP_WIDTH-1 downto 0);
signal out_adder3 : std_logic_vector(FP_WIDTH-1 downto 0);

signal out_temp : std_logic_vector(FP_WIDTH-1 downto 0);
signal fault_temp : std_logic_vector(2 downto 0);

begin

U0_FIRST_ADDER: addsubfsm_v6 port map (  
        reset => reset_in,
        clk => clk_in,
        op => op_sel,
        op_a => a_in,
        op_b => b_in,
        start_i => enable_in,
        addsub_out => out_adder1,
        ready_as => ready_adder1
);

U1_FIRST_ADDER: addsubfsm_v6 port map (  
        reset => reset_in,
        clk => clk_in,
        op => op_sel,
        op_a => a_in,
        op_b => b_in,
        start_i => enable_in,
        addsub_out => out_adder2,
        ready_as => ready_adder2
);

U2_FIRST_ADDER: addsubfsm_v6 port map (  
        reset => reset_in,
        clk => clk_in,
        op => op_sel,
        op_a => a_in,
        op_b => b_in,
        start_i => enable_in,
        addsub_out => out_adder3,
        ready_as => ready_adder3
);

all_readys_on <= ready_adder1 and ready_adder2 and ready_adder3;
o_out <= out_temp;
fault_out <= fault_temp;

Voter: process(clk_in,reset_in)
begin
    if reset_in = '1' then
        out_temp <= (others => '0');
        ready_out <= '0';
        fault_temp <= (others => '0');
    elsif rising_edge(clk_in) then
        if ready_after_fault_in = '1' then
            if out_adder1 = out_adder2 and out_adder2 = out_adder3 then
                out_temp <= out_adder1;
                fault_temp <= "000";
            elsif out_adder1 = out_adder2 then
                out_temp <=  out_adder1;
                fault_temp <= "001"; -- fault in the adder 3
            elsif out_adder1 = out_adder3 then
                out_temp <= out_adder1;
                fault_temp <= "010"; -- fault in the adder 2
            elsif out_adder2 = out_adder3 then
                out_temp <= out_adder2;
                fault_temp <= "100"; -- fault in the adder 1
            else
                out_temp <= (others => '0');
                fault_temp <= "111"; -- fault in more than one adder
            end if;
            
        end if;
    end if;
end process;

faultInProcess: process(clk_in,reset_in)
begin
    if reset_in = '1' then
        ready_after_fault_in <= '0';
    elsif rising_edge(clk_in) then
        if all_readys_on <= '1' then
            if fault_in = "01" then -- invert the first adder output
                out_adder1 <= out_adder1(26 downto 9) & not out_adder1(8 downto 7) & out_adder1(6 downto 0);
            elsif fault_in = "10" then -- invert the second adder output
                out_adder2 <= out_adder2(26 downto 9) & not out_adder2(8 downto 7) & out_adder2(6 downto 0);
            elsif fault_in = "11" then -- invert the third adder output
                out_adder3 <= out_adder3(26 downto 9) & not out_adder3(8 downto 7) & out_adder3(6 downto 0);
            end if;
            ready_after_fault_in <= '1';
        end if;
        ready_after_fault_in <= '0';
    end if;
end process;

end Behavioral;
