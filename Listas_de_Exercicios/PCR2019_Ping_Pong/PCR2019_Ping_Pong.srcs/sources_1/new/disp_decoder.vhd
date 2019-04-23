----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2019 14:24:05
-- Design Name: 
-- Module Name: disp_decoder - Behavioral
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

entity disp_decoder is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end disp_decoder;

architecture Behavioral of disp_decoder is

component bin_to_7seg is
    Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component clk_div_deco is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component cnt_deco is
    Port ( clk : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component mux_an is
    Port ( on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component mux_disp is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           bin : out STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

signal sel: STD_LOGIC_VECTOR(1 downto 0);
signal bin: STD_LOGIC_VECTOR (3 downto 0);
signal clk_out: STD_LOGIC;

begin

G1:mux_disp port map( 
           disp0 => disp0,
           disp1 => disp1,
           disp2 => disp2,
           disp3 => disp3,
           sel => sel,
           bin => bin
           );
           
G2:bin_to_7seg port map(
            bin => bin,
            seg => seg
            );

G3: mux_an port map(
            on_disp => on_disp,
            sel => sel,
            an => an
            );

G4: cnt_deco port map(
            sel => sel,
            clk => clk_out
            );
            
G5: clk_div_deco port map(
            clk => clk,
            clk_out => clk_out
            );

end Behavioral;
