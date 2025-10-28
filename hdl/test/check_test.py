import sys

with open(sys.argv[1], 'r') as f:
    ls : str = f.read();    
    
    blocks : list = []
    block  : list = []

    for l in ls.splitlines():
        if "==============================" in l:
            if block:
                blocks.append(block)
                block = []
        else:
            block.append(l.strip())

    if block:
        blocks.append(block)

    ok    : int  = 0
    nok   : int  = 0
    nok_b : list = []
    for b in blocks:
        for bb in b:    
            if bb.find("PASS") != -1:
                ok += 1
            if bb.find("FAIL") != -1:
                nok += 1
                nok_b.append(b)

    print(f"OK:  {ok}")
    print(f"NOK: {nok}")
    
    if nok != 0:
        for i in nok_b:
            print('\n'.join(i))
            print('======================================================')
    
    print(f"\n{'PASSES' if nok == 0 else 'FALIED'}")
