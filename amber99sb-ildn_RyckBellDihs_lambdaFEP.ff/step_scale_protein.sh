#!/bin/bash

#filename of the topology to be scaled
filename=$1
#T_high = 1000K
BETA=0.31

awk -v beta=$BETA '{
if ($0 ~ /\[.*\]/) brac = $0
if ($0 ~ /^; residue/) resid = $3
if ((resid > 227 && resid < 241) && brac ~ /\[ *atoms *\]/ && $0 !~ /\[ *atoms *\]/ && $0 !~ /^ *;/ && $0 !~ /^ *$/ && $0 !~ /^#/) 
 printf "%6s%10s%6d%8s%8s%7d%12.6f%12.4f\n", $1,"Q_"$2,$3,$4,$5,$6,beta*$7,$8
else
 print $0

}' $filename > ${filename}_scaled
