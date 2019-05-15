----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 22:26:58
-- Design Name: 
-- Module Name: left_shift - Behavioral
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

entity left_shift is
    Port ( in_shift : in STD_LOGIC_VECTOR (15 downto 0);
           out_shift : out STD_LOGIC_VECTOR (15 downto 0));
end left_shift;

architecture Behavioral of left_shift is

begin

out_shift(0) <= '0';
out_shift(15 downto 1) <= in_shift(14 downto 0);

end Behavioral;
