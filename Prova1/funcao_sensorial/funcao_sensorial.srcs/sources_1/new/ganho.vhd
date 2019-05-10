----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 09:09:38
-- Design Name: 
-- Module Name: ganho - Behavioral
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

entity ganho is
    Port ( sigma_k : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           sigma_z : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready : out STD_LOGIC;
           G_kp1 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end ganho;

architecture Behavioral of ganho is

-- Sinais para o somador

signal out_sum : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
signal ready_sum : STD_LOGIC;

begin

U1: addsubfsm_v6 port map(
          reset     => reset,
          clk       => clk,
          op        => '0',
          op_a    	=> sigma_k,
          op_b    	 => sigma_z,
          start_i	 => start,
          addsub_out => out_sum,
          ready_as  => ready_sum);

U2: divNR port map(
            reset     => reset,
            clk       => clk,
            op_a      => sigma_k,
            op_b      => out_sum,
            start_i	 => ready_sum,
            div_out   => G_kp1,
            ready_div => ready);

end Behavioral;
