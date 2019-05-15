----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2019 22:31:51
-- Design Name: 
-- Module Name: teste_neuronio_gmbh - Behavioral
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

entity teste_neuronio_gmbh is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end teste_neuronio_gmbh;

architecture Behavioral of teste_neuronio_gmbh is

component neuronio_gmbh is
    Port ( start : in STD_LOGIC;
           clk: in STD_LOGIC;
           reset: in STD_LOGIC;
           x : in std_logic_vector(FP_WIDTH-1 downto 0);
           a: in std_logic_vector(FP_WIDTH-1 downto 0);
           b: in std_logic_vector(FP_WIDTH-1 downto 0);
           c: in std_logic_vector(FP_WIDTH-1 downto 0);
           out_neuron: out std_logic_vector(FP_WIDTH-1 downto 0);   
           ready : out STD_LOGIC);
end component;

signal ready : std_logic := '0';

-- mux 1 signals

signal out_mux_1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

-- mux 2 signals

signal in_mux_2 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

begin

U0: neuronio_gmbh port map(
           start => btnL,
           clk => clk,
           reset => btnR,
           x => out_mux_1,
           a => "001111111000000000000000000",
           b => "010000000000000000000000000",
           c => "001111111000000000000000000",
           out_neuron => in_mux_2, 
           ready => ready
           );


mux_1 : process(btnU)
begin
    if btnU = '0' then
        out_mux_1 <= sw(15 downto 0) & "00000000000";
    else
        out_mux_1 <= "00000000000" & sw(15 downto 0);
    end if;
end process;

mux_2 : process(btnD)
begin
    if btnD = '0' then
        led <= in_mux_2(26 downto 11);
    else
        led <= in_mux_2(10 downto 0) & "00000";
    end if;
end process;


end Behavioral;
