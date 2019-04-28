----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2019 15:01:38
-- Design Name: 
-- Module Name: tb_neuron_gmbh - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.fpupack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_neuron_gmbh is
--  Port ( );
end tb_neuron_gmbh;

architecture Behavioral of tb_neuron_gmbh is

signal start: std_logic := '0';
signal clk: std_logic := '0';
signal reset: std_logic := '0';
signal x : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal a: std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal b: std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal c: std_logic_vector(FP_WIDTH-1 downto 0):= (others=>'0');
signal out_neuron: std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');   
signal ready : std_logic := '0';

signal WOMenable : std_logic := '0';

component neuronio_gmbh is
    Port ( start : in STD_LOGIC;
           clk: in STD_LOGIC;
           reset: in STD_LOGIC;
           x : in std_logic_vector(FP_WIDTH-1 downto 0);
           a: in std_logic_vector(FP_WIDTH-1 downto 0);
           b: in std_logic_vector(FP_WIDTH-1 downto 0);
           c: in std_logic_vector(FP_WIDTH-1 downto 0);
           out_neuron: out std_logic_vector(FP_WIDTH-1 downto 0);   
           ready : out STD_LOGIC);
end component;

signal first_start : std_logic := '0';

begin

    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    -- clock generator
    clk <= not clk after 5 ns; 
    -- cria o start 
    first_start <= '0', '1' after 55 ns, '0' after 65 ns;
    
     uut: neuronio_gmbh port map ( 
           start => start,
           clk => clk,
           reset => reset,
           x => x,
           a => a,
           b => b,
           c => c,
           out_neuron => out_neuron,   
           ready => ready);       

    rom_x: process
    file infile	: text is in "binx.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    x <= dataf;
                    start <= '1';
                else
                    start <= '0';
                end if;                
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
   
    rom_a: process
    file infile	: text is in "bina.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    a <= dataf;
                end if;            
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;   
    
    rom_b: process
    file infile	: text is in "binb.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    b <= dataf;                
                end if;
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;

    rom_c: process
    file infile	: text is in "binb.txt"; -- input file declaration
    variable inline : line; -- line number declaration
    variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
    begin
        while (not endfile(infile)) loop
            wait until rising_edge(clk);
                if first_start='1' or ready='1' then
                    readline(infile, inline);
                    read(inline,dataf);
                    c <= dataf;
                end if;                
        end loop;
        assert not endfile(infile) report "FIM DA LEITURA" severity warning;
        wait;        
    end process;
    
    WOMenable <= ready;
    
    wom_n1 : process(clk) 
    variable out_line : line;
    file out_file     : text is out "res_neuron.txt";
    begin
        -- write line to file every clock
        if (rising_edge(clk)) then
            if WOMenable = '1' then
                write (out_line, out_neuron);
                writeline (out_file, out_line);
            end if; 
        end if;  
    end process ;
    
end Behavioral;
