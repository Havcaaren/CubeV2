from random import randrange
import sys


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
    return 'x"' + '0'*(8-len(val)) + val + '"'


def get_model(inputs : list) -> list:
    m.put(inputs)
    m.execute()
    return [get_hex(m.get())]


size : int = 32

number_of_tests : int = 10

in_signals  : list = ['val_a_i', 'val_b_i']
out_signals : list = ['val_c_i']

buffer : str = ''

for i in range(number_of_tests):
    buffer += '\t-- Test' + str(i) + ':\n'

    inputs : list = [get_rand() for _ in in_signals]
    for s in zip(in_signals, inputs):
        buffer += '\t' + s[0] + ' <= ' + get_hex(s[1]) + ';\n'

    outputs : list = get_model(inputs)
    for s in zip(out_signals, outputs):
        buffer += '\tIF ' + s[0] + ' = ' + s[1]  + ' THEN\n'
        buffer += '\t\tcc := cc + 1;\n'
        buffer += '\tEND IF;\n'

    buffer += '\n'


with open(sys.argv[1], 'r') as f:
    file = f.read()

file = file.replace('%TEST%', buffer)

with open(sys.argv[1], 'w') as f:
    f.write(file)