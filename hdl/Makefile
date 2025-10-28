test_alu: clean gen_alu alu check_test

test_reg_map: clean gen_reg_map reg_map check_test
	

reg_map:
	python3 test/test.py -q -e -r --test tb_reg_map --in test/tb/tb_reg_map.vhd reg_map.vhd

alu: 
	python3 test/test.py -q -e -r --test tb_alu --in test/tb/tb_alu.vhd alu.vhd

gen_alu:
	python3 test/gen_alu_test.py test/tb/tb_alu.vhd

gen_reg_map:
	python3 test/gen_reg_map.py test/tb/tb_reg_map.vhd

prime_tb:
	cp -v test/tb_org/* test/tb/.

check_test:
	python3 test/check_test.py out.txt

clean:
	rm -v test/tb/*
	cp -v test/tb_org/* test/tb/.
	rm -v out.txt *.cf 
	# *.o tb_reg_map tb_alu
