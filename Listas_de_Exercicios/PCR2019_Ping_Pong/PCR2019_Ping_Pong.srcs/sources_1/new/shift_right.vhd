----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 22:11:05
-- Design Name: 
-- Module Name: shift_right - Behavioral
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

entity shift_right is
    Port ( in_shift : in STD_LOGIC_VECTOR (15 downto 0);
           out_shift : out STD_LOGIC_VECTOR (15 downto 0));
end shift_right;

architecture Behavioral of shift_right is

begin

out_shift(14 downto 0) <= in_shift(15 downto 1);
out_shift(15) <= '0';

end Behavioral;
