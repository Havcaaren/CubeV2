import subprocess
import sys

ELABORATE_FUNC : list = ["ghdl", "-a"]
RUN_FUNC       : list = ["ghdl", "-e"]
RES_FUNC       : list = ["ghdl", "-r"]


def elaborate(files : list):
    elb_temp : list = ELABORATE_FUNC + files

    subprocess.run(elb_temp)
    return


def run_test(test_name : str) -> int:
    files_e : list = RUN_FUNC + [test_name]
    files_r : list = RES_FUNC + [test_name]

    subprocess.run(files_e)
    return subprocess.run(files_r, capture_output=True, text=True)


argv = sys.argv[1:]
argc = len(argv)

test_name : str  = None
files     : list = []


if '--test' in argv:
    i = argv.index('--test')
    if i + 1 <=argc:
        test_name = argv[i + 1]
else:
    print("--test not found")
    exit(-1)

if '--in' in argv:
    i = argv.index('--in')
    files = argv[(i + 1):]
    if len(files) < 1:
        print(f"Incorrect number of input files: {files}")
        exit(-2)
else:
    print("--in not found")
    exit(-3)

if '-e' in argv:
    elaborate(files)

if '-r' in argv:
    file : str = ""
    if '-q' in argv:
        file : str = '\n'.join([i for i in run_test(test_name).stdout.splitlines() if i.find('metavalue detected') == -1])
    else:
        print(run_test(test_name).stdout)
    if file != "":
        with open("out.txt", 'w') as f:
            f.write(file)

