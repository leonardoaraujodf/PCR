----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2019 13:41:18
-- Design Name: 
-- Module Name: top_level_ping_pong - Behavioral
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

entity top_level_ping_pong is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
           clk: in STD_LOGIC
           );
end top_level_ping_pong;

architecture Behavioral of top_level_ping_pong is

component op_block is
    Port ( clr_reg_score_p1 : in STD_LOGIC;
           ld_reg_score_p1 : in STD_LOGIC;
           sel_p1 : in STD_LOGIC;
           clr_reg_score_p2 : in STD_LOGIC;
           ld_reg_score_p2 : in STD_LOGIC;
           sel_p2 : in STD_LOGIC;
           clr_reg_led1 : in STD_LOGIC;
           clr_reg_led2 : in STD_LOGIC;
           ld_reg_led : in STD_LOGIC;
           sel_led : in STD_LOGIC;
           clk : in STD_LOGIC;
           score_p1_eq_10 : out STD_LOGIC;
           score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p2_eq_10 : out STD_LOGIC;
           score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
           led_eq_1 : out STD_LOGIC;
           led_eq_128 : out STD_LOGIC);
end component;

component fsm is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk: in STD_LOGIC;
           clr_reg_score_p1 : out STD_LOGIC;
           ld_reg_score_p1: out STD_LOGIC;
           sel_p1: out STD_LOGIC;
           clr_reg_score_p2 : out STD_LOGIC;
           ld_reg_score_p2 : out STD_LOGIC;
           sel_p2: out STD_LOGIC;
           clr_reg_led1: out STD_LOGIC;
           clr_reg_led2: out STD_LOGIC;
           ld_reg_led: out STD_LOGIC;
           sel_led: out STD_LOGIC;
           score_p1_eq_10: in STD_LOGIC;
           score_p2_eq_10: in STD_LOGIC;
           led_eq_1: in STD_LOGIC;
           led_eq_128: in STD_LOGIC
           );
end component;


signal clr_reg_score_p1 : STD_LOGIC;
signal ld_reg_score_p1 : STD_LOGIC;
signal sel_p1 : STD_LOGIC;
signal clr_reg_score_p2 : STD_LOGIC;
signal ld_reg_score_p2 : STD_LOGIC;
signal sel_p2 : STD_LOGIC;
signal clr_reg_led1 : STD_LOGIC;
signal clr_reg_led2 : STD_LOGIC;
signal ld_reg_led : STD_LOGIC;
signal sel_led : STD_LOGIC;
signal score_p1_eq_10 : STD_LOGIC;
signal score_p2_eq_10 : STD_LOGIC;
signal led_eq_1 : STD_LOGIC;
signal led_eq_128 : STD_LOGIC;

begin

G1: op_block port map ( 
           clr_reg_score_p1 => clr_reg_score_p1, 
           ld_reg_score_p1 => ld_reg_score_p1,
           sel_p1 => sel_p1,
           clr_reg_score_p2 => clr_reg_score_p2,  
           ld_reg_score_p2 => ld_reg_score_p2,
           sel_p2 => sel_p2,
           clr_reg_led1 => clr_reg_led1, 
           clr_reg_led2 => clr_reg_led2,
           ld_reg_led => ld_reg_led,
           sel_led => sel_led,
           clk => clk,
           score_p1_eq_10 => score_p1_eq_10, 
           score_p1 => score_p1,
           score_p2_eq_10 => score_p2_eq_10, 
           score_p2 => score_p2,
           out_led => out_led,
           led_eq_1 => led_eq_1,
           led_eq_128 => led_eq_128 
                    );
G2: fsm port map (
           start => start, 
           reset => reset,
           sw0 => sw0,
           sw15 => sw15,
           clk => clk,
           clr_reg_score_p1 => clr_reg_score_p1,
           ld_reg_score_p1 => ld_reg_score_p1,
           sel_p1 => sel_p1,
           clr_reg_score_p2 => clr_reg_score_p2,
           ld_reg_score_p2 => ld_reg_score_p2,
           sel_p2 => sel_p2,
           clr_reg_led1 => clr_reg_led1,
           clr_reg_led2 => clr_reg_led2,
           ld_reg_led => ld_reg_led,
           sel_led => sel_led,
           score_p1_eq_10 => score_p1_eq_10,
           score_p2_eq_10 => score_p2_eq_10,
           led_eq_1 => led_eq_1,
           led_eq_128 => led_eq_128
                );



end Behavioral;
