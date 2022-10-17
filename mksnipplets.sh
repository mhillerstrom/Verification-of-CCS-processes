#!/bin/bash

if [[ -z $1 || -z $2 ]]; then
    echo "$(basename $0) <source> <output directory>"
    exit 1
fi
# Parameters
SOURCE=$1
OUTDIR=$2

if [[ ! -d "$OUTDIR" ]]; then
   echo "error: \"$OUTDIR\" no such directory found." > /dev/stderr
   exit 1
fi

# Markers enclosing code snippets
BEGIN_MARKER="/*#snipplet: "		# /*#snipplet: <filename>
BEGIN_MARKER_SED="\/\*#snipplet: "	# sed friendly version
BEGIN_MARKER_LEN=13			# Length of '/*#snipplet: '
END_MARKER="/*#end"			# /*#end
END_MARKER_SED="\/\*#end"		# sed friendly version
END_MARKER_LEN=6			# Lenght of '/*#end'
FILTER_MARKER="/*#filter:"		# /*#filter: <sed expr>
FILTER_MARKER_SED="\/\*#filter:"	# sed friendly version
FILTER_MARKER_LEN=10			# Length of '/*#filter:'

# Keep whitespace when reading
IFS=''

# In the beginning there was emptiness
FILE=
OLDFILE=
FILTER=

cat "$SOURCE" |
sed -n "/^$BEGIN_MARKER_SED/,/^$END_MARKER_SED *\$/p" |
while read -r line; do
    if [[ ${line:0:$FILTER_MARKER_LEN} = "$FILTER_MARKER" ]]; then
	    FILTER=$(echo -E "$line" | sed "s?${FILTER_MARKER_SED}[ \t]*??" | \
                 sed 's@[ \t]*\*/.*$@@' \
                )
        continue
    fi

    if [[ ${line:0:$BEGIN_MARKER_LEN} = "$BEGIN_MARKER" ]]; then
	    FILE=$(echo -E "$line" | sed "s@${BEGIN_MARKER_SED}@@" | \
               sed 's@[ \t]*\*/.*$@@' \
               )
        if [[ $OLDFILE != $FILE ]]; then
            rm -f "$OUTDIR/$FILE" && touch -m "$OUTDIR/$FILE"
        fi
    elif [[ ${line:0:$END_MARKER_LEN} = "$END_MARKER" ]]; then
        OLDFILE=$FILE; unset FILE FILTER
    elif [[ ! -z "$FILE" ]]; then
        if [[ "x$FILTER" != "x" ]]; then
            echo -E "$line" | sed "$FILTER" >>"$OUTDIR/$FILE"
        else
            echo -E "$line" >> "$OUTDIR/$FILE"
        fi
    fi
done
