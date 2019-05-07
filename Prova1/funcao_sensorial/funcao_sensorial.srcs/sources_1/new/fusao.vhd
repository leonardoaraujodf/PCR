----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 08:40:56
-- Design Name: 
-- Module Name: fusao - Behavioral
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

entity fusao is
    Port ( x_ir : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_ul : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           G_kp1 : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end fusao;

architecture Behavioral of fusao is

-- Sinais para o primeiro somador
signal out_sum1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
signal ready_sum1: STD_LOGIC;

-- Sinais para o multiplicador
signal out_mul : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
signal ready_mul: STD_LOGIC;


begin

U1: addsubfsm_v6 port map(
          reset     => reset,
          clk       => clk,
          op        => '1',
          op_a    	=> x_ir,
          op_b    	 => x_ul,
          start_i	 => start,
          addsub_out => out_sum1,
          ready_as  => ready_sum1);

U2: multiplierfsm_v2 port map(
            reset => reset, 
            clk => clk,          
            op_a => out_sum1,
            op_b => G_kp1,
            start_i	 => ready_sum1,
            mul_out  => out_mul,
            ready_mul => ready_mul);

U3: addsubfsm_v6 port map(
          reset     => reset,
          clk       => clk,
          op        => '0',
          op_a    	=> out_mul,
          op_b    	 => x_ul,
          start_i	 => ready_mul,
          addsub_out => x_fus,
          ready_as  => ready);


end Behavioral;
