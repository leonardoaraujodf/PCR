----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 16:56:39
-- Design Name: 
-- Module Name: cnt_deco - Behavioral
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

entity cnt_deco is
    Port ( clk_cnt : in STD_LOGIC;
           out_cnt : out STD_LOGIC_VECTOR (1 downto 0));
end cnt_deco;

architecture Behavioral of cnt_deco is

signal sum: unsigned (1 downto 0) := "00";

begin

    out_cnt <= std_logic_vector(sum);

    p1_cnt:process(clk_cnt)
    begin
        if rising_edge(clk_cnt) then
            sum <= sum + 1;
        else
            sum <= sum;
        end if;
        
    end process;

end Behavioral;
