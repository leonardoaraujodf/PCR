----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 00:18:48
-- Design Name: 
-- Module Name: fsm_ping_pong - Behavioral
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

entity fsm_ping_pong is
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
end fsm_ping_pong;

architecture Behavioral of fsm_ping_pong is

type state is (s0,s1,s2,s3,s4,s5,s6,s7);
signal current_state, next_state : state := s0;

begin

get_state: process(clk,reset)
begin
    if reset = '1' then
        current_state <= s0;
    elsif rising_edge(clk) then
        current_state <= next_state;
    else
        current_state <= current_state;
    end if;
end process;

change_state: process(current_state,start,sw0,sw15,leds_eq_init,leds_eq_end,leds_gt_half,score_p1_eq_9,score_p2_eq_9)
begin
    case current_state is
        when s0 =>
            ld_reg_leds <= '0';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';
            
            if start = '1' then
                next_state <= s1;
            else
                next_state <= s0;
            end if;
        when s1 =>
            ld_reg_leds <= '0';
            clr1_reg_leds <= '1';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '1';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '1';        
            
            next_state <= s2;
            
        when s2 =>    
            ld_reg_leds <= '0';
            clr1_reg_leds <= '1';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';        
            
            if score_p1_eq_9 = '1' then
                next_state <= s0;
            elsif sw0 = '1' then
                next_state <= s3;
            else
                next_state <= s2;
            end if;
            
        when s3 =>
            ld_reg_leds <= '1';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';        
            
            if (leds_eq_end = '1' and sw15 = '0') or (leds_gt_half = '0' and sw15 = '1') then
                next_state <= s4;
            elsif leds_eq_end = '1' and sw15 = '1' then
                next_state <= s5;
            else
                next_state <= s3;
            end if;
        when s4 =>
            ld_reg_leds <= '0';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '1';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';

            next_state <= s2;
            
        when s5 =>    
            ld_reg_leds <= '0';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '1';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';
            
            if score_p2_eq_9 = '1' then
                next_state <= s0;
            elsif sw15 = '1' then
                next_state <= s6;
            end if;
        when s6 =>    
            ld_reg_leds <= '1';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '0';
            shifter_sel <= '1';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '0';
            clr_cnt_score_p2 <= '0';
            
            if (leds_eq_init = '1' and sw0 = '0') or (leds_gt_half = '1' and sw0 = '1') then
                next_state <= s7;
            elsif leds_eq_init = '1' and sw0 = '1' then
                next_state <= s2;
            else
                next_state <= s6;
            end if;
        
        when s7 =>
            ld_reg_leds <= '0';
            clr1_reg_leds <= '0';
            clr2_reg_leds <= '0';
            shifter_sel <= '0';
            ld_cnt_score_p1 <= '0';
            clr_cnt_score_p1 <= '0';
            ld_cnt_score_p2 <= '1';
            clr_cnt_score_p2 <= '0';
        
            next_state <= s5;
        
    end case;
end process;    
end Behavioral;
