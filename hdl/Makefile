reg_map:
	python3 test/test.py -e -r --test tb_reg_map --in test/tb/tb_reg_map.vhd reg_map.vhd

alu:
	python3 test/test.py -q -e -r --test tb_alu --in test/tb/tb_alu.vhd alu.vhd

gen_alu:
	python3 test/gen_test.py test/tb/tb_alu.vhd

clean:
	rm -v test/tb/*
	cp -v test/tb_org/* test/tb/.
	rm -v *.cf 
	# *.o tb_reg_map tb_alu
