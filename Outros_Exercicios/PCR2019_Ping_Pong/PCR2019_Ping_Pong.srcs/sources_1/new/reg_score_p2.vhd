----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 08:55:27
-- Design Name: 
-- Module Name: reg_score_p1 - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_score_p2 is
    Port ( in_reg : in STD_LOGIC_VECTOR (3 downto 0);
           out_reg : out STD_LOGIC_VECTOR (3 downto 0) := "0000";
           clr_reg_score_p2 : in STD_LOGIC;
           ld_reg_score_p2 : in STD_LOGIC;
           clk : in STD_LOGIC);
end reg_score_p2;

architecture Behavioral of reg_score_p2 is

begin
p_reg: process(clk,clr_reg_score_p2)
begin
    if clr_reg_score_p2 = '1' then
        out_reg <= (others => '0');
    elsif rising_edge(clk) and ld_reg_score_p2 = '1' then
        out_reg <=  in_reg;
    end if;    
end process;

end Behavioral;
