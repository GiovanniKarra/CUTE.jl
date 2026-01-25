#!/bin/env sh

for file in AMPL/*.mod; do
	name=$(basename "$file")
	name=${name%.*}
	SCRIPT="option presolve 0; option solver 'x'; model $file; write g$name;"
	echo "$SCRIPT" | /opt/ampl/ampl
done

mkdir -p NL
mv -f *.nl NL
