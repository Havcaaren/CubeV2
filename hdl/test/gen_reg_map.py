import sys
from random import randint


NUMBER_OF_TEST : int = 1 if len(sys.argv) == 2 else sys.argv[2]
BITS           : int = 8

RM_LEN   : int = 15

SELECTOR : list = ['reg_sel_A', 'reg_sel_B', 'reg_sel_C']
OUTPUTS  : list = ['out_A_i', 'out_B_i']


WAIT_FALL : str = "WAIT UNTIL falling_edge(clk);"
WAIT_RIS  : str = "WAIT UNTIL rising_edge(clk);"


###################################################################

class Model_RM:
    def __init__(self):
        self.RM : list = [None for i in range(15)]
        self.A = 0
        self.B = 0
        self.C = 0

    def sel(self, A : int, B : int, C : int):
        self.A = A
        self.B = B
        self.C = C


    def store(self, val : int): 
        self.RM[self.C] = val


    def get(self):
        return (self.RM[self.A], self.RM[self.B]);


def to_hex(val : int, length : int):
    return 'x"' + '0'*(length - len(hex(val)[2:]))  + hex(val)[2:] + '"'



m = Model_RM()

buffer : list = []


# stor - get
for i in range(NUMBER_OF_TEST):
    for j in range(RM_LEN):
        m.sel(0, 0, j)
        val  : int = randint(0, 2**BITS - 1)
        m.store(val)
        
        buffer.append('REPORT "==========================================";')
        buffer.append('REPORT "Pos: ' + str(j) + '";')
        buffer.append('REPORT "Val: ' + str(val) + '";')
        buffer.append(f"{SELECTOR[2]} <= {to_hex(j, 1)};")
        buffer.append(f"in_i <= {to_hex(val, 8)};")
        buffer.append(f"{WAIT_FALL}")
        buffer.append(f"ld_i <= '1';")
        buffer.append(f"{WAIT_RIS}")
        buffer.append(f"ld_i <= '0';")
        buffer.append('REPORT "==========================================";')
    
    buffer.append(f"WAIT FOR 5 ns;")
    buffer.append(f"{WAIT_RIS}")
    
    for j in range(RM_LEN):
        m.sel(j, j, 0)
        buffer.append('REPORT "==========================================";')
        buffer.append(f"{SELECTOR[0]} <= {to_hex(j, 1)};")
        buffer.append(f"{SELECTOR[1]} <= {to_hex(j, 1)};")
        buffer.append(f"rd_i <= '1';")
        buffer.append(f"{WAIT_RIS}")
        buffer.append('REPORT "Pos: ' + str(j) + '";')
        buffer.append('REPORT "O_A:";')
        buffer.append("REPORT integer'image(to_integer(unsigned(out_A_i)));")
        buffer.append('REPORT "O_B:";')
        buffer.append("REPORT integer'image(to_integer(unsigned(out_B_i)));")
        buffer.append(f"IF out_A_i = {to_hex(m.get()[0], 8)} THEN")
        buffer.append('REPORT "PASS";')
        buffer.append('ELSE')
        buffer.append('REPORT "FAIL";')
        buffer.append('END IF;')
        buffer.append(f"rd_i <= '0';")
        buffer.append('REPORT "==========================================";')

buffer = ['\t\t' + i for i in buffer]
buffer = '\n'.join(buffer)

with open(sys.argv[1], 'r') as f:
    file : str = f.read()
    file = file.replace('%TEST%', buffer)
with open(sys.argv[1], 'w') as f:
    f.write(file)

