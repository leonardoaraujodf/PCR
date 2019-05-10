----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 19:45:04
-- Design Name: 
-- Module Name: tb_sensorial - Behavioral
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
use std.textio.all;
use IEEE.std_logic_textio.all;

use work.fpupack.all;
use work.entities.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_sensorial is
--  Port ( );
end tb_sensorial;

architecture Behavioral of tb_sensorial is

component sensorial is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_ir : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_ul : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end component;

signal start : std_logic := '0';
signal first_start : std_logic := '0';
signal reset : std_logic := '0';
signal clk   : std_logic := '0';
signal ready : std_logic := '0';
signal x_ir  : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal x_ul  : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal x_fus  : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

signal WOMenable : std_logic := '0';

begin

-- reset generator

reset <= '0', '1' after 15 ns, '0' after 25 ns;

-- clock generator

clk <= not clk after 5 ns;

-- first start

first_start <= '0', '1' after 55 ns, '0' after 65 ns;

U1: sensorial port map(
           start => start,
           reset => reset,
           clk => clk,
           x_ir => x_ir,
           x_ul => x_ul,
           x_fus => x_fus,
           ready => ready
           );

rom_x_ul: process
file infile : text is in "x_ul_bin.txt"; -- input file declaration
variable inline : line;
variable dataf : std_logic_vector(FP_WIDTH-1 downto 0);
begin
    while(not endfile(infile)) loop
        wait until rising_edge(clk);
            if first_start = '1' or ready='1' then
                readline(infile,inline);
                read(inline,dataf);
                x_ul <= dataf;
                start <= '1';
            else
                start <= '0';
            end if;
    end loop;
    assert not endfile(infile) report "FIM DA LEITURA" severity warning;
    wait;
end process;

rom_x_ir: process
file infile : text is in "x_ir_bin.txt"; -- input file declaration
variable inline : line;
variable dataf : std_logic_vector(FP_WIDTH-1 downto 0);
begin
    while(not endfile(infile)) loop
        wait until rising_edge(clk);
            if first_start = '1' or ready='1' then
                readline(infile,inline);
                read(inline,dataf);
                x_ir <= dataf;
            end if;
    end loop;
    wait;
end process;

WOMenable <= ready;

wom_n11 : process(clk)
variable out_line : line;
file out_file : text is out "x_fus_bin.txt";
begin
    -- write line to file every clock
    if(rising_edge(clk)) then
        if WOMenable = '1' then
            write(out_line,x_fus);
            writeline(out_file,out_line);
        end if;
    end if;

end process;

end Behavioral;
