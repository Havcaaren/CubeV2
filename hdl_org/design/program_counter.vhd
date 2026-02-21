LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY design;
USE design.constants_pkg.ALL;

ENTITY program_counter IS 
  PORT (
    data_in  : IN  std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
    pl_cp    : IN  std_logic;
    ph_cp    : IN  std_logic;
    p_ld     : IN  std_logic;
    p_clr    : IN  std_logic;
    p_inc    : IN  std_logic;
    p_oe     : IN  std_logic;

    data_out : OUT std_logic_vector(BUS_WIDTH - 1 DOWNTO 0)
  );
END program_counter;


ARCHITECTURE rtl OF program_counter IS 

  SIGNAL data_low_i    : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
  SIGNAL data_high_i   : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
  
  SIGNAL c8_i          : std_logic;
 
  SIGNAL data_low_q_i  : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);
  SIGNAL data_high_q_i : std_logic_vector(BUS_WIDTH - 1 DOWNTO 0);

  TYPE ROM_t IS ARRAY (0 TO 65_536) OF std_logic_vector(7 DOWNTO 0) := (
    x"00", 
    X"02", 
    X"A2", 
    X"02", 
    X"A2", 
    X"08",
    OTHERS => '0'
  );

  SIGNAL rom_i : ROM_t;

BEGIN 

  i_reg_low : design.register(rtl)
  PORT MAP (
    data_in  => data_in,
    cp       => pl_cp,
    oe       => '1',
    data_out => data_low_q_i
  );

  i_reg_high : design.register(rtl)
  PORT MAP (
    data_in  => data_in,
    cp       => ph_cp,
    oe       => '1',
    data_out => data_high_q_i
  );


  p_pc_low : PROCESS(p_clr, p_inc)
  BEGIN
    IF (p_clr = '0') THEN
      data_low_i <= (OTHERS => '0');
    ELSIF risign_edge(p_inc) THEN
      data_low_i <= std_logic_vector(unsigned(data_low_q_i) + 1);
    END IF;
  END PROCESS p_pc_low;

  c8_i <= data_low_i(BUS_WIDTH - 1);

  p_pc_high : PROCESS(p_clr, c8_i)
  BEGIN
    IF (p_clr = '0') THEN
      data_high_i <= (OTHERS => '0');
    ELSIF risign_edge(c8_i) THEN
      data_high_i <= std_logic_vector(unsigned(data_high_q_i) + 1);
    END IF;
  END PROCESS p_pc_high;

  data_out <= rom_i()

END rtl;