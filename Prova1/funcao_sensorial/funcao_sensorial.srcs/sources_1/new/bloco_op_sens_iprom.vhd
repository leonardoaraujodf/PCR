----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 21:25:27
-- Design Name: 
-- Module Name: bloco_op_sens - Behavioral
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
use work.entities.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bloco_op_sens_iprom is
    Port ( ld_in_cnt : in STD_LOGIC;
           clr_in_cnt : in STD_LOGIC;
           start_sens : in STD_LOGIC;
           reset_sens : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (26 downto 0);
           ready : out STD_LOGIC;
           mem_addr : out STD_LOGIC_VECTOR (6 downto 0);
           in_cnt_eq_100 : out STD_LOGIC);
end bloco_op_sens_iprom;

architecture Behavioral of bloco_op_sens_iprom is

component sensorial is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_ir : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_ul : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end component;

COMPONENT ROM_x_ir
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;

COMPONENT ROM_x_ul
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;

signal x_ir : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal x_ul : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

-- in_cnt signals
signal cnt_value : UNSIGNED (6 downto 0) := (others => '0');
signal mem_addr_temp : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');

begin

U0_ROM_x_ir: ROM_x_ir 
port map(
    clka => clk,
    ena => '1',
    addra => std_logic_vector(cnt_value),
    douta => x_ir
);

U1_ROM_x_ul: ROM_x_ul 
port map(
    clka => clk,
    ena => '1',
    addra => std_logic_vector(cnt_value),
    douta => x_ul
);

U2_SENSORIAL: sensorial port map(
            start => start_sens,
            reset => reset_sens,
            clk => clk,
            x_ir => x_ir,
            x_ul => x_ul,
            x_fus => x_fus,
            ready => ready
);

in_cnt : process(clk,clr_in_cnt)
begin
    if clr_in_cnt = '1' then
        cnt_value <= (others => '0');
    elsif rising_edge(clk) and ld_in_cnt = '1' then
        cnt_value <= cnt_value + 1;
    end if;
end process;

in_cnt_comparator : process(mem_addr_temp)
begin
    if mem_addr_temp = "1100011" then
        in_cnt_eq_100 <= '1';
     else
        in_cnt_eq_100 <= '0';   
    end if;
end process;


mem_addr <= std_logic_vector(cnt_value);
mem_addr_temp <= std_logic_vector(cnt_value);

end Behavioral;
