----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2019 09:40:33
-- Design Name: 
-- Module Name: RNA443 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Deion: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.fpupack.all;
use work.entities.all;

entity RNA443 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           x : in t_mult;
           bias: in num_neur;
           out_rna : out saida_rna;
           ready : out STD_LOGIC);
end RNA443;


architecture Behavioral of RNA443 is

signal x_rna: entr_neuron := (others => (others => (others=> '0')));
signal w_rna: entr_neuron := (others => (others => (others=> '0')));
signal saida_neuron: num_neur := (others => (others=>'0'));

begin
 -- implementar com for generate
    neuron_gen: for i in num_neur'range generate
        neuron: neuronio port map(	
          clk => clk,
		  reset => reset,
		  start => start,
		  x 	=> x_rna(i),
		  w 	=> w_rna(i),
		  bias  => bias(i),
		  saida => saida_neuron(i),
		  ready => ready
		  );
          end generate;

x_rna(0) <= x;
x_rna(1) <= x;
x_rna(2) <= x;
x_rna(3) <= x;
x_rna(4) <= (saida_neuron(0),saida_neuron(1),saida_neuron(2),saida_neuron(3));
x_rna(5) <= (saida_neuron(0),saida_neuron(1),saida_neuron(2),saida_neuron(3));
x_rna(6) <= (saida_neuron(0),saida_neuron(1),saida_neuron(2),saida_neuron(3));
out_rna <= (saida_neuron(4),saida_neuron(5),saida_neuron(6));


end Behavioral;
