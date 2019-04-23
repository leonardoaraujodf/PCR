----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 17:11:53
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_decoder is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end display_decoder;

architecture Behavioral of display_decoder is

component deco is
    Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component mux_disp is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp: in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           bin : out STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component cnt_deco is
    Port ( clk_cnt : in STD_LOGIC;
           out_cnt : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component clk_div is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

signal out_cnt: STD_LOGIC_VECTOR(1 downto 0);
signal bin: STD_LOGIC_VECTOR(3 downto 0);
signal clk_out: STD_LOGIC;

begin

G1: mux_disp port map( 
           disp0 => disp0,
           disp1 => disp1,
           disp2 => disp2,
           disp3 => disp3,
           on_disp => on_disp,
           sel => out_cnt, 
           bin => bin,
           an => an);
           
G2: deco port map(
           bin => bin,
           seg => seg
                );
                
G3: clk_div port map(
           clk => clk,
           clk_out => clk_out
            );

G4: cnt_deco port map(
           clk_cnt => clk_out,
           out_cnt => out_cnt
                    );


end Behavioral;
