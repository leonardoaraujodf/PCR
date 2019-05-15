----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 09:56:57
-- Design Name: 
-- Module Name: tb_ping_pong - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ping_pong is
--  Port ( );
end tb_ping_pong;

architecture Behavioral of tb_ping_pong is

component ping_pong is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           out_cnt_score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           out_cnt_score_p2 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal start : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal sw0 : STD_LOGIC := '0';
signal sw15 : STD_LOGIC := '0';
signal clk : STD_LOGIC := '0';
signal led : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal out_cnt_score_p1 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal out_cnt_score_p2 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

U1: ping_pong port map(
           start => start,
           reset => reset,
           sw0 => sw0,
           sw15 => sw15,
           clk => clk,
           led => led,
           out_cnt_score_p1 => out_cnt_score_p1,
           out_cnt_score_p2 => out_cnt_score_p2 );

clk <= not clk after 5 ns;
reset <= '0', '1' after 25 ns, '0' after 45 ns;
start <= '0', '1' after 55 ns, '0' after 75 ns;

sw0 <= '0', '1' after 85 ns, '0' after 105 ns, '1' after 265 ns, '0' after 285 ns, '1' after 325 ns, '0' after 345 ns, 
'1' after 1455 ns, '0' after 1475 ns;

sw15 <= '0', '1' after 300 ns, '0' after 315 ns, '1' after 485 ns, '0' after 505 ns, '1' after 675 ns, '0' after 695 ns, 
'1' after 865 ns, '0' after 885 ns, '1' after 1055 ns, '0' after 1075 ns, '1' after 1235 ns, '0' after 1255 ns, '1' after 1415 ns, 
'0' after 1435 ns, '1' after 1485 ns, '0' after 1505 ns, '1' after 1665 ns, '0' after 1685 ns, '1' after 1845 ns, '0' after 1865 ns;




end Behavioral;
