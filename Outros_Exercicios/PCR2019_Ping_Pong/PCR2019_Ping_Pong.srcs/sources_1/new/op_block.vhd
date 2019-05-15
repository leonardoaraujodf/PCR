----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2019 23:23:16
-- Design Name: 
-- Module Name: op_block - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op_block is
    Port ( clr_reg_score_p1 : in STD_LOGIC;
           ld_reg_score_p1 : in STD_LOGIC;
           sel_p1 : in STD_LOGIC;
           clr_reg_score_p2 : in STD_LOGIC;
           ld_reg_score_p2 : in STD_LOGIC;
           sel_p2 : in STD_LOGIC;
           clr_reg_led1 : in STD_LOGIC;
           clr_reg_led2 : in STD_LOGIC;
           ld_reg_led : in STD_LOGIC;
           sel_led : in STD_LOGIC;
           clk : in STD_LOGIC;
           score_p1_eq_10 : out STD_LOGIC;
           score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
           score_p2_eq_10 : out STD_LOGIC;
           score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
           out_led : out STD_LOGIC_VECTOR (15 downto 0);
           led_eq_1 : out STD_LOGIC;
           led_eq_128 : out STD_LOGIC);
end op_block;

architecture Behavioral of op_block is

component reg_score_p1 is
    Port ( in_reg : in STD_LOGIC_VECTOR (3 downto 0);
           out_reg : out STD_LOGIC_VECTOR (3 downto 0);
           clr_reg_score_p1 : in STD_LOGIC;
           ld_reg_score_p1 : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component reg_score_p2 is
    Port ( in_reg : in STD_LOGIC_VECTOR (3 downto 0);
           out_reg : out STD_LOGIC_VECTOR (3 downto 0);
           clr_reg_score_p2 : in STD_LOGIC;
           ld_reg_score_p2 : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component reg_leds is
    Port ( clr_reg_led1 : in STD_LOGIC;
           clr_reg_led2 : in STD_LOGIC;
           ld_reg_led : in STD_LOGIC;
           clk : in STD_LOGIC;
           in_reg_led : in STD_LOGIC_VECTOR (15 downto 0);
           out_reg_led : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component mux_2x1_4bits is
    Port ( in1_mux : in STD_LOGIC_VECTOR (3 downto 0);
           in2_mux : in STD_LOGIC_VECTOR (3 downto 0);
           out_mux : out STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC);
end component;

component mux_2x1_8bits is
    Port ( in1_mux : in STD_LOGIC_VECTOR (15 downto 0);
           in2_mux : in STD_LOGIC_VECTOR (15 downto 0);
           out_mux : out STD_LOGIC_VECTOR (15 downto 0);
           sel : in STD_LOGIC);
end component;

component comparator_led_eq_1 is
    Port ( in_comparator : in STD_LOGIC_VECTOR (15 downto 0);
           led_eq_1 : out STD_LOGIC);
end component;

component comparator_led_eq_128 is
    Port ( in_comparator : in STD_LOGIC_VECTOR (15 downto 0);
           led_eq_128 : out STD_LOGIC);
end component;

component comp_score_eq_10 is
    Port ( in_comp : in STD_LOGIC_VECTOR (3 downto 0);
           out_comp : out STD_LOGIC);
end component;

component shift_right is
    Port ( in_shift : in STD_LOGIC_VECTOR (15 downto 0);
           out_shift : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component left_shift is
    Port ( in_shift : in STD_LOGIC_VECTOR (15 downto 0);
           out_shift : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component inc is
    Port ( in_inc : in STD_LOGIC_VECTOR (3 downto 0);
           out_inc : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component dec is
    Port ( in_dec : in STD_LOGIC_VECTOR (3 downto 0);
           out_dec : out STD_LOGIC_VECTOR (3 downto 0));
end component;


signal in_reg_p1: STD_LOGIC_VECTOR (3 downto 0);
signal out_reg_p1: STD_LOGIC_VECTOR (3 downto 0);
signal in_reg_p2: STD_LOGIC_VECTOR (3 downto 0);
signal out_reg_p2: STD_LOGIC_VECTOR (3 downto 0);
signal in_reg_led: STD_LOGIC_VECTOR (15 downto 0);
signal out_reg_led: STD_LOGIC_VECTOR (15 downto 0);
signal in1_mux1: STD_LOGIC_VECTOR (3 downto 0);
signal in2_mux1: STD_LOGIC_VECTOR (3 downto 0);
signal in1_mux2: STD_LOGIC_VECTOR (3 downto 0);
signal in2_mux2: STD_LOGIC_VECTOR (3 downto 0);
signal in1_mux3: STD_LOGIC_VECTOR (15 downto 0);
signal in2_mux3: STD_LOGIC_VECTOR (15 downto 0);


begin

score_p1 <= out_reg_p1;
score_p2 <= out_reg_p2;
out_led <= out_reg_led;

G1: reg_score_p1 port map(
                         in_reg => in_reg_p1,
                         out_reg => out_reg_p1,
                         clr_reg_score_p1 => clr_reg_score_p1,
                         ld_reg_score_p1 => ld_reg_score_p1,
                         clk => clk 
                         );

G2: reg_score_p2 port map(
                         in_reg => in_reg_p2,
                         out_reg => out_reg_p2,
                         clr_reg_score_p2 => clr_reg_score_p2,
                         ld_reg_score_p2 => ld_reg_score_p2,
                         clk => clk 
                         ); 

G3: reg_leds port map(
                        clr_reg_led1 => clr_reg_led1,
                        clr_reg_led2 => clr_reg_led2,
                        ld_reg_led => ld_reg_led,
                        clk => clk,
                        in_reg_led => in_reg_led,
                        out_reg_led => out_reg_led
                      );

G4: mux_2x1_4bits port map(
                           in1_mux => in1_mux1, 
                           in2_mux => in2_mux1,
                           out_mux => in_reg_p1,
                           sel => sel_p1
                           );

G5: mux_2x1_4bits port map(
                           in1_mux => in1_mux2, 
                           in2_mux => in2_mux2,
                           out_mux => in_reg_p2,
                           sel => sel_p2
                           );
                           
G6: mux_2x1_8bits port map(
                           in1_mux => in1_mux3, 
                           in2_mux => in2_mux3,
                           out_mux => in_reg_led,
                           sel => sel_led
                           );                           
                           
G7: comparator_led_eq_1 port map(
                                in_comparator => out_reg_led,
                                led_eq_1 => led_eq_1
                                );
G8: comparator_led_eq_128 port map(
                                in_comparator => out_reg_led,
                                led_eq_128 => led_eq_128
                                ); 
G9: comp_score_eq_10 port map(
                                in_comp => in_reg_p1,
                                out_comp => score_p1_eq_10
                              );
G10: comp_score_eq_10 port map(
                                in_comp => in_reg_p2,
                                out_comp => score_p2_eq_10
                              );

G11: inc port map(
                    in_inc => out_reg_p1,
                    out_inc => in1_mux1
                  );

G12: dec port map(
                    in_dec => out_reg_p1,
                    out_dec => in2_mux1
                  );

G13: inc port map(
                    in_inc => out_reg_p2,
                    out_inc => in1_mux2
                  );

G14: dec port map(
                    in_dec => out_reg_p2,
                    out_dec => in2_mux2
                  );

G15: left_shift port map(
                    in_shift => out_reg_led,
                    out_shift => in1_mux3
                        );

G16: shift_right port map(
                    in_shift => out_reg_led,
                    out_shift => in2_mux3
                          );

end Behavioral;
