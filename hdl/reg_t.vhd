LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY reg_t IS
PORT (
  clk        : IN  std_logic;
  rst_a      : IN  std_logic;
  
  clr        : IN  std_logic;
  rd         : IN  std_logic;
  
  input_val  : IN  std_logic_vector(7 DOWNTO 0);
  ld         : IN  std_logic; 
  
  output_val : OUT std_logic_vector(7 DOWNTO 0)
);
END reg_t;

ARCHITECTURE rtl OF reg_t IS
    SIGNAL reg_d, reg_q : std_logic_vector(7 DOWNTO 0);
BEGIN

    dff_reg: PROCESS (clk, rst_a) 
    BEGIN
        IF rst_a = '1' THEN
            reg_q <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF clr = '1' THEN
                reg_q <= (OTHERS => '0');
            ELSE
                reg_q <= reg_d;
            END IF;
        END IF;
    END PROCESS dff_reg;
    
    
    reg_d <= input_val WHEN ld = '1' ELSE   
             reg_q;
    
    
    output_val <= reg_q WHEN rd = '1' ELSE (OTHERS => '0');
    
END rtl;