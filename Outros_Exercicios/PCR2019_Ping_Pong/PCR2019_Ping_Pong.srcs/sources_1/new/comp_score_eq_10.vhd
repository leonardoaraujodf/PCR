----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 23:34:54
-- Design Name: 
-- Module Name: comp_score_eq_10 - Behavioral
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

entity comp_score_eq_10 is
    Port ( in_comp : in STD_LOGIC_VECTOR (3 downto 0);
           out_comp : out STD_LOGIC);
end comp_score_eq_10;

architecture Behavioral of comp_score_eq_10 is

begin
p_comp: process(in_comp)
begin
    if in_comp = "1010" then
        out_comp <= '1';
    else
        out_comp <= '0';    
    end if;
end process;


end Behavioral;
