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

  SIGNAL res_sig : signed(31 DOWNTO 0);
  SIGNAL res_uns : unsigned(31 DOWNTO 0);
  SIGNAL result  : std_logic_vector(31 DOWNTO 0);

BEGIN

  ddf_proc: PROCESS (clk, rst_a)
  BEGIN
    IF rst_a = '1' THEN 
      flag_q <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF flag_e = '1' THEN
        flag_q <= flag_d;
      END IF;
    END IF;
  END PROCESS ddf_proc;

  flag_e <= '1' WHEN flag_d /= flag_q ELSE
            '0';

  -- Zero
  flag_d(0) <= '1' WHEN result = x"0000" ELSE
               '0';
  
  -- Neg
  flag_d(1) <= '1' WHEN mode(7) = '1' AND result(31) = '1' ELSE
               '0';

  -- Over
  --flag_d(0) <= '1' WHEN result = (OTHERS => '0') ELSE
  --             '0';
  
  res_sig <= signed(val_a) +    signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0000000" ELSE
             signed(val_a) -    signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0000001" ELSE
             signed(val_a) SLL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "0000010" ELSE
             signed(val_a) SRL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "0000011" ELSE
             signed(val_a) ROL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "0000100" ELSE
             signed(val_a) ROR  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "0000101" ELSE
             signed(val_a) AND  signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0000110" ELSE
             signed(val_a) NAND signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0000111" ELSE
             signed(val_a) OR   signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0001000" ELSE
             signed(val_a) NOR  signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0001001" ELSE
             signed(val_a) XOR  signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0001010" ELSE
             signed(val_a) XNOR signed(val_b)                           WHEN mode(6 DOWNTO 0) = "0001011" ELSE
             NOT signed(val_a)                                          WHEN mode(6 DOWNTO 0) = "0001100" ELSE
             NOT signed(val_b)                                          WHEN mode(6 DOWNTO 0) = "0001101" ELSE
             signed(val_a)                                              WHEN mode(6 DOWNTO 0) = "0001110" ELSE
             signed(val_b); --                                    WHEN mode(6 DOWNTO 0) = "0001111" ELSE


  res_uns <= unsigned(val_a) +    unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1000000" ELSE
             unsigned(val_a) -    unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1000001" ELSE
             unsigned(val_a) SLL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "1000010" ELSE
             unsigned(val_a) SRL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "1000011" ELSE
             unsigned(val_a) ROL  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "1000100" ELSE
             unsigned(val_a) ROR  to_integer(unsigned(val_b(4 DOWNTO 0))) WHEN mode(6 DOWNTO 0) = "1000101" ELSE
             unsigned(val_a) AND  unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1000110" ELSE
             unsigned(val_a) NAND unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1000111" ELSE
             unsigned(val_a) OR   unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1001000" ELSE
             unsigned(val_a) NOR  unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1001001" ELSE
             unsigned(val_a) XOR  unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1001010" ELSE
             unsigned(val_a) XNOR unsigned(val_b)                         WHEN mode(6 DOWNTO 0) = "1001011" ELSE
             NOT unsigned(val_a)                                          WHEN mode(6 DOWNTO 0) = "1001100" ELSE
             NOT unsigned(val_b)                                          WHEN mode(6 DOWNTO 0) = "1001101" ELSE
             unsigned(val_a)                                              WHEN mode(6 DOWNTO 0) = "1001110" ELSE
             unsigned(val_b); --                                    WHEN mode(6 DOWNTO 0) = "1001111" ELSE


  result <= std_logic_vector(res_sig) WHEN mode(7) = '1' ELSE
            std_logic_vector(res_uns);

  val_c <= result;
  flags <= flag_q;

END rtl;
