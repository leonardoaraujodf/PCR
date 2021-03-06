----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2019 06:01:45
-- Design Name: 
-- Module Name: ula_fixpoint - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Deion: 
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ula_fixpoint is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0);
           start : in STD_LOGIC;
           btnU : in STD_LOGIC; -- '0' realiza op aritm�ticas, '1' op l�gicas
           led : out STD_LOGIC_VECTOR(15 downto 0);
           ready : out STD_LOGIC);
end ula_fixpoint;

architecture Behavioral of ula_fixpoint is

type t_state is (waiting,add,sub,mul,div,land,lor,shiftlr,shiftll,checkSignal);
signal next_state, current_state : t_state;

signal opA : std_logic_vector(6 downto 0) := (others=>'0');
signal opB : std_logic_vector(6 downto 0) := (others=>'0');
signal op : std_logic_vector(2 downto 0) := "000";

signal outAddSub : std_logic_vector(6 downto 0) := (others=>'0');
signal outMul : std_logic_vector(13 downto 0) := (others=>'0');
signal outDiv : std_logic_vector(13 downto 0) := (others=>'0');
signal result : std_logic_vector(15 downto 0) := (others=>'0');

begin

	-- processo para armazenar o estado
	process(clk,reset)
	begin
		if reset='1' then
			current_state <= waiting;
		elsif rising_edge(clk) then
			current_state <= next_state;
		end if;
	end process;
	
	-- processo combi para transi��o de estados
	process(current_state,op,start)
	begin
		case current_state is
			when waiting =>
				if start='1' and op="000" then
					next_state <= add;
				elsif start='1' and op="001" then
					next_state <= sub;
				elsif start='1' and op="010" then
					next_state <= mul;
				elsif start='1' and op="011" then
					next_state <= div;
				elsif start='1' and op="100" then
					next_state <= land;
				elsif start='1' and op="101" then
					next_state <= lor;
				elsif start='1' and op="110" then
					next_state <= shiftlr;
				elsif start='1' and op="111" then
					next_state <= shiftll;						
				else
					next_state <= waiting;
				end if;
			when add => next_state <= checkSignal;
			when sub => next_state <= checkSignal;
			when mul => next_state <= checkSignal;
			when div => next_state <= checkSignal;
			when checksignal => next_state <= waiting;
			when land => next_state <= waiting;
			when lor => next_state <= waiting;
			when shiftlr => next_state <= waiting;
			when shiftll => next_state <= waiting;
			when others => next_state <= waiting;
		end case;
	end process;
	
	-- processo sequencial para saidas
	process(clk,reset)
	begin
		if reset='1' then
			result <= (others=>'0');
			outAddSub <= (others=>'0');
			outMul <= (others=>'0');
			outDiv <= (others=>'0');
			ready <= '0';
		elsif rising_edge(clk) then
			case current_state is
				when add =>
					outAddSub <= opA + opB;
					ready <= '0';
					
				when sub =>
					outAddSub <= opA - opB;
					ready <= '0';
					
				when mul =>
					outMul <= opA * opB;
					ready <= '0';
					
				when div =>
					outDiv <= opA * opB;
					ready <= '0';
					
				when checkSignal =>
					ready <= '1';
					if op="000" or op="001"then
						if outAddSub(6) = '1' then
							result <= "111111111"&(not outAddSub + 1);
						else
							result <= "000000000" & outAddSub;
						end if;
					elsif op="010" then
						if outMul(13) = '1' then
							result <= "11" & (not outMul + 1);
						else
							result <= "00" & outMul;
						end if;
					elsif op="011" then
						if outDiv(13) = '1' then
							result <= "11" & (not outDiv + 1);
						else
							result <= "00" & outDiv;
						end if;
					end if;
					
				when land => 
					result <= "000000000" & (opA and opB);
					ready <= '1';
					
				when lor => 
					result <= "000000000" & (opA or opB);
					ready <= '1';
					
				when shiftlr => 
					result <= "000000000" & ('0'&opA(6 downto 1));
					ready <= '1';
					
				when shiftll => 
					result <= "000000000" & (opA(5 downto 0)&'0');
					ready <= '1';
					
				when others => 
					result <= (others=>'0');
					ready <= '0';
			end case;
		end if;
	end process;
	
	opA <= sw(6 downto 0);
	opB <= sw(13 downto 7);
	op <= btnU & sw(15 downto 14);
	led <= result;
end Behavioral;









