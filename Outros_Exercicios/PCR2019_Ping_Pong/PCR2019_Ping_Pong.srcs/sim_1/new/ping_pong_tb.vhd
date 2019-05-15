library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ping_pong_tb is
end;

architecture bench of ping_pong_tb is

  component top_level_ping_pong
      Port ( start : in STD_LOGIC;
             reset : in STD_LOGIC;
             sw0 : in STD_LOGIC;
             sw15 : in STD_LOGIC;
             score_p1 : out STD_LOGIC_VECTOR (3 downto 0);
             score_p2 : out STD_LOGIC_VECTOR (3 downto 0);
             out_led : out STD_LOGIC_VECTOR (15 downto 0);
             clk: in STD_LOGIC
             );
  end component;

  signal start: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal sw0: STD_LOGIC;
  signal sw15: STD_LOGIC;
  signal score_p1: STD_LOGIC_VECTOR (3 downto 0);
  signal score_p2: STD_LOGIC_VECTOR (3 downto 0);
  signal out_led: STD_LOGIC_VECTOR (15 downto 0);
  signal clk: STD_LOGIC ;

begin

  uut: top_level_ping_pong port map ( start    => start,
                                      reset    => reset,
                                      sw0      => sw0,
                                      sw15     => sw15,
                                      score_p1 => score_p1,
                                      score_p2 => score_p2,
                                      out_led  => out_led,
                                      clk      => clk );

  stimulus: process
  begin
    --clk period of 20 ns 
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
  end process;

    start <= '0', '1' after 4 ns, '0' after 8 ns;
    reset <= '1', '0' after 2 ns;
    sw0 <= '0', '1' after 10 ns, '0' after 12 ns;
    sw15 <= '0', '1' after 41 ns, '0' after 47 ns, '1' after 79 ns;

end;