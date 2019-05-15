----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 16:47:42
-- Design Name: 
-- Module Name: mux_disp - Behavioral
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

entity mux_disp is
    Port ( disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp: in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           bin : out STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end mux_disp;

architecture Behavioral of mux_disp is

begin

p1_mux_disp: process(sel,disp0,disp1,disp2,disp3,on_disp)
begin
    case sel is
        when "00" =>
            bin <= disp0;
            an(0) <= on_disp(0);
            an(1) <= '1';
            an(2) <= '1';
            an(3) <= '1';
        when "01" =>
            bin <= disp1;
            an(0) <= '1';
            an(1) <= on_disp(1);
            an(2) <= '1';
            an(3) <= '1';
        when "10" =>
            bin <= disp2;
            an(0) <= '1';
            an(1) <= '1';
            an(2) <= on_disp(2);
            an(3) <= '1';
        when "11" =>
            bin <= disp3;
            an(0) <= '1';
            an(1) <= '1';
            an(2) <= '1';
            an(3) <= on_disp(3);
        when others =>
            bin <= disp0;
            an <= "1111";         
    end case;    
end process;

end Behavioral;
