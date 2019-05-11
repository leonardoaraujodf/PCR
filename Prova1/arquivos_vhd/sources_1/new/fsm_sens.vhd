----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 23:14:37
-- Design Name: 
-- Module Name: fsm_sens - Behavioral
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

entity fsm_sens is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready : in STD_LOGIC;
           clk   : in STD_LOGIC;
           in_cnt_eq_100 : in STD_LOGIC;
           ld_in_cnt : out STD_LOGIC;
           clr_in_cnt : out STD_LOGIC;
           start_sens : out STD_LOGIC;
           reset_sens : out STD_LOGIC);
end fsm_sens;

architecture Behavioral of fsm_sens is

type state is (inicio,espera,carregar_entradas,enviar_entradas,espera_saida,recomecar);
signal current_state, next_state : state := inicio;

begin

get_state : process(clk,reset)
begin
    if reset = '1' then
        current_state <= inicio;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;

change_state : process(current_state,start,reset,ready,in_cnt_eq_100)
begin
    case current_state is
        when inicio =>
            clr_in_cnt <= '1';
            ld_in_cnt  <= '0';
            reset_sens <= '1';
            start_sens <= '0';
            
            next_state <= espera;
            
        when espera =>
            clr_in_cnt <= '0';
            ld_in_cnt  <= '0';
            reset_sens <= '0';
            start_sens <= '0';
            
            if start = '1' then
                next_state <= enviar_entradas;
            else
                next_state <= espera;
            end if;
        
        when enviar_entradas =>
            clr_in_cnt <= '0';
            ld_in_cnt  <= '0';
            reset_sens <= '0';
            start_sens <= '1';
            
            next_state <= espera_saida;

        when espera_saida =>
            clr_in_cnt <= '0';
            ld_in_cnt  <= '0';
            reset_sens <= '0';
            start_sens <= '0';

            if in_cnt_eq_100 = '1' and ready = '1' then
                next_state <= recomecar;
            elsif ready = '1' then
                next_state <= carregar_entradas;
            else
                next_state <= espera_saida;
            end if;
        
        when carregar_entradas =>    
            clr_in_cnt <= '0';
            ld_in_cnt  <= '1';
            reset_sens <= '0';
            start_sens <= '0';
            
            next_state <= enviar_entradas;
        
        when recomecar =>
            clr_in_cnt <= '1';
            ld_in_cnt  <= '0';
            reset_sens <= '1';
            start_sens <= '0';
            
            next_state <= enviar_entradas;
                                
    end case;
end process;
end Behavioral;
