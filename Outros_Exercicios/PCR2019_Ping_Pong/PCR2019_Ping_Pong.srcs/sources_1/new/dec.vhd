----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 22:59:22
-- Design Name: 
-- Module Name: dec - Behavioral
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

entity dec is
    Port ( in_dec : in STD_LOGIC_VECTOR (3 downto 0);
           out_dec : out STD_LOGIC_VECTOR (3 downto 0));
end dec;

architecture Behavioral of dec is

begin

out_dec <= std_logic_vector(unsigned(in_dec) - 1);

end Behavioral;
