----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 22:35:09
-- Design Name: 
-- Module Name: inc - Behavioral
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

entity inc is
    Port ( in_inc : in STD_LOGIC_VECTOR (3 downto 0);
           out_inc : out STD_LOGIC_VECTOR (3 downto 0));
end inc;

architecture Behavioral of inc is

begin

out_inc <= std_logic_vector(unsigned(in_inc) + 1);

end Behavioral;
