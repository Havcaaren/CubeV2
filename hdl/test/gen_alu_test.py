from random import randint
import sys
import threading

#######################################################################


IO_SIZE : int = 32
MAX_NUB : int = 32

NUMBER_OF_TESTS : int = 300000  if len(sys.argv) ==  2 else int(sys.argv[2])

INPUTS_SIGNALS  : list = ['val_a_i', 'val_b_i']
OUTPUTS_SIGNALS : list = ['val_c_i']

CLOCK : int = 9

#######################################################################


res : list = ['' for i in range(8)]

class Model_ALU:
    def __init__(self):
        self.a = 0
        self.b = 0
        self.c = 0


    def put(self, inputs):
        self.a = inputs[0]
        self.b = inputs[1]


    def execute(self):
        self.c = self.a + self.b;


    def get(self):
        return self.c & 0xFFFFFFFF


def get_rand() -> str:
    return randint(0, (2**MAX_NUB) - 1)


def get_hex(input : int) -> str:
    val : str = hex(input)[2:]
    return 'x"' + '0'*((IO_SIZE//4)-len(val)) + val + '"'


def get_model(m : Model_ALU, inputs : list) -> list:
    m.put(inputs)
    m.execute()
    return ([get_hex(m.get())], m.get())


def gen_test(a : int, b : int, c : int):
    buffer : str = ''
    model = Model_ALU()
    inputs : list = []

    for i in range(a, b):
        buffer += '\t-- Test' + str(i) + ':\n'

        inputs : list = [get_rand() for _ in INPUTS_SIGNALS]
        outputs, v  = get_model(model, inputs)
        
        # set
        for s in zip(INPUTS_SIGNALS, inputs):
            buffer += '\t' + s[0] + ' <= ' + get_hex(s[1]) + ';\n'
        
        # delay
        buffer += "\tWAIT FOR " + str(CLOCK) + " ns;\n"
       
        # check
        for s in zip(OUTPUTS_SIGNALS, outputs):
            buffer += '\tREPORT "========================================";\n'
            buffer += '\tREPORT "Model A: ' + str(inputs[0]) + '";\n'
            buffer += '\tREPORT "Model B: ' + str(inputs[1]) + '";\n'
            buffer += '\tREPORT "Model C: ' + str(int('0x' + outputs[0][2:-1], 16)) + '";\n'
            buffer += '\tREPORT "VAL A:";'
            buffer += "\tREPORT integer'image(to_integer(unsigned(val_a_i)));\n"
            buffer += '\tREPORT "VAL B:";'
            buffer += "\tREPORT integer'image(to_integer(unsigned(val_b_i)));\n"
            buffer += '\tREPORT "VAL C:";'
            buffer += "\tREPORT integer'image(to_integer(unsigned(val_c_i)));\n"
            buffer += '\tIF ' + s[0] + ' = ' + s[1]  + ' THEN\n'
            buffer += '\t\tREPORT "PASS";\n'
            buffer += '\tELSE'
            buffer += '\t\tREPORT "FAIL";\n'
            buffer += '\tEND IF;\n'
            buffer += '\tREPORT "========================================";\n'

        buffer += '\n'
    res[c] = buffer
    print(f"Thread: {a} -> {b} DONE")


it = NUMBER_OF_TESTS // 8
pos = 0
treads : list = []
for i in range(8):
    treads.append(threading.Thread(target=gen_test, args=(pos,pos + it, i, )))
    pos += it

a = [i.start() for i in treads]
b = [i.join() for i in treads]

buffer = '\n'.join(res)

with open(sys.argv[1], 'r') as f:
    file = f.read()

file = file.replace('%TEST%', buffer).replace('%X%', str(NUMBER_OF_TESTS))

with open(sys.argv[1], 'w') as f:
    f.write(file)


