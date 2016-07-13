###############################################################################
##                                                                           ##
## Example output formatting AWK script for                                  ##
##                      M.sc. Thesis "Verification of CCS-processes"         ##
##                      1987 by Michael Hillerström                          ##
##                                                                           ##
## Annotated for automatic snipplet construction and inclusion into thesis.  ##
##                                                                           ##
###############################################################################
BEGIN {
	if (LMAX == "")  LMAX=80
	if (LMIN == "")  LMIN=60
	if (SPLITCHARS == "")  SPLITCHARS="+/ \\;"
}

{
	if (length($0) > 80)
		splitLine($0,LMAX,LMIN,SPLITCHARS,0);
	else
		print $0;
}


function splitLine(line,lmax,lmin,splitchars,indent,  parts,nparts,i,k,j,sum, splitit)
{
	splitit = 0;
#printf("splitline: LMAX=%d, LMIN=%d, SPLITCHARS='%s'\n", lmax, lmin, splitchars);
#printf("splitline called >%s< len=%d\n", substr(line,0,LMIN), length(line));
	if (length(line)+indent < lmax) {
		for (i=0; i<indent; i++)  printf(" ");
		printf("%s\n", line);
		return;
	}

	for (i=0; i<length(splitchars); i++) {
		nparts = split(line,parts,substr(splitchars,i,1))

#for (m in parts) printf("part '%s' >%s< >%s<\n", m, parts[m],substr(splitchars,i,1));
#printf("Found %d parts with splitchar '%s'\n", nparts, substr(splitchars,i,1));
		# How many parts are needed to rach at least lmin but not lmax?
		sum = 0; k=0;
		while (k<=nparts && sum<lmin) {
			k   += 1
			sum += length(parts[k]) + 1;
		}

#printf("    %d parts sum to %d\n", k, sum);
		if (sum <= lmax && sum >= lmin) {
#printf("SPLIT FOUND AT %d\n", sum);
			# Let's print the bits including split char(s)...
#printf(">>>>>");
			for (j=1; j<=k; j++)
				printf("%s%s", parts[j],substr(splitchars,i,1));
			printf "\n";

			# Figure out how much to indent the next part(s)...
			if (indent == 0) {
				for (j=0; j<=length(parts[1]) && substr(parts[1],j,1)==" "; j++)
					printf(" ");
				indent = j+1;
			}
#printf("Indent will be %d spaces\n", indent);

			# Assemble rest of line and give it a go (first with the active split char...)
			line = "";
			for (j=k+1; j<=nparts; j++)
				line = line parts[j] (j<nparts ? substr(splitchars,i,1) : "");

			splitit = 1;
#printf("calling splitline recursively :-)\n");
#printf("rest >%s<\n", line);
			# Go split the remainder
			splitLine(line,lmax,lmin,substr(splitchars,i,1) splitchars,indent);
			break;
		}
	}
	if (splitit == 0) {
		printf("Not possible to split line %d of '%4'. Try to alter parameters...\n", FNR,  FILENAME ) >/dev/stderr;
		exit(99)
	}
	return;
}
