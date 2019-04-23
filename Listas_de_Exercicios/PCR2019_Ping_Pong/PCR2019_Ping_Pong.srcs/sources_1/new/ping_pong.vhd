----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 23:37:31
-- Design Name: 
-- Module Name: ping_pong - Behavioral
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

entity ping_pong is
    Port ( btnU : in STD_LOGIC;
           btnL : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end ping_pong;

architecture Behavioral of ping_pong is

component top_level_ping_pong is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
           clk: in STD_LOGIC
           );
end component;

component disp_decoder is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component clk_div is
    Port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

signal disp0: STD_LOGIC_VECTOR (3 downto 0);
signal disp1: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal disp2: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal disp3: STD_LOGIC_VECTOR (3 downto 0);
signal on_disp: STD_LOGIC_VECTOR (3 downto 0) := "1001";
signal clk_out: STD_LOGIC;

begin

disp1 <= "0000";
disp2 <= "0000";
on_disp <= "0110";

G1:top_level_ping_pong port map ( 
           start => btnL,
           reset => btnU,
           sw0 => sw0,
           sw15 => sw15,
           score_p1 => disp0,
           score_p2 => disp3,
           out_led => led,
           clk => clk_out
           );

G2: disp_decoder port map(
           disp0 => disp0,
           disp1 => disp1,
           disp2 => disp2,
           disp3 => disp3,
           on_disp => on_disp,
           clk => clk,
           --seg => seg,          
           seg(0) => seg(6),
           seg(1) => seg(5),
           seg(2) => seg(4),
           seg(3) => seg(3),
           seg(4) => seg(2),
           seg(5) => seg(1),
           seg(6) => seg(0),
           an => an
           );

G3: clk_div port map( 
           clk => clk,
           clk_out => clk_out
                    );



end Behavioral;
