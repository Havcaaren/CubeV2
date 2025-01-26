LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY reg_map IS
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
END reg_map;

ARCHITECTURE rtl OF reg_map IS 

    COMPONENT reg_t IS
    PORT (
        clk        : IN  std_logic;
        rst_a      : IN  std_logic;
        
        clr        : IN  std_logic;
        rd         : IN  std_logic;
        
        input_val  : IN  std_logic_vector(7 DOWNTO 0);
        ld         : IN  std_logic;
        
        output_val : OUT std_logic_vector(7 DOWNTO 0)
    );
    END COMPONENT reg_t;

    SIGNAL clr_r0_i : std_logic;
    SIGNAL rd_r0_i  : std_logic;
    SIGNAL ld_r0_i  : std_logic;
    SIGNAL in_r0_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r0_i : std_logic_vector(7 DOWNTO 0);
    
    SIGNAL clr_r1_i : std_logic;
    SIGNAL rd_r1_i  : std_logic;
    SIGNAL ld_r1_i  : std_logic;
    SIGNAL in_r1_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r1_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r2_i : std_logic;
    SIGNAL rd_r2_i  : std_logic;
    SIGNAL ld_r2_i  : std_logic;
    SIGNAL in_r2_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r2_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r3_i : std_logic;
    SIGNAL rd_r3_i  : std_logic;
    SIGNAL ld_r3_i  : std_logic;
    SIGNAL in_r3_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r3_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r4_i : std_logic;
    SIGNAL rd_r4_i  : std_logic;
    SIGNAL ld_r4_i  : std_logic;
    SIGNAL in_r4_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r4_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r5_i : std_logic;
    SIGNAL rd_r5_i  : std_logic;
    SIGNAL ld_r5_i  : std_logic;
    SIGNAL in_r5_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r5_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r6_i : std_logic;
    SIGNAL rd_r6_i  : std_logic;
    SIGNAL ld_r6_i  : std_logic;
    SIGNAL in_r6_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r6_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r7_i : std_logic;
    SIGNAL rd_r7_i  : std_logic;
    SIGNAL ld_r7_i  : std_logic;
    SIGNAL in_r7_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r7_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r8_i : std_logic;
    SIGNAL rd_r8_i  : std_logic;
    SIGNAL ld_r8_i  : std_logic;
    SIGNAL in_r8_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r8_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r9_i : std_logic;
    SIGNAL rd_r9_i  : std_logic;
    SIGNAL ld_r9_i  : std_logic;
    SIGNAL in_r9_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r9_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r10_i : std_logic;
    SIGNAL rd_r10_i  : std_logic;
    SIGNAL ld_r10_i  : std_logic;
    SIGNAL in_r10_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r10_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r11_i : std_logic;
    SIGNAL rd_r11_i  : std_logic;
    SIGNAL ld_r11_i  : std_logic;
    SIGNAL in_r11_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r11_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r12_i : std_logic;
    SIGNAL rd_r12_i  : std_logic;
    SIGNAL ld_r12_i  : std_logic;
    SIGNAL in_r12_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r12_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r13_i : std_logic;
    SIGNAL rd_r13_i  : std_logic;
    SIGNAL ld_r13_i  : std_logic;
    SIGNAL in_r13_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r13_i : std_logic_vector(7 DOWNTO 0);

    SIGNAL clr_r14_i : std_logic;
    SIGNAL rd_r14_i  : std_logic;
    SIGNAL ld_r14_i  : std_logic;
    SIGNAL in_r14_i  : std_logic_vector(7 DOWNTO 0);
    SIGNAL out_r14_i : std_logic_vector(7 DOWNTO 0);

