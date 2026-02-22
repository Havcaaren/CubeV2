LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY design;

ENTITY alu IS 
  PORT (
    data_in  : IN  std_logic_vector(7 DOWNTO 0);

    a_cp     : IN std_logic;
    a_oe     : IN std_logic;
    at_cp    : IN std_logic;
    at_oe    : IN std_logic;
    
    t_and    : IN std_logic;
    t_or     : IN std_logic;
    t_not    : IN std_logic;
    t_xor    : IN std_logic;
    t_or     : IN std_logic;
    t_add    : IN std_logic;
    t_sub    : IN std_logic;

    flags    : OUT std_logic_vector(7 DOWNTO 0);
    data_out : OUT std_logic_vector(7 DOWNTO 0)
  );
END alu;


ARCHITECTURE rtl OF alu IS 

  SIGNAL a_data_i  : std_logic_vector(7 DOWNTO 0);
  SIGNAL at_data_i : std_logic_vector(7 DOWNTO 0);
  SIGNAL res_i     : std_logic_vector(7 DOWNTO 0);

  SIGNAL and_i : std_logic_vector(7 DOWNTO 0);
  SIGNAL or_i  : std_logic_vector(7 DOWNTO 0);
  SIGNAL xor_i : std_logic_vector(7 DOWNTO 0);
  SIGNAL not_i : std_logic_vector(7 DOWNTO 0);

BEGIN 

  i_a : ENTITY design.register(rtl)
  PORT MAP (
    data_in  => data_in,
    cp       => a_cp,
    oe       => a_oe,
    data_out => a_data_i
  );

  i_at : ENTITY design.register(rtl)
  PORT MAP (
    data_in  => res_i,
    cp       => at_cp,
    oe       => at_oe,
    data_out => at_data_i,
  );

  res_i <= NOT(a_data_i)        WHEN t_not = '1' ELSE
           a_data_i AND data_in WHEN t_and = '1' ELSE
           a_data_i OR  data_in WHEN t_or  = '1' ELSE
           a_data_i XOR data_in WHEN t_xor = '1' ELSE
           


  -- not same as original
  data_out <= a_data_i OR at_data_i;

END rtl;