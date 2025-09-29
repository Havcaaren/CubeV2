from random import randrange
import sys

#######################################################################


IO_SIZE : int = 32

NUMBER_OF_TESTS : int = 10

INPUTS_SIGNALS  : list = ['val_a_i', 'val_b_i']
OUTPUTS_SIGNALS : list = ['val_c_i']

SEQUENCE : list = ['setRandomAll', 'checkModelSingle']

#######################################################################




class Model:
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
        return self.c


m = Model()

def get_rand() -> str:
    return randrange(0, 2**32, 1)


def get_hex(input : int) -> str:
    val : str = hex(input)[2:]
    return 'x"' + '0'*((IO_SIZE//4)-len(val)) + val + '"'


def get_model(inputs : list) -> list:
    m.put(inputs)
    m.execute()
    return [get_hex(m.get())]


def setRandomAll() -> str:
    buffer : str = ''
    inputs : list = [get_rand() for _ in INPUTS_SIGNALS]
    for s in zip(INPUTS_SIGNALS, inputs):
        buffer += '\t' + s[0] + ' <= ' + get_hex(s[1]) + ';\n'
    return (buffer, inputs)


def checkModelSingle(inputs : list):
    buffer = ''
    outputs : list = get_model(inputs)
    for s in zip(OUTPUTS_SIGNALS, outputs):
        buffer += '\tIF ' + s[0] + ' = ' + s[1]  + ' THEN\n'
        buffer += '\t\tcc := cc + 1;\n'
        buffer += '\tEND IF;\n'
    return buffer

buffer : str = ''
inputs : list = []
for i in range(NUMBER_OF_TESTS):
    buffer += '\t-- Test' + str(i) + ':\n'

    for s in SEQUENCE:
        match s:
            case x if "setRandomAll" in x:
                b, i = setRandomAll()
                buffer += b
                inputs.append(i)
                print(inputs)
            case x if "checkModelSingle" in x:
                b = checkModelSingle(inputs[-1])
                buffer += b

    buffer += '\n'
print(buffer)
#
#
# with open(sys.argv[1], 'r') as f:
#     file = f.read()
#
# file = file.replace('%TEST%', buffer)
#
# with open(sys.argv[1], 'w') as f:
#     f.write(file)