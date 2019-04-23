----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 09:36:33
-- Design Name: 
-- Module Name: comparator_led_eq_1 - Behavioral
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

entity comparator_led_eq_1 is
    Port ( in_comparator : in STD_LOGIC_VECTOR (15 downto 0);
           led_eq_1 : out STD_LOGIC);
end comparator_led_eq_1;

architecture Behavioral of comparator_led_eq_1 is

begin
p_comparator: process(in_comparator)
begin
    if in_comparator = x"0001" then
        led_eq_1 <= '1';
    else
        led_eq_1 <= '0';
    end if;
end process;

end Behavioral;
