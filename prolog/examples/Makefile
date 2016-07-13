PROLOG=/usr/bin/swipl
AWK=/usr/bin/gawk
AWKPROG=../../splitlines.awk
AWKARGS=-v SPLITCHARS="+/ \\\\;" -v LMAX=80 -v LMIN=50 -f 
SOURCES=ex1.pl ex2.pl ex3.pl ex4.pl ex5.pl ex6.pl ex7.pl ex8.pl ex9.pl ex10.pl \
     ex11.pl ex12.pl ex13.pl ex14.pl ex15.pl ex16.pl ex17.pl ex18.pl ex19.pl ex20.pl \
     ex21.pl
CMDS=ex1.cmd ex2.cmd ex3.cmd ex4.cmd ex5.cmd ex6.cmd ex7.cmd ex8.cmd ex9.cmd ex10.cmd \
     ex11.cmd ex12.cmd ex13.cmd ex14.cmd ex15.cmd ex16.cmd ex17.cmd ex18.cmd ex19.cmd ex20.cmd \
     ex21.cmd
OUTPUTS=ex1.out ex2.out ex3.out ex4.out ex5.out ex6.out ex7.out ex8.out ex9.out ex10.out \
     ex11.out ex12.out ex13.out ex14.out ex15.out ex16.out ex17.out ex18.out ex19.out ex20.out \
     ex21.out

.SUFFIXES: .out .pl .cmd

snipplets: $(CMDS) $(OUTPUTS)

clean:
	rm -f *.out *.inp *.cmd *~

.pl.cmd:
	../../mksnipplets.sh $< .

.pl.out:
	$(PROLOG) -s $< 2>/dev/null | sed '1,/!out!/d' | $(AWK) $(AWKARGS) $(AWKPROG) >$*.out

