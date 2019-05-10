----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 23:40:47
-- Design Name: 
-- Module Name: sens_top_level - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sens_top_level is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           mem_addr : out STD_LOGIC_VECTOR (6 downto 0));
end sens_top_level;

architecture Behavioral of sens_top_level is

component fsm_sens is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : in STD_LOGIC;
           clk   : in STD_LOGIC;
           in_cnt_eq_100 : in STD_LOGIC;
           ld_in_cnt : out STD_LOGIC;
           clr_in_cnt : out STD_LOGIC;
           start_sens : out STD_LOGIC;
           reset_sens : out STD_LOGIC);
end component;

component bloco_op_sens is
    Port ( ld_in_cnt : in STD_LOGIC;
           clr_in_cnt : in STD_LOGIC;
           start_sens : in STD_LOGIC;
           reset_sens : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (26 downto 0);
           ready : out STD_LOGIC;
           mem_addr : out STD_LOGIC_VECTOR (6 downto 0);
           in_cnt_eq_100 : out STD_LOGIC);
end component;

signal ld_in_cnt : STD_LOGIC := '0';
signal clr_in_cnt : STD_LOGIC := '0';
signal start_sens : STD_LOGIC := '0';
signal reset_sens : STD_LOGIC := '0';
signal ready : STD_LOGIC := '0';
signal in_cnt_eq_100 : STD_LOGIC := '0';

begin

U0: fsm_sens port map (
           start => start,
           reset => reset,
           ready => ready,
           clk   => clk,
           in_cnt_eq_100 => in_cnt_eq_100,
           ld_in_cnt => ld_in_cnt,
           clr_in_cnt => clr_in_cnt,
           start_sens => start_sens,
           reset_sens => reset_sens
           );

U1: bloco_op_sens port map (
           ld_in_cnt => ld_in_cnt,
           clr_in_cnt => clr_in_cnt,
           start_sens => start_sens,
           reset_sens => reset_sens,
           clk => clk,
           x_fus => x_fus,
           ready => ready,
           mem_addr => mem_addr,
           in_cnt_eq_100 => in_cnt_eq_100 
           );

end Behavioral;
