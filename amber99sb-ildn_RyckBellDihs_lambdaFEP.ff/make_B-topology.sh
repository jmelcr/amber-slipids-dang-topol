#!/bin/bash
# script scales charges-parameters for H-REM simulation in Gromacs
#  it adds B-topology for lambda-parametric simulation
#  and also scales explicitly defined dihedrals
# using pipes for that

#filename of the topology to be scaled
filename=$1
#This factor is gamma=beta_H/beta_L ; beta=1/kT
GAMMA=0.31  # for T_L=310 and T_H=1000K

awk -v gamma=$GAMMA '{
# if the line contains [*], put it into the variable brac
if ($0 ~ /\[.*\]/) brac = $0

# if the brac has word atomtypes inside and the line read doesnt contain the [*] header itself and doesnt contain comments (start with ;) and doesnt contain [_tab_] string (?) and does not start with # and if not blank (zero length)
if (brac ~ /\[ *atoms *\]/   &&   $0 !~ /\[ *atoms *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
# Prints out both A and B topologies
 printf "%5d%11s%5d%5s%5s%6d%12.6f %9.4f    %13s%12.6f %8.4f %1s%5s%6s\n", $1,$2,$3,$4,$5,$6,$7,$8,"Q_"$2, sqrt(gamma)*$7,$8   ,$9,$10,$11 ;
else
 print $0

}' $filename | \
\
awk -v gamma=$GAMMA '{
# if the line contains [*], put it into the variable brac
if ($0 ~ /\[.*\]/) brac = $0

# if the 6th column is not empty, the brac has word atomtypes inside and the line read doesnt contain the [*] header itself and doesnt contain comments (start with ;) and doesnt contain [_tab_] string (?) and does not start with # and if not blank (zero length)
if ( length($6)!=0  &&  brac ~ /\[ *dihedrals *\]/   &&   $0 !~ /\[ *dihedrals *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
# Prints out both A and B topologies
 printf "%5d%5d%5d%5d%5d%33s%33s\n", $1,$2,$3,$4,$5,$6,"Q_"$6 ;
else
 print $0

}' > ${filename}_Bstate
