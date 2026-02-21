LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY design;
USE design.constants_pkg.ALL;

ENTITY register 
  PORT (
    data_in  : IN  std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
    cp       : IN  std_logic;
    oe       : IN  std_logic;

    data_out : OUT std_logic_vector(BUS_WIDTH - 1 DOWNTO 0)
  );
END register;

ARCHITECTURE rtl OF register IS 

  SIGNAL data_i : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0)

BEGIN 

  p_register_dff: PROCESS (cp)
  BEGIN 
    IF rising_edge(cp) THEN
      data_i <= data_in;
    END IF;
  END PROCESS p_register_dff;


  data_out <= data_i WHEN oe = '1' ELSE
              (OTHERS => '0');

END rtl;