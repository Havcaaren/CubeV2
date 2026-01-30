LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counter IS
GENERIC (
  G_WIDTH : natural := 8
);
PORT (
  clk   : IN  std_logic;
  rst_n : IN  std_logic;

  en    : IN  std_logic; 
  
  val   : OUT std_logic_vector(G_WIDHT - 1 DOWNTO 0)
);
END counter;

ARCHITECTURE rtl OF counter IS

  SIGNAL q_i : std_logic_vector(G_WIDTH - 1 DOWNTO 0);
  SIGNAL d_i : std_logic_vector(G_WIDTH - 1 DOWNTO 0);

BEGIN

  p_dff: PROCESS (clk, rst_n)
  BEGIN
    IF (rst_n = '0') THEN
      q_i <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF en = '1' THEN
        q_i <= d_i;
      END IF;
    END IF;
  END PROCESS p_dff;
  
  d_i <= q_i + 1;

END rtl;
