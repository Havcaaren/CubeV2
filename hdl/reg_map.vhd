LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reg_map IS
PORT (
  clk         : IN  std_logic;
  rst_a       : IN  std_logic;
  
  reg_sel_A   : IN  std_logic_vector(3 DOWNTO 0);
  reg_sel_B   : IN  std_logic_vector(3 DOWNTO 0);
  reg_sel_C   : IN  std_logic_vector(3 DOWNTO 0);
   
  
  clr         : IN  std_logic;
  rd          : IN  std_logic;
  ld          : IN  std_logic;
  
  input       : IN  std_logic_vector(31 DOWNTO 0);
  output_A    : OUT std_logic_vector(31 DOWNTO 0);
  output_B    : OUT std_logic_vector(31 DOWNTO 0)
);
END reg_map;

ARCHITECTURE rtl OF reg_map IS 

	SUBTYPE reg_t IS std_logic_vector(31 DOWNTO 0);
	TYPE reg_map_t IS ARRAY (3 DOWNTO 0) OF reg_t;

	SIGNAL register_map : reg_map_t;

BEGIN

  ddf_clock_process: PROCESS (clk, rst_a)
	BEGIN
		IF rst_a = '1' THEN
      FOR i IN 0 TO 15 LOOP
        register_map(i) <= (OTHERS => '0');
      END LOOP;
		ELSIF rising_edge(clk) THEN 
      IF ld = '1' THEN
        register_map(to_integer(unsigned(reg_sel_C))) <= input;
      END IF;
		END IF;
	END PROCESS ddf_clock_process;

  output_A <= register_map(to_integer(unsigned(reg_sel_A))) WHEN reg_sel_A /= "1111" AND rd = '1' ELSE
              (OTHERS => '0');
  output_B <= register_map(to_integer(unsigned(reg_sel_B))) WHEN rreg_sel_B /= "1111" AND d = '1' ELSE
              (OTHERS => '0');


END rtl;
