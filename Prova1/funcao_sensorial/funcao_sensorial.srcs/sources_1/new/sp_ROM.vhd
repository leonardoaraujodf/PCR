----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 13:21:22
-- Design Name: 
-- Module Name: sp_ROM - Behavioral
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
use IEEE.numeric_std.all;
library std;
use std.textio.all;
use IEEE.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sp_ROM is
generic (initFile : string);
    Port ( clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR;
           dataout : out STD_LOGIC_VECTOR);
end sp_ROM;

architecture Behavioral of sp_ROM is

type romType is array(0 to 2**address'length-1) of std_logic_vector(dataout'length-1 downto 0);

impure function initRomFromFile return romType is
    file data_file : text open read_mode is initFile;
    variable data_fileLine : line;
    variable ROM : romType;
    begin
        for I in romType'range loop
            readline(data_file, data_fileLine);
            read(data_fileLine, ROM(I));
        end loop;
        return ROM;
end function;

signal rom : romType := initRomFromFile;
attribute rom_style : string;
attribute rom_style of rom : signal is "block";


begin

process(clk)
    begin
    if(rising_edge(clk)) then
        dataout <= rom(to_integer(unsigned(address)));
    end if;
    
end process;


end Behavioral;
