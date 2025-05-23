LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_alu IS
END tb_alu;

ARCHITECTURE tb OF tb_alu IS

  COMPONENT alu
    PORT (
      clk      : IN  std_logic;
      rst_a    : IN  std_logic;
    
      mode     : IN  std_logic_vector(7  DOWNTO 0);

      val_a    : IN  std_logic_vector(31 DOWNTO 0);
      val_b    : IN  std_logic_vector(31 DOWNTO 0);
      val_c    : OUT std_logic_vector(31 DOWNTO 0);
    
      flags    : OUT std_logic_vector(7  DOWNTO 0)
    );
  END COMPONENT alu;

  SIGNAL clk_i      : std_logic := '0';
  SIGNAL rst_a_i    : std_logic := '1';
  SIGNAL mode_i     : std_logic_vector(7  DOWNTO 0) := (OTHERS => '0');
  SIGNAL val_a_i    : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL val_b_i    : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL val_c_i    : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL flags_i    : std_logic_vector(7  DOWNTO 0) := (OTHERS => '0');
  
  SHARED VARIABLE a_i : std_logic_vector(31 DOwNTO 0);
  SHARED VARIABLE b_i : std_logic_vector(31 DOwNTO 0);
  SHARED VARIABLE m_i : std_logic_vector(7 DOwNTO 0);
  
  CONSTANT C_CLOCK_PERIOD : time := 10 ns;

  PROCEDURE calculate_sgn(
    SIGNAL   clk   : IN  std_logic;
    VARIABLE val_a : IN  std_logic_vector(31 DOWNTO 0);
    VARIABLE val_b : IN  std_logic_vector(31 DOWNTO 0);
    VARIABLE mode  : IN  std_logic_vector(7  DOWNTO 0);
    SIGNAL   m     : OUT std_logic_vector(7  DOWNTO 0);
    SIGNAL   a     : OUT std_logic_vector(31 DOWNTO 0);
    SIGNAL   b     : OUT std_logic_vector(31 DOWNTO 0);
    SIGNAL   c     : IN  std_logic_vector(31 DOWNTO 0)
  ) IS
  BEGIN
    WAIT UNTIL rising_edge(clk);
    m <= mode;
    a <= val_a;
    b <= val_b;
    WAIT UNTIL rising_edge(clk);
    REPORT "NUM A: " & integer'image(to_integer(unsigned(val_a))) & ", B: " & integer'image(to_integer(unsigned(val_b))) & ", Mode: " & integer'image(to_integer(unsigned(mode))) & ", SIGNED CALC: " & integer'image(to_integer(unsigned(c)));

  END PROCEDURE;
    
    
 
BEGIN


  clk_gen: PROCESS
  BEGIN
    clk_i <= '0';
    WAIT FOR C_CLOCK_PERIOD;
    clk_i <= '1';
    WAIT FOR C_CLOCK_PERIOD;
  END PROCESS clk_gen;

  rst_gen: PROCESS
  BEGIN
    rst_a_i <= '1';
    WAIT FOR C_CLOCK_PERIOD;
    rst_a_i <= '0';
    WAIT;
  END PROCESS rst_gen;


  dut: alu
  PORT MAP (
    clk   => clk_i,
    rst_a => rst_a_i,

    mode  => mode_i,

    val_a => val_a_i,
    val_b => val_b_i,
    val_c => val_c_i,

    flags => flags_i
  );

  stimul: PROCESS
  BEGIN
    WAIT UNTIL rst_a_i = '0';
    WAIT FOR 9 ns;
    
    a_i := x"0000000F";
    b_i := x"00000001";
    m_i := x"01";
    
    calculate_sgn(clk_i, a_i, b_i, m_i, mode_i, val_a_i, val_b_i, val_c_i);

    a_i := x"0000000F";
    b_i := x"0000000F";
    m_i := x"01";
    calculate_sgn(clk_i, a_i, b_i, m_i, mode_i, val_a_i, val_b_i, val_c_i);
    
    a_i := x"00000000";
    b_i := x"0000000F";
    m_i := "11000001";
    calculate_sgn(clk_i, a_i, b_i, m_i, mode_i, val_a_i, val_b_i, val_c_i);

  END PROCESS stimul;

END tb;
