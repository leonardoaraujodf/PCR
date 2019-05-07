----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2019 09:41:19
-- Design Name: 
-- Module Name: clockdiv10Hz - Behavioral
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
use IEEE.numeric_std.ALL;

entity clockdiv10Hz is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           led : out STD_LOGIC);
end clockdiv10Hz;

architecture Behavioral of clockdiv10Hz is

constant preset : std_logic_vector(22 downto 0) := "10011000100101101000000";
signal cnt : std_logic_vector(22 downto 0) := (others=>'0');
signal clkaux : std_logic := '0';

begin

led <= clkaux;
	
	-- process para dividir clock a 10 hz
	process(clk,reset)
	begin
		if reset='1' then
			cnt <= (others=> '0');
			clkaux <= '0';
		elsif rising_edge(clk) then
			if en = '1' then
				if cnt = preset then
				 	clkaux <= not clkaux;
				 	cnt <= (others=> '0');
				else
					cnt <= cnt + 1;
				end if;
			end if;
		end if;
	end process;

end Behavioral;
