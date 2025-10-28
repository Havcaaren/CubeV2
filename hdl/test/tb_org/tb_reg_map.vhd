LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL; 


ENTITY tb_reg_map IS
END tb_reg_map;

ARCHITECTURE tb OF tb_reg_map IS
  TYPE t_arr IS ARRAY (0 to 14) OF std_logic_vector(31 downto 0);
  SHARED VARIABLE seed1, seed2 : integer := 1000;
  
  
  IMPURE FUNCTION rand_vec(min_val, max_val : integer) 
  RETURN std_logic_vector
  IS
    VARIABLE r : real;
  BEGIN
    uniform(seed1, seed2, r);
    RETURN std_logic_vector(
      to_unsigned(
        integer(
          round(r * real(max_val - min_val + 1) + real(min_val) - 0.5)
        ), 32
      )             
    );
  END FUNCTION;
  
  PROCEDURE store_number(
    CONSTANT pos : IN  std_logic_vector(3  DOWNTO 0);
    CONSTANT val : IN  std_logic_vector(31 DOWNTO 0);
    SIGNAL clk   : IN  std_logic;
    SIGNAL ld    : OUT std_logic;
    SIGNAL reg   : OUT std_logic_vector(3  DOWNTO 0);
    SIGNAL in_v  : OUT std_logic_vector(31 DOWNTO 0)
  ) IS 
  BEGIN
    reg  <= pos;
    in_v <= val;
    WAIT UNTIL rising_edge(clk);
    ld   <= '1';
    WAIT UNTIL rising_edge(clk);
    ld   <= '0';
  END PROCEDURE; 
  
  
  PROCEDURE get_number(
    CONSTANT pos : IN  std_logic_vector(3  DOWNTO 0);
    SIGNAL clk   : IN  std_logic;
    SIGNAL rd    : OUT std_logic;
    SIGNAL reg   : OUT std_logic_vector(3  DOWNTO 0);
    SIGNAL in_v  : IN  std_logic_vector(31 DOWNTO 0);
    VARIABLE val : OUT std_logic_vector(31 DOWNTO 0)
  ) IS 
  BEGIN
    reg  <= pos;
    rd   <= '1';
    WAIT UNTIL rising_edge(clk);   
    --WAIT UNTIL falling_edge(clk);
    val  := in_v;
    WAIT UNTIL rising_edge(clk);
    rd   <= '0';
  END PROCEDURE;
  
  
  PROCEDURE side(
    SIGNAL clk   : IN  std_logic;
    SIGNAL ld    : OUT std_logic;
    SIGNAL rd    : OUT std_logic;
    SIGNAL reg_i : OUT std_logic_vector(3  DOWNTO 0);
    SIGNAL reg_o : OUT std_logic_vector(3  DOWNTO 0);
    SIGNAL in_v  : OUT std_logic_vector(31 DOWNTO 0);
    SIGNAL out_v : IN  std_logic_vector(31 DOWNTO 0);
    VARIABLE cnt : OUT natural
  ) IS
    VARIABLE num : t_arr;
    VARIABLE n   : std_logic_vector(31 DOWNTO 0);
    VARIABLE cc  : natural := 0;
  BEGIN 
    REPORT "STORING NUMBERS";
    FOR idx IN 0 TO 14 LOOP
      num(idx) := rand_vec(0, 40000000);
      REPORT "SOTRED : " & integer'image(to_integer(unsigned(num(idx))));
      store_number(
        std_logic_vector(to_unsigned(idx, reg_i'length)),
          num(idx),
          clk, ld, reg_i, in_v
        );            
    END LOOP;
    WAIT FOR 98 ns;
    REPORT "GETTING NUMBERS";
    FOR idx IN 0 TO 14 LOOP      
      get_number(
        std_logic_vector(to_unsigned(idx, reg_o'length)),
          clk, rd, reg_o, out_v, n
        );
        IF n = num(idx) THEN 
          cc := cc + 1;
        END IF;
        
        REPORT "RETRIEVED : " & integer'image(to_integer(unsigned(n)));
        REPORT "EXPECTED : " & integer'image(to_integer(unsigned(num(idx))));
    END LOOP;
    cnt := cc;
  END PROCEDURE;

    
    
  COMPONENT reg_map IS
  PORT (
    clk           : IN std_logic;
    rst_a         : IN std_logic;
      
    reg_sel_A     : IN std_logic_vector(3 DOWNTO 0);
    reg_sel_B     : IN std_logic_vector(3 DOWNTO 0);
    reg_sel_C     : IN std_logic_vector(3 DOWNTO 0);
       
    clr           : IN std_logic;
    rd            : IN std_logic;
    ld            : IN std_logic;

	input         : IN  std_logic_vector(31 DOWNTO 0);
    output_A      : OUT std_logic_vector(31 DOWNTO 0);
    output_B      : OUT std_logic_vector(31 DOWNTO 0)
  );
  END COMPONENT reg_map;
    
  SIGNAL clk       : std_logic;
  SIGNAL rst_a     : std_logic;
    
  SIGNAL clr_i     : std_logic := '0';
  SIGNAL rd_i      : std_logic := '0';
  SIGNAL ld_i      : std_logic := '0';

  SIGNAL in_i      : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL out_A_i   : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL out_B_i   : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
    
  SIGNAL reg_sel_A : std_logic_vector(3  DOWNTO 0) := "0000";
  SIGNAL reg_sel_B : std_logic_vector(3  DOWNTO 0) := "0000";
  SIGNAL reg_sel_C : std_logic_vector(3  DOWNTO 0) := "0000";
    
  SHARED VARIABLE cc : natural := 0;

  CONSTANT TIMEOUT : integer := 100000;

BEGIN

  PROCESS 
  BEGIN
    FOR idx IN 0 TO TIMEOUT LOOP
      clk <= '0';
      WAIT FOR 10 ns;
      clk <= '1';
      WAIT FOR 10 ns;
    END LOOP;
    WAIT;
  END PROCESS;
    
  PROCESS 
  BEGIN
    rst_a <= '1';
    WAIT FOR 101 ns;
    rst_a <= '0';
    WAIT;
  END PROCESS;

  dut: reg_map
  PORT MAP (
    clk          => clk,
    rst_a        => rst_a,
        
    reg_sel_A    => reg_sel_A,
    reg_sel_B    => reg_sel_B,
    reg_sel_C    => reg_sel_C,
    clr          => clr_i,  
    rd           => rd_i,  
    ld           => ld_i,  

	input        => in_i, 
    output_A     => out_A_i, 
    output_B     => out_B_i
  );
   
  PROCESS 
  BEGIN
    WAIT FOR 10 ns;
    WAIT UNTIL rst_a = '0';

    --reg_sel_A <= "0000";
    --in_i <= x"0f0f0AA0";
    --WAIT FOR 1 ns;
    --ld_i <= '1';
    --WAIT until rising_edge(clk);
    --ld_i <= '0';
    --WAIT UNTIL rising_edge(clk);
    --WAIT UNTIL  rising_edge(clk);
    --
    --rd_i <= '1';
    --WAIT UNTIL  rising_edge(clk);

    --IF out_B_i <=  x"0f0f0AA0" THEN
    --  REPORT "CORR";
    --ELSE
    --  REPORT "FAIL";
    --END IF;

        
    --side(clk, ld_i, rd_i, reg_sel_C, reg_sel_A, in_i, out_A_i, cc);
    --IF cc = 15 THEN 
    --    REPORT "ALL CORRECT";
    --ELSE 
    --    REPORT "NO ALL CORRECT, CORRECT NUMBER: " & integer'image(cc);
    --END IF; 

    --ASSERT (FALSE) REPORT "END"
    --SEVERITY FAILURE;
    --store_number("0111", x"DE", clk, ld_A_i, reg_sel_A, in_A_i);

    %TEST%

    WAIT;
  END PROCESS;

END tb;
