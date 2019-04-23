----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2019 12:36:57
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
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
end fsm;

architecture Behavioral of fsm is

type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
signal current_state, next_state : state := s0;

begin

get_state: process(clk,reset)
begin
    if reset = '1' then
        current_state <= s0;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;

change_state: process(current_state,start,reset,sw0,sw15,score_p1_eq_10,score_p2_eq_10,led_eq_1,led_eq_128)
begin
    case current_state is
        when s0 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
            
            if start = '1' then
                next_state <= s1;
            else
                next_state <= s0;
            end if;
            
         when s1 =>
           clr_reg_score_p1 <= '1';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '1';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '1';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
            
           next_state <= s2;
        
        when s2 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '1';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
            
            if sw0 = '1' then
                next_state <= s3;
            else
                next_state <= s2;
            end if;
        
        when s3 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '1';
           sel_led <= '0';
            
           if led_eq_128 = '1' and sw15 = '0' then
                if score_p1_eq_10 = '1' then
                    next_state <= s0;
                else
                    next_state <= s4;
                end if;
           elsif led_eq_128 = '1' and sw15 = '1' then
                next_state <= s5;
           elsif led_eq_128 = '0' and sw15 = '1' then
                  next_state <= s3;
                --next_state <= s9;
           else
                next_state <= s3;
           end if;

        when s4 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '1';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
           
           next_state <= s2;         
           
        when s5 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '1';
           ld_reg_led <= '0';
           sel_led <= '0';
           
           if sw15 = '1' then
                next_state <= s6;
           else
                next_state <= s5;
           end if;
           
        when s6 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '1';
           sel_led <= '1';
           
           if led_eq_1 = '1' and sw0 = '0' then
                if score_p2_eq_10 = '1' then
                    next_state <= s0;
                else
                    next_state <= s7;
                end if;
           elsif led_eq_1 = '1' and sw0 = '1' then
                next_state <= s2;
           elsif led_eq_1 = '0' and sw0 = '1' then
                next_state <= s6;
                --next_state <= s8;
           else
                next_state <= s6;
           end if;

        when s7 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '1';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
           
           next_state <= s5;
           

        when s8 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '1';
           sel_p1 <= '1';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '0';
           sel_p2 <= '0';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
           
           next_state <= s5;
        
        when s9 =>
           clr_reg_score_p1 <= '0';
           ld_reg_score_p1 <= '0';
           sel_p1 <= '0';
           clr_reg_score_p2 <= '0';
           ld_reg_score_p2 <= '1';
           sel_p2 <= '1';
           clr_reg_led1 <= '0';
           clr_reg_led2 <= '0';
           ld_reg_led <= '0';
           sel_led <= '0';
           
           next_state <= s2;      
    end case;
end process;
end Behavioral;
