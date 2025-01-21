LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY reg_map IS
PORT (
  clk         : IN std_logic;
  rst_a       : IN std_logic;
  
  reg_sel_A   : IN std_logic_vector(4 DOWNTO 0);
  reg_sel_B   : IN std_logic_vector(4 DOWNTO 0);
  reg_sel_C   : IN std_logic_vector(4 DOWNTO 0);
   
  
  clr_A       : IN std_logic;
  set_A       : IN std_logic;
  rd_A        : IN std_logic;
  input_val_A : IN std_logic_vector(31 DOWNTO 0);
  L_A         : IN std_logic;
  H_A         : IN std_logic;
  W_A         : IN std_logic;
  R_A         : IN std_logic;
  output_val_A  : OUT std_logic_vector(31 DOWNTO 0);
  
  clr_B       : IN std_logic;
  set_B       : IN std_logic;
  rd_B        : IN std_logic;
  input_val_B : IN std_logic_vector(31 DOWNTO 0);
  L_B         : IN std_logic;
  H_B         : IN std_logic;
  W_B         : IN std_logic;
  R_B         : IN std_logic;
  output_val_B  : OUT std_logic_vector(31 DOWNTO 0);
  
  clr_C       : IN std_logic;
  set_C       : IN std_logic;
  rd_C        : IN std_logic;
  input_val_C : IN std_logic_vector(31 DOWNTO 0);
  L_C         : IN std_logic;
  H_C         : IN std_logic;
  W_C         : IN std_logic;
  R_C         : IN std_logic;
  output_val_C  : OUT std_logic_vector(31 DOWNTO 0)
);
END reg_map;

ARCHITECTURE rtl OF reg_map IS 

    COMPONENT reg32 IS
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
    END COMPONENT reg32;

    SIGNAL clr_r0_i : std_logic;
    SIGNAL set_r0_i : std_logic;
    SIGNAL rd_r0_i  : std_logic;
    SIGNAL L_r0_i   : std_logic;
    SIGNAL H_r0_i   : std_logic;
    SIGNAL W_r0_i   : std_logic;
    SIGNAL R_r0_i   : std_logic;
    SIGNAL in_r0_i  : std_logic_vector(31 DOWNTO 0);
    SIGNAL out_r0_i : std_logic_vector(31 DOWNTO 0);
    

BEGIN
    
    clr_r0_i <= clr_A        WHEN reg_sel_A = "0000" ELSE
                clr_B        WHEN reg_sel_B = "0000" ELSE
                clr_C        WHEN reg_sel_C = "0000" ELSE
                '0'; 
                
    set_r0_i <= set_A        WHEN reg_sel_A = "0000" ELSE
                set_B        WHEN reg_sel_B = "0000" ELSE
                set_C        WHEN reg_sel_C = "0000" ELSE
                '0'; 
    
    rd_r0_i  <= rd_A         WHEN reg_sel_A = "0000" ELSE
                rd_B         WHEN reg_sel_B = "0000" ELSE
                rd_C         WHEN reg_sel_C = "0000" ELSE
                '0'; 
    
    in_r0_i  <= input_val_A  WHEN reg_sel_A = "0000" ELSE
                input_val_B  WHEN reg_sel_B = "0000" ELSE
                input_val_C  WHEN reg_sel_C = "0000" ELSE
                (OTHERS => '0'); 
    
    L_r0_i   <= L_A          WHEN reg_sel_A = "0000" ELSE
                L_B          WHEN reg_sel_B = "0000" ELSE
                L_C          WHEN reg_sel_C = "0000" ELSE
                '0';
                
    H_r0_i   <= H_A          WHEN reg_sel_A = "0000" ELSE
                H_B          WHEN reg_sel_B = "0000" ELSE
                H_C          WHEN reg_sel_C = "0000" ELSE
                '0';
    
    W_r0_i   <= W_A          WHEN reg_sel_A = "0000" ELSE
                W_B          WHEN reg_sel_B = "0000" ELSE
                W_C          WHEN reg_sel_C = "0000" ELSE
                '0';

    R_r0_i   <= R_A          WHEN reg_sel_A = "0000" ELSE
                R_B          WHEN reg_sel_B = "0000" ELSE
                R_C          WHEN reg_sel_C = "0000" ELSE
                '0';
    
    
    r0: reg32
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,
        
        clr         => clr_r0_i,
        set         => set_r0_i,
        rd          => rd_r0_i,
        
        input_val   => in_r0_i,
        L           => L_r0_i,
        H           => H_r0_i,
        W           => W_r0_i,
        R           => R_r0_i,
        
        output_val  => out_r0_i
    );
    
    
    output_val_A <= out_r0_i WHEN reg_sel_A = "0000" ELSE 
                    (OTHERS => '0');
                    
    output_val_B <= out_r0_i WHEN reg_sel_B = "0000" ELSE 
                    (OTHERS => '0');
    
    output_val_C <= out_r0_i WHEN reg_sel_C = "0000" ELSE 
                    (OTHERS => '0'); 
END rtl;