BEGIN
    
    -- r0
    clr_r0_i <= clr_A        WHEN reg_sel_A = "0000" ELSE
                clr_B        WHEN reg_sel_B = "0000" ELSE
                clr_C        WHEN reg_sel_C = "0000" ELSE
                '0'; 
                
    rd_r0_i  <= rd_A         WHEN reg_sel_A = "0000" ELSE
                rd_B         WHEN reg_sel_B = "0000" ELSE
                rd_C         WHEN reg_sel_C = "0000" ELSE
                '0'; 
    
    in_r0_i  <= input_val_A  WHEN reg_sel_A = "0000" ELSE
                input_val_B  WHEN reg_sel_B = "0000" ELSE
                input_val_C  WHEN reg_sel_C = "0000" ELSE
                (OTHERS => '0'); 
    
    ld_r0_i  <= ld_A         WHEN reg_sel_A = "0000" ELSE
                ld_B         WHEN reg_sel_B = "0000" ELSE
                ld_C         WHEN reg_sel_C = "0000" ELSE
                '0';
    
    r0: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,
        
        clr         => clr_r0_i,
        rd          => rd_r0_i,
        
        input_val   => in_r0_i,
        ld          => ld_r0_i,

        output_val  => out_r0_i
    );
                     
                    
    
    -- r1
    clr_r1_i <= clr_A        WHEN reg_sel_A = "0001" ELSE
                clr_B        WHEN reg_sel_B = "0001" ELSE
                clr_C        WHEN reg_sel_C = "0001" ELSE
                '0';

    rd_r1_i  <= rd_A         WHEN reg_sel_A = "0001" ELSE
                rd_B         WHEN reg_sel_B = "0001" ELSE
                rd_C         WHEN reg_sel_C = "0001" ELSE
                '0';

    in_r1_i  <= input_val_A  WHEN reg_sel_A = "0001" ELSE
                input_val_B  WHEN reg_sel_B = "0001" ELSE
                input_val_C  WHEN reg_sel_C = "0001" ELSE
                (OTHERS => '0');

    ld_r1_i  <= ld_A         WHEN reg_sel_A = "0001" ELSE
                ld_B         WHEN reg_sel_B = "0001" ELSE
                ld_C         WHEN reg_sel_C = "0001" ELSE
                '0';

    r1: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r1_i,
        rd          => rd_r1_i,

        input_val   => in_r1_i,
        ld          => ld_r1_i,

        output_val  => out_r1_i
    );

    -- r2
    clr_r2_i <= clr_A        WHEN reg_sel_A = "0010" ELSE
                clr_B        WHEN reg_sel_B = "0010" ELSE
                clr_C        WHEN reg_sel_C = "0010" ELSE
                '0';

    rd_r2_i  <= rd_A         WHEN reg_sel_A = "0010" ELSE
                rd_B         WHEN reg_sel_B = "0010" ELSE
                rd_C         WHEN reg_sel_C = "0010" ELSE
                '0';

    in_r2_i  <= input_val_A  WHEN reg_sel_A = "0010" ELSE
                input_val_B  WHEN reg_sel_B = "0010" ELSE
                input_val_C  WHEN reg_sel_C = "0010" ELSE
                (OTHERS => '0');

    ld_r2_i  <= ld_A         WHEN reg_sel_A = "0010" ELSE
                ld_B         WHEN reg_sel_B = "0010" ELSE
                ld_C         WHEN reg_sel_C = "0010" ELSE
                '0';

    r2: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r2_i,
        rd          => rd_r2_i,

        input_val   => in_r2_i,
        ld          => ld_r2_i,

        output_val  => out_r2_i
    );

    -- r3
    clr_r3_i <= clr_A        WHEN reg_sel_A = "0011" ELSE
                clr_B        WHEN reg_sel_B = "0011" ELSE
                clr_C        WHEN reg_sel_C = "0011" ELSE
                '0';

    rd_r3_i  <= rd_A         WHEN reg_sel_A = "0011" ELSE
                rd_B         WHEN reg_sel_B = "0011" ELSE
                rd_C         WHEN reg_sel_C = "0011" ELSE
                '0';

    in_r3_i  <= input_val_A  WHEN reg_sel_A = "0011" ELSE
                input_val_B  WHEN reg_sel_B = "0011" ELSE
                input_val_C  WHEN reg_sel_C = "0011" ELSE
                (OTHERS => '0');

    ld_r3_i  <= ld_A         WHEN reg_sel_A = "0011" ELSE
                ld_B         WHEN reg_sel_B = "0011" ELSE
                ld_C         WHEN reg_sel_C = "0011" ELSE
                '0';

    r3: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r3_i,
        rd          => rd_r3_i,

        input_val   => in_r3_i,
        ld          => ld_r3_i,

        output_val  => out_r3_i
    );

    -- r4
    clr_r4_i <= clr_A        WHEN reg_sel_A = "0100" ELSE
                clr_B        WHEN reg_sel_B = "0100" ELSE
                clr_C        WHEN reg_sel_C = "0100" ELSE
                '0';

    rd_r4_i  <= rd_A         WHEN reg_sel_A = "0100" ELSE
                rd_B         WHEN reg_sel_B = "0100" ELSE
                rd_C         WHEN reg_sel_C = "0100" ELSE
                '0';

    in_r4_i  <= input_val_A  WHEN reg_sel_A = "0100" ELSE
                input_val_B  WHEN reg_sel_B = "0100" ELSE
                input_val_C  WHEN reg_sel_C = "0100" ELSE
                (OTHERS => '0');

    ld_r4_i  <= ld_A         WHEN reg_sel_A = "0100" ELSE
                ld_B         WHEN reg_sel_B = "0100" ELSE
                ld_C         WHEN reg_sel_C = "0100" ELSE
                '0';

    r4: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r4_i,
        rd          => rd_r4_i,

        input_val   => in_r4_i,
        ld          => ld_r4_i,

        output_val  => out_r4_i
    );

    -- r5
    clr_r5_i <= clr_A        WHEN reg_sel_A = "0101" ELSE
                clr_B        WHEN reg_sel_B = "0101" ELSE
                clr_C        WHEN reg_sel_C = "0101" ELSE
                '0';

    rd_r5_i  <= rd_A         WHEN reg_sel_A = "0101" ELSE
                rd_B         WHEN reg_sel_B = "0101" ELSE
                rd_C         WHEN reg_sel_C = "0101" ELSE
                '0';

    in_r5_i  <= input_val_A  WHEN reg_sel_A = "0101" ELSE
                input_val_B  WHEN reg_sel_B = "0101" ELSE
                input_val_C  WHEN reg_sel_C = "0101" ELSE
                (OTHERS => '0');

    ld_r5_i  <= ld_A         WHEN reg_sel_A = "0101" ELSE
                ld_B         WHEN reg_sel_B = "0101" ELSE
                ld_C         WHEN reg_sel_C = "0101" ELSE
                '0';

    r5: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r5_i,
        rd          => rd_r5_i,

        input_val   => in_r5_i,
        ld          => ld_r5_i,

        output_val  => out_r5_i
    );

    -- r6
    clr_r6_i <= clr_A        WHEN reg_sel_A = "0110" ELSE
                clr_B        WHEN reg_sel_B = "0110" ELSE
                clr_C        WHEN reg_sel_C = "0110" ELSE
                '0';

    rd_r6_i  <= rd_A         WHEN reg_sel_A = "0110" ELSE
                rd_B         WHEN reg_sel_B = "0110" ELSE
                rd_C         WHEN reg_sel_C = "0110" ELSE
                '0';

    in_r6_i  <= input_val_A  WHEN reg_sel_A = "0110" ELSE
                input_val_B  WHEN reg_sel_B = "0110" ELSE
                input_val_C  WHEN reg_sel_C = "0110" ELSE
                (OTHERS => '0');

    ld_r6_i  <= ld_A         WHEN reg_sel_A = "0110" ELSE
                ld_B         WHEN reg_sel_B = "0110" ELSE
                ld_C         WHEN reg_sel_C = "0110" ELSE
                '0';

    r6: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r6_i,
        rd          => rd_r6_i,

        input_val   => in_r6_i,
        ld          => ld_r6_i,

        output_val  => out_r6_i
    );

    -- r7
    clr_r7_i <= clr_A        WHEN reg_sel_A = "0111" ELSE
                clr_B        WHEN reg_sel_B = "0111" ELSE
                clr_C        WHEN reg_sel_C = "0111" ELSE
                '0';

    rd_r7_i  <= rd_A         WHEN reg_sel_A = "0111" ELSE
                rd_B         WHEN reg_sel_B = "0111" ELSE
                rd_C         WHEN reg_sel_C = "0111" ELSE
                '0';

    in_r7_i  <= input_val_A  WHEN reg_sel_A = "0111" ELSE
                input_val_B  WHEN reg_sel_B = "0111" ELSE
                input_val_C  WHEN reg_sel_C = "0111" ELSE
                (OTHERS => '0');

    ld_r7_i  <= ld_A         WHEN reg_sel_A = "0111" ELSE
                ld_B         WHEN reg_sel_B = "0111" ELSE
                ld_C         WHEN reg_sel_C = "0111" ELSE
                '0';

    r7: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r7_i,
        rd          => rd_r7_i,

        input_val   => in_r7_i,
        ld          => ld_r7_i,

        output_val  => out_r7_i
    );

    -- r8
    clr_r8_i <= clr_A        WHEN reg_sel_A = "1000" ELSE
                clr_B        WHEN reg_sel_B = "1000" ELSE
                clr_C        WHEN reg_sel_C = "1000" ELSE
                '0';

    rd_r8_i  <= rd_A         WHEN reg_sel_A = "1000" ELSE
                rd_B         WHEN reg_sel_B = "1000" ELSE
                rd_C         WHEN reg_sel_C = "1000" ELSE
                '0';

    in_r8_i  <= input_val_A  WHEN reg_sel_A = "1000" ELSE
                input_val_B  WHEN reg_sel_B = "1000" ELSE
                input_val_C  WHEN reg_sel_C = "1000" ELSE
                (OTHERS => '0');

    ld_r8_i  <= ld_A         WHEN reg_sel_A = "1000" ELSE
                ld_B         WHEN reg_sel_B = "1000" ELSE
                ld_C         WHEN reg_sel_C = "1000" ELSE
                '0';

    r8: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r8_i,
        rd          => rd_r8_i,

        input_val   => in_r8_i,
        ld          => ld_r8_i,

        output_val  => out_r8_i
    );

    -- r9
    clr_r9_i <= clr_A        WHEN reg_sel_A = "1001" ELSE
                clr_B        WHEN reg_sel_B = "1001" ELSE
                clr_C        WHEN reg_sel_C = "1001" ELSE
                '0';

    rd_r9_i  <= rd_A         WHEN reg_sel_A = "1001" ELSE
                rd_B         WHEN reg_sel_B = "1001" ELSE
                rd_C         WHEN reg_sel_C = "1001" ELSE
                '0';

    in_r9_i  <= input_val_A  WHEN reg_sel_A = "1001" ELSE
                input_val_B  WHEN reg_sel_B = "1001" ELSE
                input_val_C  WHEN reg_sel_C = "1001" ELSE
                (OTHERS => '0');

    ld_r9_i  <= ld_A         WHEN reg_sel_A = "1001" ELSE
                ld_B         WHEN reg_sel_B = "1001" ELSE
                ld_C         WHEN reg_sel_C = "1001" ELSE
                '0';

    r9: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r9_i,
        rd          => rd_r9_i,

        input_val   => in_r9_i,
        ld          => ld_r9_i,

        output_val  => out_r9_i
    );

    -- r10
    clr_r10_i <= clr_A        WHEN reg_sel_A = "1010" ELSE
                 clr_B        WHEN reg_sel_B = "1010" ELSE
                 clr_C        WHEN reg_sel_C = "1010" ELSE
                 '0';

    rd_r10_i  <= rd_A         WHEN reg_sel_A = "1010" ELSE
                 rd_B         WHEN reg_sel_B = "1010" ELSE
                 rd_C         WHEN reg_sel_C = "1010" ELSE
                 '0';

    in_r10_i  <= input_val_A  WHEN reg_sel_A = "1010" ELSE
                 input_val_B  WHEN reg_sel_B = "1010" ELSE
                 input_val_C  WHEN reg_sel_C = "1010" ELSE
                 (OTHERS => '0');

    ld_r10_i  <= ld_A         WHEN reg_sel_A = "1010" ELSE
                 ld_B         WHEN reg_sel_B = "1010" ELSE
                 ld_C         WHEN reg_sel_C = "1010" ELSE
                 '0';

    r10: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r10_i,
        rd          => rd_r10_i,

        input_val   => in_r10_i,
        ld          => ld_r10_i,

        output_val  => out_r10_i
    );

    -- r11
    clr_r11_i <= clr_A        WHEN reg_sel_A = "1011" ELSE
                 clr_B        WHEN reg_sel_B = "1011" ELSE
                 clr_C        WHEN reg_sel_C = "1011" ELSE
                 '0';

    rd_r11_i  <= rd_A         WHEN reg_sel_A = "1011" ELSE
                 rd_B         WHEN reg_sel_B = "1011" ELSE
                 rd_C         WHEN reg_sel_C = "1011" ELSE
                 '0';

    in_r11_i  <= input_val_A  WHEN reg_sel_A = "1011" ELSE
                 input_val_B  WHEN reg_sel_B = "1011" ELSE
                 input_val_C  WHEN reg_sel_C = "1011" ELSE
                 (OTHERS => '0');

    ld_r11_i  <= ld_A         WHEN reg_sel_A = "1011" ELSE
                 ld_B         WHEN reg_sel_B = "1011" ELSE
                 ld_C         WHEN reg_sel_C = "1011" ELSE
                 '0';

    r11: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r11_i,
        rd          => rd_r11_i,

        input_val   => in_r11_i,
        ld          => ld_r11_i,

        output_val  => out_r11_i
    );

    -- r12
    clr_r12_i <= clr_A        WHEN reg_sel_A = "1100" ELSE
                 clr_B        WHEN reg_sel_B = "1100" ELSE
                 clr_C        WHEN reg_sel_C = "1100" ELSE
                 '0';

    rd_r12_i  <= rd_A         WHEN reg_sel_A = "1100" ELSE
                 rd_B         WHEN reg_sel_B = "1100" ELSE
                 rd_C         WHEN reg_sel_C = "1100" ELSE
                 '0';

    in_r12_i  <= input_val_A  WHEN reg_sel_A = "1100" ELSE
                 input_val_B  WHEN reg_sel_B = "1100" ELSE
                 input_val_C  WHEN reg_sel_C = "1100" ELSE
                 (OTHERS => '0');

    ld_r12_i  <= ld_A         WHEN reg_sel_A = "1100" ELSE
                 ld_B         WHEN reg_sel_B = "1100" ELSE
                 ld_C         WHEN reg_sel_C = "1100" ELSE
                 '0';

    r12: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r12_i,
        rd          => rd_r12_i,

        input_val   => in_r12_i,
        ld          => ld_r12_i,

        output_val  => out_r12_i
    );

    -- r13
    clr_r13_i <= clr_A        WHEN reg_sel_A = "1101" ELSE
                 clr_B        WHEN reg_sel_B = "1101" ELSE
                 clr_C        WHEN reg_sel_C = "1101" ELSE
                 '0';

    rd_r13_i  <= rd_A         WHEN reg_sel_A = "1101" ELSE
                 rd_B         WHEN reg_sel_B = "1101" ELSE
                 rd_C         WHEN reg_sel_C = "1101" ELSE
                 '0';

    in_r13_i  <= input_val_A  WHEN reg_sel_A = "1101" ELSE
                 input_val_B  WHEN reg_sel_B = "1101" ELSE
                 input_val_C  WHEN reg_sel_C = "1101" ELSE
                 (OTHERS => '0');

    ld_r13_i  <= ld_A         WHEN reg_sel_A = "1101" ELSE
                 ld_B         WHEN reg_sel_B = "1101" ELSE
                 ld_C         WHEN reg_sel_C = "1101" ELSE
                 '0';

    r13: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r13_i,
        rd          => rd_r13_i,

        input_val   => in_r13_i,
        ld          => ld_r13_i,

        output_val  => out_r13_i
    );

    -- r14
    clr_r14_i <= clr_A        WHEN reg_sel_A = "1110" ELSE
                 clr_B        WHEN reg_sel_B = "1110" ELSE
                 clr_C        WHEN reg_sel_C = "1110" ELSE
                 '0';

    rd_r14_i  <= rd_A         WHEN reg_sel_A = "1110" ELSE
                 rd_B         WHEN reg_sel_B = "1110" ELSE
                 rd_C         WHEN reg_sel_C = "1110" ELSE
                 '0';

    in_r14_i  <= input_val_A  WHEN reg_sel_A = "1110" ELSE
                 input_val_B  WHEN reg_sel_B = "1110" ELSE
                 input_val_C  WHEN reg_sel_C = "1110" ELSE
                 (OTHERS => '0');

    ld_r14_i  <= ld_A         WHEN reg_sel_A = "1110" ELSE
                 ld_B         WHEN reg_sel_B = "1110" ELSE
                 ld_C         WHEN reg_sel_C = "1110" ELSE
                 '0';

    r14: reg_t
    PORT MAP (
        clk         => clk,
        rst_a       => rst_a,

        clr         => clr_r14_i,
        rd          => rd_r14_i,

        input_val   => in_r14_i,
        ld          => ld_r14_i,

        output_val  => out_r14_i
    );

    
    output_val_A <= out_r0_i  WHEN reg_sel_A = "0000" ELSE 
                    out_r1_i  WHEN reg_sel_A = "0001" ELSE 
                    out_r2_i  WHEN reg_sel_A = "0010" ELSE 
                    out_r3_i  WHEN reg_sel_A = "0011" ELSE 
                    out_r4_i  WHEN reg_sel_A = "0100" ELSE 
                    out_r5_i  WHEN reg_sel_A = "0101" ELSE 
                    out_r6_i  WHEN reg_sel_A = "0110" ELSE 
                    out_r7_i  WHEN reg_sel_A = "0111" ELSE 
                    out_r8_i  WHEN reg_sel_A = "1000" ELSE 
                    out_r9_i  WHEN reg_sel_A = "1001" ELSE 
                    out_r10_i WHEN reg_sel_A = "1010" ELSE 
                    out_r11_i WHEN reg_sel_A = "1011" ELSE 
                    out_r12_i WHEN reg_sel_A = "1100" ELSE 
                    out_r13_i WHEN reg_sel_A = "1101" ELSE 
                    out_r14_i WHEN reg_sel_A = "1110" ELSE 
                    (OTHERS => '0');
    
    output_val_B <= out_r0_i  WHEN reg_sel_B = "0000" ELSE 
                    out_r1_i  WHEN reg_sel_B = "0001" ELSE 
                    out_r2_i  WHEN reg_sel_B = "0010" ELSE 
                    out_r3_i  WHEN reg_sel_B = "0011" ELSE 
                    out_r4_i  WHEN reg_sel_B = "0100" ELSE 
                    out_r5_i  WHEN reg_sel_B = "0101" ELSE 
                    out_r6_i  WHEN reg_sel_B = "0110" ELSE 
                    out_r7_i  WHEN reg_sel_B = "0111" ELSE 
                    out_r8_i  WHEN reg_sel_B = "1000" ELSE 
                    out_r9_i  WHEN reg_sel_B = "1001" ELSE 
                    out_r10_i WHEN reg_sel_B = "1010" ELSE 
                    out_r11_i WHEN reg_sel_B = "1011" ELSE 
                    out_r12_i WHEN reg_sel_B = "1100" ELSE 
                    out_r13_i WHEN reg_sel_B = "1101" ELSE 
                    out_r14_i WHEN reg_sel_B = "1110" ELSE 
                    (OTHERS => '0');  
                    
                    
    output_val_C <= out_r0_i  WHEN reg_sel_C = "0000" ELSE 
                    out_r1_i  WHEN reg_sel_C = "0001" ELSE 
                    out_r2_i  WHEN reg_sel_C = "0010" ELSE 
                    out_r3_i  WHEN reg_sel_C = "0011" ELSE 
                    out_r4_i  WHEN reg_sel_C = "0100" ELSE 
                    out_r5_i  WHEN reg_sel_C = "0101" ELSE 
                    out_r6_i  WHEN reg_sel_C = "0110" ELSE 
                    out_r7_i  WHEN reg_sel_C = "0111" ELSE 
                    out_r8_i  WHEN reg_sel_C = "1000" ELSE 
                    out_r9_i  WHEN reg_sel_C = "1001" ELSE 
                    out_r10_i WHEN reg_sel_C = "1010" ELSE 
                    out_r11_i WHEN reg_sel_C = "1011" ELSE 
                    out_r12_i WHEN reg_sel_C = "1100" ELSE 
                    out_r13_i WHEN reg_sel_C = "1101" ELSE 
                    out_r14_i WHEN reg_sel_C = "1110" ELSE 
                    (OTHERS => '0');            
    
END rtl;