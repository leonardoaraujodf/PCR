----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 08:42:04
-- Design Name: 
-- Module Name: mux_2x1_4bits - Behavioral
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

entity mux_2x1_8bits is
    Port ( in1_mux : in STD_LOGIC_VECTOR (15 downto 0);
           in2_mux : in STD_LOGIC_VECTOR (15 downto 0);
           out_mux : out STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC);
end mux_2x1_8bits;

architecture Behavioral of mux_2x1_8bits is

begin

p_mux:process(in1_mux,in2_mux,sel)
begin
    case sel is
        when '0' => out_mux <= in1_mux;
        when '1' => out_mux <= in2_mux;
        when others => out_mux <= in1_mux;
    end case;
end process p_mux;

end Behavioral;
