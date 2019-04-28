----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2019 11:29:31
-- Design Name: 
-- Module Name: neuronio_gmbh - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;
use work.entities.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity neuronio_gmbh is
    Port ( start : in STD_LOGIC;
           clk: in STD_LOGIC;
           reset: in STD_LOGIC;
           x : in std_logic_vector(FP_WIDTH-1 downto 0);
           a: in std_logic_vector(FP_WIDTH-1 downto 0);
           b: in std_logic_vector(FP_WIDTH-1 downto 0);
           c: in std_logic_vector(FP_WIDTH-1 downto 0);
           out_neuron: out std_logic_vector(FP_WIDTH-1 downto 0);   
           ready : out STD_LOGIC);
end neuronio_gmbh;

architecture Behavioral of neuronio_gmbh is

signal mult_in_a: t_mult := (others => (others=>'0')); 
signal mult_in_b: t_mult := (others => (others=>'0'));
signal mult_out: t_mult := (others => (others=>'0'));
signal mult_start: std_logic_vector(num_mult-1 downto 0);
signal mult_ready: std_logic_vector(num_mult-1 downto 0);

signal sum_in_a: t_sum := (others => (others=>'0')); 
signal sum_in_b: t_sum := (others => (others=>'0'));
signal sum_out: t_sum := (others => (others=>'0'));
signal sum_start: std_logic_vector(num_sum-1 downto 0);
signal sum_ready: std_logic_vector(num_sum-1 downto 0);

begin

    mult_gen: for i in 0 to num_mult-1 generate
        mul: multiplierfsm_v2 port map(
            reset => reset,
	        clk	 => clk,         
	 		op_a => mult_in_a(i),
            op_b => mult_in_b(i),
			start_i => mult_start(i),
            mul_out => mult_out(i),
			ready_mul => mult_ready(i));
    end generate mult_gen;

    add_gen: for i in 0 to num_sum-1 generate
        add: addsubfsm_v6 port map(
            reset => reset,
		    clk => clk,
		    op => '0',
		    op_a => sum_in_a(i),
		    op_b => sum_in_b(i),
		    start_i => sum_start(i),
		    addsub_out => sum_out(i),
		    ready_as => sum_ready(i));
    end generate add_gen;

-- First multiplier
mult_in_a(0) <= x;
mult_in_b(0) <= x;
mult_start(0) <= start; 

-- Second Multiplier
mult_in_a(1) <= x;
mult_in_b(1) <= b;
mult_start(1) <= start;

-- Third Multiplier
mult_in_a(2) <= mult_out(0);
mult_in_b(2) <= a;
mult_start(2) <= mult_ready(0);

-- First summer
sum_in_a(0) <= mult_out(1); 
sum_in_b(0) <= c;
sum_start(0) <= mult_ready(1);

-- Second summer
sum_in_a(1) <= sum_out(0); 
sum_in_b(1) <= mult_out(2);
sum_start(1) <= mult_ready(2) and sum_ready(0);

-- Neuron out

out_neuron <= sum_out(1);
ready <= sum_ready(1);


end Behavioral;
