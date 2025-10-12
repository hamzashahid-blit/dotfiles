#!/bin/env bash

# [ -z $1 ] && echo "u  stupid"

base_url="https://papers.xtremepape.rs/CAIE/AS%20and%20A%20Level/Mathematics%20(9709)"
code=9709
paper=5
variant=2

[ -e $1 ] || mkdir $1
dir=$1
cd $dir

# Download pastpapers
wget ${base_url}/${code}_{s,w}{20..22}_{qp,ms}_${paper}${variant}.pdf

# To list pastpapers in order...
pps=($(for year in {20..22}
       do
	       for session in s w
	       do
		       for pptype in qp ms
		       do
			       echo -n "${code}_${session}${year}_${pptype}_${paper}${variant}.pdf "
		       done
	       done
       done))

# To concat pdf files
pdftk ${pps[@]} cat output myoutput.pdf

echo "-------------------------------------"
echo "Past Papers Done! Output in -> ${dir}"
echo "-------------------------------------"
