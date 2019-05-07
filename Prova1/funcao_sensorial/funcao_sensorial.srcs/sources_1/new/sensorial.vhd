----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 09:49:10
-- Design Name: 
-- Module Name: sensorial - Behavioral
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

entity sensorial is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_ir : in STD_LOGIC_VECTOR (26 downto 0);
           x_ul : in STD_LOGIC_VECTOR (26 downto 0);
           x_fus : out STD_LOGIC_VECTOR (26 downto 0);
           ready : out STD_LOGIC_VECTOR (26 downto 0));
end sensorial;

architecture Behavioral of sensorial is

begin


end Behavioral;
