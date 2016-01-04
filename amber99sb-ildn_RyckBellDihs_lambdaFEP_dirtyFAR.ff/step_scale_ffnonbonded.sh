#!/bin/bash

#T_high = 1000K
BETA=0.31


awk -v beta=$BETA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *atomtypes *\]/ && $0 !~ /\[ *atomtypes *\]/ && $0 !~ /^ *;/ && $0 !~ /^[ \t] *$/ && $0 !~ /^#/   &&   length($0) != 0 ) 
 printf "%13s%5d%11.4f%10.4f%3s%14.5e%14.5e\n%13s%5d%11.4f%10.4f%3s%14.5e%14.5e\n",\
     $1, $2,$3,$4,$5,$6,$7,\
 "Q_"$1, $2,$3,$4,$5,$6,beta*$7
else
 print $0

}' ffnonbonded.itp > ffnonbonded_scaled.itp
