----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2019 15:29:51
-- Design Name: 
-- Module Name: sens_teste - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sens_teste is
    Port ( btnU : in STD_LOGIC;
           btnC : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           sw15 : in STD_LOGIC;
           clk  : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end sens_teste;

architecture Behavioral of sens_teste is

component sens_top_level_iprom is
    Port ( start : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk   : in STD_LOGIC;
           x_fus : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
           mem_addr : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component display_decoder is
    Port ( clk   : in STD_LOGIC;
           disp0 : in STD_LOGIC_VECTOR (3 downto 0);
           disp1 : in STD_LOGIC_VECTOR (3 downto 0);
           disp2 : in STD_LOGIC_VECTOR (3 downto 0);
           disp3 : in STD_LOGIC_VECTOR (3 downto 0);
           on_disp : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--signal out_mux_clk : std_logic := '0';
--signal in_clk : std_logic := '0';
signal x_fus : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others => '0');
signal mem_addr : STD_LOGIC_VECTOR (6 downto 0);
signal clk_counter : integer := 0;
signal clk_div_out : STD_LOGIC := '0';

begin

clk_divider : process(clk)
begin
    if rising_edge(clk) then
        if clk_counter = 5000-1 and sw0 = '0' then
            clk_counter <= 0;
            clk_div_out <= not clk_div_out;
        elsif clk_counter = 5000-1 then
            clk_counter <= 0; 
        else
            clk_counter <= clk_counter + 1;
            clk_div_out <= clk_div_out;
        end if;
    end if;
end process;


U0: sens_top_level_iprom port map(
           start => btnU,
           reset => btnC,
           clk   => clk_div_out, 
           x_fus => x_fus,
           mem_addr => mem_addr
           );

U1: display_decoder port map(
           clk   => clk,
           disp0 => mem_addr(3 downto 0),
           disp1(0) => mem_addr(4),
           disp1(1) => mem_addr(5),
           disp1(2) => mem_addr(6),
           disp1(3) => '0',
           disp2 => "0000",
           disp3 => "0000",
           on_disp => "1100",
           seg => seg,
           an => an
           );

mux_leds : process (sw15)
begin
    if sw15 = '0' then
        led <= x_fus(26 downto 11);
    else
        led <= x_fus(10 downto 0) & "00000";
    end if;
end process;

end Behavioral;
