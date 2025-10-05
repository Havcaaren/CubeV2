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
  
  CONSTANT C_CLOCK_PERIOD : time := 10 ns;

  SHARED VARIABLE cc : natural := 0;

  CONSTANT TIMEOUT : integer := 100000;
 
BEGIN


  clk_gen: PROCESS
  BEGIN
    FOR idx IN 0 TO TIMEOUT LOOP
      clk_i <= '0';
      WAIT FOR C_CLOCK_PERIOD;
      clk_i <= '1';
      WAIT FOR C_CLOCK_PERIOD;
    END LOOP;
    WAIT;
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
    mode_i <= x"00";
    WAIT UNTIL rst_a_i = '0';
    WAIT FOR 9 ns;

%TEST%

    REPORT "CC: " & integer'image(cc);

    IF cc = %X% THEN
        REPORT "PASSED";
    ELSE
        REPORT "FAILED";
    END IF;

    WAIT;
  END PROCESS stimul;

END tb;
