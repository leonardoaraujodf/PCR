----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 08:58:23
-- Design Name: 
-- Module Name: cov_erro - Behavioral
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

entity cov_erro is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           sigma_k : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           G_kp1 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC;
           sigma_kp1 : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0));
end cov_erro;

architecture Behavioral of cov_erro is

-- Sinais para o multiplicador
signal out_mul : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
signal ready_mul: STD_LOGIC;


begin

U1: multiplierfsm_v2 port map(
            reset => reset, 
            clk => clk,          
            op_a => sigma_k,
            op_b => G_kp1,
            start_i	 => start,
            mul_out  => out_mul,
            ready_mul => ready_mul);

U2: addsubfsm_v6 port map(
          reset     => reset,
          clk       => clk,
          op        => '1',
          op_a    	=> sigma_k,
          op_b    	 => out_mul,
          start_i	 => ready_mul,
          addsub_out => sigma_kp1,
          ready_as  => ready);


end Behavioral;
