----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2019 15:28:53
-- Design Name: 
-- Module Name: op_block_ping_pong - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op_block_ping_pong is
    Port ( clk : in STD_LOGIC;
           ld_reg_leds : in STD_LOGIC;
           clr1_reg_leds : in STD_LOGIC;
           clr2_reg_leds : in STD_LOGIC;
           out_reg_leds : out STD_LOGIC_VECTOR (15 downto 0);
           shifter_sel : in STD_LOGIC;
           leds_eq_init : out STD_LOGIC;
           leds_eq_end : out STD_LOGIC;
           leds_gt_half : out STD_LOGIC;
           ld_cnt_score_p1 : in STD_LOGIC;
           clr_cnt_score_p1 : in STD_LOGIC;
           out_cnt_score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           ld_cnt_score_p2 : in STD_LOGIC;
           clr_cnt_score_p2 : in STD_LOGIC;
           out_cnt_score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p1_eq_9 : out STD_LOGIC;
           score_p2_eq_9 : out STD_LOGIC
           );
end op_block_ping_pong;

architecture Behavioral of op_block_ping_pong is

-- reg leds signals
signal in_reg_leds : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal s_out_reg_leds : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
-- shifter signals

signal out_shifter : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); 

-- cnt_score_p1 signals
signal counter_p1 : unsigned(3 downto 0) := (others => '0');
 
-- cnt_score_p2 signals

signal counter_p2 : unsigned(3 downto 0) := (others => '0');

begin

reg_leds: process(clk,ld_reg_leds,clr1_reg_leds,clr2_reg_leds)
begin
    if clr1_reg_leds = '1' then
        s_out_reg_leds <= "0000000000000001";
    elsif clr2_reg_leds = '1' then
        s_out_reg_leds <= "1000000000000000";
    elsif rising_edge(clk) then
        if ld_reg_leds = '1' then
            s_out_reg_leds <= in_reg_leds;
        end if;
    end if;
end process;

out_reg_leds <= s_out_reg_leds;

shifter: process(shifter_sel,s_out_reg_leds)
begin
    if shifter_sel = '0' then -- desloca para a esquerda
        in_reg_leds <= s_out_reg_leds(14 downto 0) & '0';
    else -- desloca para a direita
        in_reg_leds <= '0' & s_out_reg_leds(15 downto 1);
    end if;
end process;

leds_comparator: process(s_out_reg_leds)
begin
    if s_out_reg_leds = "0000000000000001" then
        leds_eq_init <= '1';
        leds_eq_end <= '0';
        leds_gt_half <= '0';
    elsif s_out_reg_leds = "1000000000000000" then
        leds_eq_init <= '0';
        leds_eq_end <= '1';
        leds_gt_half <= '1';
    elsif s_out_reg_leds > "0000000100000000" then
        leds_eq_init <= '0';
        leds_eq_end <= '0';
        leds_gt_half <= '1';
    else
        leds_eq_init <= '0';
        leds_eq_end <= '0';
        leds_gt_half <= '0';
    end if;
end process;

pcounter_p1 : process(clk,clr_cnt_score_p1)
begin
    if clr_cnt_score_p1 = '1' then
        counter_p1 <= (others => '0');
    elsif rising_edge(clk) then
        if ld_cnt_score_p1 = '1' then
            counter_p1 <= counter_p1 + 1; 
        end if;
    end if;
end process;

out_cnt_score_p1 <= std_logic_vector(counter_p1);

pcounter_p2 : process(clk,clr_cnt_score_p2)
begin
    if clr_cnt_score_p2 = '1' then
        counter_p2 <= (others => '0');
    elsif rising_edge(clk) then
        if ld_cnt_score_p2 = '1' then
            counter_p2 <= counter_p2 + 1; 
        end if;
    end if;
    
end process;

out_cnt_score_p2 <= std_logic_vector(counter_p2);

score_comparator: process(counter_p1,counter_p2)
begin
    if counter_p1 = "1001" then
        score_p1_eq_9 <= '1';
        score_p2_eq_9 <= '0';
    elsif counter_p2 = "1001" then
        score_p1_eq_9 <= '0';
        score_p2_eq_9 <= '1';
    else
        score_p1_eq_9 <= '0';
        score_p2_eq_9 <= '0';
    end if;
end process;

end Behavioral;
