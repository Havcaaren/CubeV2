LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL; 


ENTITY tb_reg_map IS
END tb_reg_map;

ARCHITECTURE tb OF tb_reg_map IS
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

    %TEST%

    WAIT;
  END PROCESS;

END tb;
