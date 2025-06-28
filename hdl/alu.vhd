LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu IS
  PORT (
    clk      : IN  std_logic;
    rst_a    : IN  std_logic;
    
    mode     : IN  std_logic_vector(7  DOWNTO 0);

    val_a    : IN  std_logic_vector(31 DOWNTO 0);
    val_b    : IN  std_logic_vector(31 DOWNTO 0);
    val_c    : OUT std_logic_vector(31 DOWNTO 0);
    
    flags    : OUT std_logic_vector(7  DOWNTO 0)
  );
END alu;


ARCHITECTURE rtl OF alu IS

  SIGNAL flag_d : std_logic_vector(7 DOWNTO 0);
  SIGNAL flag_q : std_logic_vector(7 DOWNTO 0);
  SIGNAL flag_e : std_logic;

  SIGNAL rsl  : std_logic_vector(31 DOWNTO 0);

  SIGNAL sgn_add_res  : std_logic_vector(32 DOWNTO 0);
  SIGNAL sgn_sub_res  : std_logic_vector(32 DOWNTO 0);
  SIGNAL uns_add_res  : std_logic_vector(32 DOWNTO 0);
  SIGNAL uns_sub_res  : std_logic_vector(32 DOWNTO 0);
  
  SIGNAL over_i       : std_logic;
  SIGNAL carry_out_q  : std_logic;

BEGIN

  dff_proc: PROCESS (clk, rst_a)
  BEGIN
    IF rst_a = '1' THEN 
      flag_q <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF flag_e = '1' THEN
        flag_q <= flag_d;
      END IF;
    END IF;
  END PROCESS dff_proc;

  flag_e <= '1' WHEN flag_d /= flag_q ELSE
            '0';

  -- Zero
  flag_d(0) <= '1' WHEN rsl = x"0000" ELSE
               '0';
  
  -- Neg
  flag_d(1) <= '1' WHEN rsl(31) = '1' ELSE
               '0';
  
  -- Over  
  flag_d(2) <= '1' WHEN uns_add_res(32) = '1' AND mode = x"0E" ELSE
               '1' WHEN uns_sub_res(32) = '0' AND mode = x"0F" ELSE
               '1' WHEN sgn_add_res(32) = '1' AND mode = x"00" ELSE
               '1' WHEN sgn_sub_res(32) = '0' AND mode = x"01" ELSE
               '0';

  -- rotate
  flag_d(3) <= val_a(0)  WHEN mode = x"0A" ELSE
               val_a(31) WHEN mode = x"0B" ELSE
               flag_q(3);
  
  -- shift
  flag_d(4) <= val_a(0)  WHEN mode = x"0C" ELSE
               val_a(31) WHEN mode = x"0D" ELSE
               flag_q(4);

  sgn_add_res <= std_logic_vector(resize(signed(val_a), 33) + signed(val_b));
  sgn_sub_res <= std_logic_vector(resize(signed(val_a), 33) - signed(val_b));

  uns_add_res <= std_logic_vector(resize(unsigned(val_a), 33) + unsigned(val_b));
  uns_sub_res <= std_logic_vector(resize(unsigned(val_a), 33) - unsigned(val_b));

  rsl <= std_logic_vector(resize(signed(sgn_add_res), 32))   WHEN mode = x"00" ELSE
         std_logic_vector(resize(signed(sgn_sub_res), 32))   WHEN mode = x"01" ELSE
         std_logic_vector(resize(unsigned(uns_add_res), 32)) WHEN mode = x"0E" ELSE
         std_logic_vector(resize(unsigned(uns_sub_res), 32)) WHEN mode = x"0F" ELSE
         NOT val_a                                           WHEN mode = x"02" ELSE
         NOT val_b                                           WHEN mode = x"03" ELSE
         val_a AND  val_b                                    WHEN mode = x"04" ELSE
         val_a NAND val_b                                    WHEN mode = x"05" ELSE
         val_a OR   val_b                                    WHEN mode = x"06" ELSE
         val_a NOR  val_b                                    WHEN mode = x"07" ELSE
         val_a XOR  val_b                                    WHEN mode = x"08" ELSE
         val_a XNOR val_b                                    WHEN mode = x"09" ELSE
         val_a(31 DOWNTO 1) & flag_q                         WHEN mode = x"0A" ELSE
         flag_q & val_a(30 DOWNTO 0)                         WHEN mode = x"0B" ELSE
         val_a(31 DOWNTO 1) & '0'                            WHEN mode = x"0C" ELSE
         '0' & val_a(30 DOWNTO 0)                            WHEN mode = x"0D" ELSE
         (OTHERS => '0');
        
  val_c <= rsl;
  flags <= flag_q;

END rtl;
