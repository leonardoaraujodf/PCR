----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2019 14:16:03
-- Design Name: 
-- Module Name: display_decoder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_decoder is
    Port ( clk   : in STD_LOGIC;
           disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end display_decoder;

architecture Behavioral of display_decoder is

-- Clock divider signals
signal clk_div_cnt : integer := 0;
signal clk_out : STD_LOGIC := '0';

-- Decoder Counter
signal counter_value : unsigned (1 downto 0) := "00";

-- Decoder signals
signal bin : std_logic_vector (3 downto 0) := (others => '0');

begin

clk_200_hz: process(clk)
begin
    if rising_edge(clk) then
        if clk_div_cnt = 250000-1 then
        --if clk_div_cnt = 10-1 then
            clk_div_cnt <= 0;
            clk_out <= not clk_out;
        else
            clk_div_cnt <= clk_div_cnt + 1;
            clk_out <= clk_out; 
        end if;
    end if;
end process;

deco_cnt : process(clk_out)
begin
    if rising_edge(clk_out) then
        counter_value <= counter_value + 1;
    end if;
end process;

disp_mux : process(counter_value)
begin
    if counter_value = 00 then
        bin <= disp0;
        an(0) <= on_disp(0);
        an(1) <= '1';
        an(2) <= '1';
        an(3) <= '1';
        
    elsif counter_value = 01 then
        bin <= disp1;
        an(0) <= '1';
        an(1) <= on_disp(1);
        an(2) <= '1';
        an(3) <= '1';

    elsif counter_value = 10 then
        bin <= disp2;
        an(0) <= '1';
        an(1) <= '1';
        an(2) <= on_disp(2);
        an(3) <= '1';
        
    else
        bin <= disp3;
        an(0) <= '1';
        an(1) <= '1';
        an(2) <= '1';
        an(3) <= on_disp(3);        
    end if;
end process;

deco_process: process(bin)
begin
    case bin is
        when "0000" => seg <= "0000001"; -- "0"     
        when "0001" => seg <= "1001111"; -- "1" 
        when "0010" => seg <= "0010010"; -- "2" 
        when "0011" => seg <= "0000110"; -- "3" 
        when "0100" => seg <= "1001100"; -- "4" 
        when "0101" => seg <= "0100100"; -- "5" 
        when "0110" => seg <= "0100000"; -- "6" 
        when "0111" => seg <= "0001111"; -- "7" 
        when "1000" => seg <= "0000000"; -- "8"     
        when "1001" => seg <= "0000100"; -- "9" 
        when "1010" => seg <= "0000010"; -- a
        when "1011" => seg <= "1100000"; -- b
        when "1100" => seg <= "0110001"; -- C
        when "1101" => seg <= "1000010"; -- d
        when "1110" => seg <= "0110000"; -- E
        when "1111" => seg <= "0111000"; -- F
        when others => seg <= "1111111";
    end case;
end process;


end Behavioral;
