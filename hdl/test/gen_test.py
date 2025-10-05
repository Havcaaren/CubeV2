from random import randrange
import sys
import threading

#######################################################################


IO_SIZE : int = 32
MAX_NUB : int = 8

NUMBER_OF_TESTS : int = 100000

INPUTS_SIGNALS  : list = ['val_a_i', 'val_b_i']
OUTPUTS_SIGNALS : list = ['val_c_i']

SEQUENCE : list = ['setRandomAll', 'waitClock' , 'checkModelSingle']

CLOCK : int = 9

#######################################################################


res : list = ['' for i in range(8)]

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
    return randrange(0, 2**MAX_NUB, 1)


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
        buffer += '\tELSE'
        buffer += '\t\tREPORT "VAL A:";'
        buffer += "\t\tREPORT integer'image(to_integer(unsigned(val_a_i)));\n"
        buffer += '\t\tREPORT "VAL B:";'
        buffer += "\t\tREPORT integer'image(to_integer(unsigned(val_b_i)));\n"
        buffer += '\t\tREPORT "VAL C:";'
        buffer += "\t\tREPORT integer'image(to_integer(unsigned(val_c_i)));\n"
        buffer += '\tEND IF;\n'
    return buffer


def gen_test(a : int, b : int, c : int):
    buffer : str = ''
    inputs : list = []
    for i in range(a, b):
        # print(f"{(i/NUMBER_OF_TESTS)*100:2.2}%")
        buffer += '\t-- Test' + str(i) + ':\n'

        for s in SEQUENCE:
            match s:
                case x if "setRandomAll" in x:
                    b, i = setRandomAll()
                    buffer += b
                    inputs.append(i)
                    # print(inputs)
                case x if "checkModelSingle" in x:
                    b = checkModelSingle(inputs[-1])
                    buffer += b
                case x if "waitClock" in x:
                    buffer += "\tWAIT FOR " + str(CLOCK) + " ns;\n"

        buffer += '\n'
    res[c] = buffer
# print(buffer)


it = NUMBER_OF_TESTS // 8
pos = 0
treads : list = []
for i in range(8):
    treads.append(threading.Thread(target=gen_test, args=(pos,pos + it, i, )))
    pos += it

a = [i.start() for i in treads]
b = [i.join() for i in treads]
# print(a)
# print(b)

buffer = '\n'.join(res)
# print(buffer)

with open(sys.argv[1], 'r') as f:
    file = f.read()

file = file.replace('%TEST%', buffer).replace('%X%', str(NUMBER_OF_TESTS))

with open(sys.argv[1], 'w') as f:
    f.write(file)
