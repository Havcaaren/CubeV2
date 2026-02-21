LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ram IS 
  PORT (
    data_in  : IN  std_logic_vector(7 DOWNTO 0);
    address  : IN  std_logic_vector(12 DOWNTO 0);
    oe       : IN  std_logic;
    cp       : IN  std_logic;

    data_out : OUT std_logic_vector(7 DOWNTO 0)
  );
END ram;


ARCHITECTURE rtl OF ram IS 

  TYPE rom_t IS ARRAY (0 TO 12000) OF std_logic_vector(7 DOWNTO 0);

  SIGNAL rom_i : rom_t;

  SIGNAL data_i : std_logic_vector((12000*8) - 1 DOWNTO 0);

BEGIN 

  gen_reg: FOR i IN 0 TO 12000 GENERATE
    i_reg: design.register(rtl)
    PORT MAP (
      data_in  => data_in,
      oe       => '1',
      cp       => cp,
      data_out => data_i(((i + 1) * 8) - 1 DOWNTO i*8)
    );
  END GENERATE gen_reg;

END rtl;