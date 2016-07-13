EXAMPLES= 
CMDS= 
OUTPUTS=newbisim.inp 
PROLOG=/usr/bin/swipl

.SUFFIXES: .out .pl .inp

snipplets: $(CMDS) $(OUTPUTS)

clean:
	rm -f *.out *.inp *.cmd *~

.pl.inp:
	../mksnipplets.sh $< .

.pl.out:
	$(PROLOG) -s $< 2>/dev/null | sed '1,/!out!/d' >$*.out

