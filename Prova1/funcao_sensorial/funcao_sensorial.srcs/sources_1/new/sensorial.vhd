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
use work.fpupack.all;
use work.entities.all;
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
           x_ir : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_ul : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           ready : out STD_LOGIC);
end sensorial;

architecture Behavioral of sensorial is

-- cov_error signals

signal ready_cov_error : STD_LOGIC := '0';

-- ganho signals

signal ready_ganho : STD_LOGIC := '0';

-- temp_reg_1 signals

signal in_temp_reg1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal out_temp_reg1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

-- Ganho signals

signal G_kp1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');

begin

U1: cov_erro port map(
           start => ready_ganho,
           reset => reset,
           clk => clk,
           sigma_k => out_temp_reg1,
           G_kp1 => G_kp1,
           ready => ready_cov_error,
           sigma_kp1 => in_temp_reg1);

U2: temp_reg1 port map(
           ld_temp_reg => ready_cov_error,
           clr_temp_reg => reset,
           clk => clk,
           in_temp_reg => in_temp_reg1,
           out_temp_reg => out_temp_reg1);

U3: ganho port map(
           sigma_k => out_temp_reg1,
           sigma_z => SIGMA_Z,
           start => start,
           reset => reset,
           clk => clk,
           ready => ready_ganho,
           G_kp1 => G_kp1);

U5: fusao port map(
           x_ir => x_ir,
           x_ul => x_ul,
           G_kp1 => G_kp1,
           start => ready_ganho,
           reset => reset,
           clk => clk,
           x_fus => x_fus,
           ready => ready);       

end Behavioral;
