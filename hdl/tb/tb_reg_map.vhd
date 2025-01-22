library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY tb_reg_map is

end tb_reg_map;

architecture tb of tb_reg_map is
    
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

begin

    PROCESS 
    BEGIN
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    END PROCESS;
    
    PROCESS 
    BEGIN
        rst_a <= '1';
        wait for 101 ns;
        rst_a <= '0';
        wait ;
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
        wait for 10 ns;
        wait until rst_a = '0';
        
        store_number("0111", x"DE", clk, ld_A_i, reg_sel_A, in_A_i);
        
        wait;
    END PROCESS;


end tb;
