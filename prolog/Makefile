CMDS=newbisim.inp

.SUFFIXES: .pl .inp

snipplets: $(CMDS)

clean:
	rm -f *.out *.inp *.cmd *~

.pl.inp:
	../mksnipplets.sh $< .
