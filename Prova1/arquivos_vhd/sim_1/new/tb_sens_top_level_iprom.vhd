----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2019 12:16:08
-- Design Name: 
-- Module Name: tb_sens_top_level_iprom - Behavioral
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

entity tb_sens_top_level_iprom is
--  Port ( );
end tb_sens_top_level_iprom;

architecture Behavioral of tb_sens_top_level_iprom is

component sens_top_level_iprom is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           mem_addr : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal start : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal clk : STD_LOGIC := '0';
signal x_fus : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal mem_addr : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');

begin


U0: sens_top_level_iprom port map(
           start => start,
           reset => reset,
           clk   => clk,
           x_fus => x_fus,
           mem_addr => mem_addr
           );

-- reset generator

reset <= '0', '1' after 15 ns, '0' after 25 ns;

-- clock generator

clk <= not clk after 5 ns;

-- first start

start <= '0', '1' after 55 ns, '0' after 65 ns;

end Behavioral;
