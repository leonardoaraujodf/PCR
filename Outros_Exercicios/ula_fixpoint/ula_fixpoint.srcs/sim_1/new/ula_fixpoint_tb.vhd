----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2019 09:26:15
-- Design Name: 
-- Module Name: ula_fixpoint_tb - Behavioral
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

entity ula_fixpoint_tb is
--  Port ( );
end ula_fixpoint_tb;

architecture Behavioral of ula_fixpoint_tb is

component ula_fixpoint is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0);
           start : in STD_LOGIC;
           btnU : in STD_LOGIC; -- '0' realiza op aritméticas, '1' op lógicas
           led : out STD_LOGIC_VECTOR(15 downto 0);
           ready : out STD_LOGIC);
end component;

signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal sw : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
signal start : STD_LOGIC := '0';
signal btnU : STD_LOGIC := '0';
signal led : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
signal ready :STD_LOGIC := '0';

signal opA : std_logic_vector(6 downto 0) := (others=>'0');
signal opB : std_logic_vector(6 downto 0) := (others=>'0');
signal op : std_logic_vector(2 downto 0) := "000";



begin

uut: ula_fixpoint port map(
           clk => clk,
           reset => reset,
           sw => sw,
           start => start,
           btnU => btnU,
           led => led,
           ready => ready
           );

clk <= not clk after 5 ns; --clk with f = 100 MHz
reset <= '0', '1' after 35 ns, '0' after 55 ns;
start <= '0', '1' after 75 ns, '0' after 85 ns,
              '1' after 175 ns, '0' after 185 ns,
              '1' after 275 ns, '0' after 285 ns,
              '1' after 375 ns, '0' after 385 ns;

opA <= "0010100",
       "0010010" after 175 ns,
       "1100100" after 275 ns,
       "1100001" after 375 ns;

opB <= "0010100",
       "0010100" after 175 ns,
       "1100001" after 275 ns,
       "1100100" after 375 ns;

op <= "000", "001" after 175 ns, "011" after 275 ns, "011" after 375 ns;

sw <= op(1 downto 0) & opB & opA;
btnU <= op(2);


end Behavioral;
