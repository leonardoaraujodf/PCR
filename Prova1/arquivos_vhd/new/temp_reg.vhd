----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 09:39:53
-- Design Name: 
-- Module Name: temp_reg1 - Behavioral
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
use work.fpupack.all;
use work.entities.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temp_reg1 is
    Port ( ld_temp_reg : in STD_LOGIC;
           clr_temp_reg : in STD_LOGIC;
           clk : in STD_LOGIC;
           in_temp_reg : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           out_temp_reg : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end temp_reg1;

architecture Behavioral of temp_reg1 is



begin

p1_temp_reg1: process(clk,clr_temp_reg)
begin
    if clr_temp_reg = '1' then
        out_temp_reg <= SIGMA_K_INIT;
    elsif rising_edge(clk) then
        if ld_temp_reg = '1' then
            out_temp_reg <= in_temp_reg;
        end if;
    end if;
end process;



end Behavioral;
