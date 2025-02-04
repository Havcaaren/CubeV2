LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL; 


ENTITY tb_reg_map IS
END tb_reg_map;

ARCHITECTURE tb OF tb_reg_map IS
  TYPE t_arr IS ARRAY (0 to 14) OF std_logic_vector(7 downto 0);
  SHARED VARIABLE seed1, seed2 : integer := 999;
  
  
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
        ), 8
      )             
    );
  END FUNCTION;
  
  PROCEDURE store_number(
    CONSTANT pos : IN  std_logic_vector(3 DOWNTO 0);
    CONSTANT val : IN  std_logic_vector(7 DOWNTO 0);
    SIGNAL clk   : IN  std_logic;
    SIGNAL ld    : OUT std_logic;
    SIGNAL reg   : OUT std_logic_vector(3 DOWNTO 0);
    SIGNAL in_v  : OUT std_logic_vector(7 DOWNTO 0)
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
    CONSTANT pos : IN  std_logic_vector(3 DOWNTO 0);
    SIGNAL clk   : IN  std_logic;
    SIGNAL rd    : OUT std_logic;
    SIGNAL reg   : OUT std_logic_vector(3 DOWNTO 0);
    SIGNAL in_v  : IN  std_logic_vector(7 DOWNTO 0);
    VARIABLE val : OUT std_logic_vector(7 DOWNTO 0)
  ) IS 
  BEGIN
    reg  <= pos;
    WAIT UNTIL rising_edge(clk);
    rd   <= '1';
    val  := in_v;
    WAIT UNTIL falling_edge(clk);
    WAIT UNTIL rising_edge(clk);
    rd   <= '0';
  END PROCEDURE;
  
  
  PROCEDURE side(
    SIGNAL clk   : IN  std_logic;
    SIGNAL ld    : OUT std_logic;
    SIGNAL rd    : OUT std_logic;
    SIGNAL reg   : OUT std_logic_vector(3 DOWNTO 0);
    SIGNAL in_v  : OUT std_logic_vector(7 DOWNTO 0);
    SIGNAL out_v : IN  std_logic_vector(7 DOWNTO 0);
    VARIABLE cnt : OUT natural
  ) IS
    VARIABLE num : t_arr;
    VARIABLE n   : std_logic_vector(7 DOWNTO 0);
    VARIABLE cc  : natural := 0;
  BEGIN 
    REPORT "STORING NUMBERS";
    FOR idx IN 0 TO 14 LOOP
      num(idx) := rand_vec(0, 255);
      store_number(
        std_logic_vector(to_unsigned(idx, reg'length)),
          num(idx),
          clk, ld, reg, in_v
        );            
    END LOOP;
    
    FOR idx IN 0 TO 14 LOOP      
      get_number(
        std_logic_vector(to_unsigned(idx, reg'length)),
          clk, rd, reg, out_v, n
        );
        IF n = num(idx) THEN 
          cc := cc + 1;
        END IF;
    END LOOP;
    cnt := cc;
  END PROCEDURE;

    
    
  COMPONENT reg_map IS
  PORT (
    clk         : IN std_logic;
    rst_a       : IN std_logic;
      
    reg_sel_A   : IN std_logic_vector(3 DOWNTO 0);
    reg_sel_B   : IN std_logic_vector(3 DOWNTO 0);
    reg_sel_C   : IN std_logic_vector(3 DOWNTO 0);
       
      
    clr_A       : IN std_logic;
    rd_A        : IN std_logic;
    input_val_A : IN std_logic_vector(7 DOWNTO 0);
    ld_A        : IN std_logic;
      
    output_val_A  : OUT std_logic_vector(7 DOWNTO 0);
      
    clr_B       : IN std_logic;
    rd_B        : IN std_logic;
    input_val_B : IN std_logic_vector(7 DOWNTO 0);
    ld_B        : IN std_logic;
    output_val_B  : OUT std_logic_vector(7 DOWNTO 0);
      
    clr_C       : IN std_logic;
    rd_C        : IN std_logic;
    input_val_C : IN std_logic_vector(7 DOWNTO 0);
    ld_C        : IN std_logic;
    output_val_C  : OUT std_logic_vector(7 DOWNTO 0)
  );
  END COMPONENT reg_map;
    
  SIGNAL clk : std_logic;
  SIGNAL rst_a : std_logic;
  
  SIGNAL clr_A_i : std_logic := '0';
  SIGNAL rd_A_i  : std_logic := '0';
  SIGNAL ld_A_i  : std_logic := '0';
  SIGNAL in_A_i  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL out_A_i : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
   
  SIGNAL clr_B_i : std_logic := '0';
  SIGNAL rd_B_i  : std_logic := '0';
  SIGNAL ld_B_i  : std_logic := '0';
  SIGNAL in_B_i  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL out_B_i : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
    
  SIGNAL clr_C_i : std_logic := '0';
  SIGNAL rd_C_i  : std_logic := '0';
  SIGNAL ld_C_i  : std_logic := '0';
  SIGNAL in_C_i  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL out_C_i : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
    
  SIGNAL reg_sel_A : std_logic_vector(3 DOWNTO 0) := "1111";
  SIGNAL reg_sel_B : std_logic_vector(3 DOWNTO 0) := "1111";
  SIGNAL reg_sel_C : std_logic_vector(3 DOWNTO 0) := "1111";
    
  SHARED VARIABLE cc : natural := 0;
    
BEGIN

  PROCESS 
  BEGIN
    clk <= '0';
    WAIT FOR 10 ns;
    clk <= '1';
    WAIT FOR 10 ns;
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
    clk         => clk,
    rst_a       => rst_a,
        
    reg_sel_A   => reg_sel_A,
    reg_sel_B   => reg_sel_B,
    reg_sel_C   => reg_sel_C,
            
    clr_A       => clr_A_i,
    rd_A        => rd_A_i,
    input_val_A => in_A_i,
    ld_A        => ld_A_i,
    output_val_A => out_A_i,
        
    clr_B       => clr_B_i,
    rd_B        => rd_B_i,
    input_val_B => in_B_i,
    ld_B        => ld_B_i,
    output_val_B => out_B_i,
        
    clr_C       => clr_C_i,
    rd_C        => rd_C_i,
    input_val_C => in_C_i,
    ld_C        => ld_C_i,
    output_val_C => out_C_i
  );
   
  PROCESS 
  BEGIN
    WAIT FOR 10 ns;
    WAIT UNTIL rst_a = '0';
        
    side(clk, ld_A_i, rd_A_i, reg_sel_A, in_A_i, out_A_i, cc);
    --store_number("0111", x"DE", clk, ld_A_i, reg_sel_A, in_A_i);
        
    WAIT;
  END PROCESS;

END tb;
