----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 09:36:59
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
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           out_cnt_score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           out_cnt_score_p2 : out STD_LOGIC_VECTOR (3 downto 0));
end ping_pong;

architecture Behavioral of ping_pong is

component fsm_ping_pong is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           ld_reg_leds : out STD_LOGIC;
           clr1_reg_leds : out STD_LOGIC;
           clr2_reg_leds : out STD_LOGIC;
           shifter_sel : out STD_LOGIC;
           ld_cnt_score_p1 : out STD_LOGIC;
           clr_cnt_score_p1 : out STD_LOGIC;
           ld_cnt_score_p2 : out STD_LOGIC;
           clr_cnt_score_p2 : out STD_LOGIC;
           leds_eq_init : in STD_LOGIC;
           leds_eq_end : in STD_LOGIC;
           leds_gt_half : in STD_LOGIC;
           score_p1_eq_9 : in STD_LOGIC;
           score_p2_eq_9 : in STD_LOGIC);
end component;

component op_block_ping_pong is
    Port ( clk : in STD_LOGIC;
           ld_reg_leds : in STD_LOGIC;
           clr1_reg_leds : in STD_LOGIC;
           clr2_reg_leds : in STD_LOGIC;
           out_reg_leds : out STD_LOGIC_VECTOR (15 downto 0);
           shifter_sel : in STD_LOGIC;
           leds_eq_init : out STD_LOGIC;
           leds_eq_end : out STD_LOGIC;
           leds_gt_half : out STD_LOGIC;
           ld_cnt_score_p1 : in STD_LOGIC;
           clr_cnt_score_p1 : in STD_LOGIC;
           out_cnt_score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           ld_cnt_score_p2 : in STD_LOGIC;
           clr_cnt_score_p2 : in STD_LOGIC;
           out_cnt_score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p1_eq_9 : out STD_LOGIC;
           score_p2_eq_9 : out STD_LOGIC
           );
end component;

signal ld_reg_leds : STD_LOGIC := '0';
signal clr1_reg_leds : STD_LOGIC := '0';
signal clr2_reg_leds : STD_LOGIC := '0';
signal shifter_sel : STD_LOGIC := '0';
signal leds_eq_init : STD_LOGIC := '0';
signal leds_eq_end : STD_LOGIC := '0';
signal leds_gt_half : STD_LOGIC := '0';
signal ld_cnt_score_p1 : STD_LOGIC := '0';
signal clr_cnt_score_p1 : STD_LOGIC := '0';
signal ld_cnt_score_p2 : STD_LOGIC := '0';
signal clr_cnt_score_p2 : STD_LOGIC := '0';
signal score_p1_eq_9 : STD_LOGIC := '0';
signal score_p2_eq_9 : STD_LOGIC := '0';

begin

U0: fsm_ping_pong port map(
           start => start,
           reset => reset,
           clk => clk,
           sw0 => sw0,
           sw15 => sw15,
           ld_reg_leds => ld_reg_leds,
           clr1_reg_leds => clr1_reg_leds,
           clr2_reg_leds => clr2_reg_leds,
           shifter_sel => shifter_sel,
           ld_cnt_score_p1 => ld_cnt_score_p1,
           clr_cnt_score_p1 => clr_cnt_score_p2,
           ld_cnt_score_p2 => ld_cnt_score_p2,
           clr_cnt_score_p2 => clr_cnt_score_p2,
           leds_eq_init => leds_eq_init,
           leds_eq_end => leds_eq_end,
           leds_gt_half => leds_gt_half, 
           score_p1_eq_9 => score_p1_eq_9, 
           score_p2_eq_9 => score_p2_eq_9 
           );

U1: op_block_ping_pong port map(
           clk => clk,
           ld_reg_leds => ld_reg_leds,
           clr1_reg_leds => clr1_reg_leds,
           clr2_reg_leds => clr2_reg_leds, 
           out_reg_leds => led,
           shifter_sel => shifter_sel, 
           leds_eq_init => leds_eq_init, 
           leds_eq_end => leds_eq_end,
           leds_gt_half => leds_gt_half, 
           ld_cnt_score_p1 => ld_cnt_score_p1, 
           clr_cnt_score_p1 => clr_cnt_score_p1, 
           out_cnt_score_p1 => out_cnt_score_p1, 
           ld_cnt_score_p2 => ld_cnt_score_p2, 
           clr_cnt_score_p2 => clr_cnt_score_p2, 
           out_cnt_score_p2 => out_cnt_score_p2, 
           score_p1_eq_9 => score_p1_eq_9, 
           score_p2_eq_9 => score_p2_eq_9
           );



end Behavioral;
