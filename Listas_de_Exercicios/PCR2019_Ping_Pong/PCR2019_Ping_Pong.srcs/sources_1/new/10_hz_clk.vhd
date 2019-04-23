----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 17:39:14
-- Design Name: 
-- Module Name: 10_hz_clk - Behavioral
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

entity clk_10_hz is
    Port ( clk : in STD_LOGIC;
           clk_10 : out STD_LOGIC);
end clk_10_hz;

architecture Behavioral of clk_10_hz is

signal sum: unsigned(23 downto 0);
signal s_clk_out: std_logic := '0';

begin

clk_10 <= s_clk_out;

p1_clk_div: process(clk)
    begin
        if rising_edge(clk) then
            if sum < x"26259F" then
            --if sum < x"9" then
                sum <= sum + 1;
                s_clk_out <= s_clk_out;
            else
                sum <= x"000000";
                s_clk_out <= not s_clk_out;
            end if;
        else
            sum <= sum;
            s_clk_out <= s_clk_out;
        end if;
    end process;



end Behavioral;
