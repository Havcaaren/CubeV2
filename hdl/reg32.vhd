LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY reg32 IS
PORT (
  clk        : IN  std_logic;
  rst_a      : IN  std_logic;
  
  clr        : IN  std_logic;
  set        : IN  std_logic;
  rd         : IN  std_logic;
  
  input_val  : IN  std_logic_vector(31 DOWNTO 0);
  L          : IN  std_logic;
  H          : IN  std_logic;
  W          : IN  std_logic;
  R          : IN  std_logic;  
  
  output_val : OUT std_logic_vector(31 DOWNTO 0)
);
END reg32;

ARCHITECTURE rtl OF reg32 IS
    SIGNAL reg_d, reg_q : std_logic_vector(31 DOWNTO 0);
BEGIN

    dff_reg: PROCESS (clk, rst_a) 
    BEGIN
        IF rst_a = '1' THEN
            reg_q <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF clr = '1' THEN
                reg_q <= (OTHERS => '0');
            ELSIF set = '1' THEN 
                reg_q <= (OTHERS => '1');
            ELSE
                reg_q <= reg_d;
            END IF;
        END IF;
    END PROCESS dff_reg;
    
    
    reg_d <= reg_q(31 DOWNTO 8)  & input_val(7  DOWNTO 0)                     WHEN L = '1' ELSE  
             reg_q(31 DOWNTO 16) & input_val(15 DOWNTO 8) & reg_q(7 DOWNTO 0) WHEN H = '1' ELSE  
             reg_q(31 DOWNTO 16) & input_val(15 DOWNTO 0)                     WHEN W = '1' ELSE  
                                   input_val(31 DOWNTO 0)                     WHEN R = '1' ELSE  
             reg_q;
    
    
    output_val <= reg_q WHEN rd = '1' ELSE (OTHERS => '0');
    
END rtl;