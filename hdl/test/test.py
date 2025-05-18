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
    i = argv.find('--test')
    if i + 1 <=argc:
        test_name = argv[i + 1]
else:
    print("--test not found")
    return -1

if '--in' in argv:
    i = argv.find('--in')
    files = argv[i:]
    if len(files) < 1:
        print(f"Incorrect number of input files: {files}")
        return -2
else:
    print("--in not found")
    return -3


if '-e' in argv:
    elaborate(files)

if '-r' in argv:
    run_test(test_name)
