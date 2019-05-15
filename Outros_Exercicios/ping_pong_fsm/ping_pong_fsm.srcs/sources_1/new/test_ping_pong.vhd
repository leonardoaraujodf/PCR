----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 11:02:36
-- Design Name: 
-- Module Name: test_ping_pong - Behavioral
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

entity test_ping_pong is
    Port ( btnU : in STD_LOGIC;
           btnC : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end test_ping_pong;

architecture Behavioral of test_ping_pong is


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

component display_decoder is
    Port ( clk   : in STD_LOGIC;
           disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal out_cnt_score_p1 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal out_cnt_score_p2 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

-- Clock divider process
signal clk_counter : integer := 0;
signal clk_out : std_logic := '0';

begin

clk_10_hz: process(clk)
begin
    if rising_edge(clk) then
        if clk_counter = 5000000 - 1 then
            clk_out <= not clk_out;
        else
            clk_counter <= clk_counter + 1;
        end if;
    end if;
end process;

U0: ping_pong port map(
           start => btnU,
           reset => btnC,
           sw0 => sw0,
           sw15 => sw15,
           clk => clk_out,
           led => led,
           out_cnt_score_p1 => out_cnt_score_p1, 
           out_cnt_score_p2 => out_cnt_score_p2
            );
            
U1: display_decoder port map(
           clk => clk,
           disp0 => out_cnt_score_p1,
           disp1 => "0000",
           disp2 => "0000",
           disp3 => out_cnt_score_p2,
           on_disp => "0110",
           seg => seg,
           an => an
           );


end Behavioral;
