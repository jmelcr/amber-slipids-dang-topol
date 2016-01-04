#!/bin/bash
# script scales FF parameters for H-REM simulation in Gromacs
# Bonded parameters, constrainttypes omitted, _sc--_sc interactions only
# using pipes for that

#This factor is gamma=beta_H/beta_L ; beta=1/kT
GAMMA=0.31  # for T_L=310 and T_H=1000K

awk -v gamma=$GAMMA '{
# if the line contains [*], put it into the variable brac
if ($0 ~ /\[.*\]/) brac = $0

# if the brac has word atomtypes inside and the line read doesnt contain the [*] header itself and doesnt contain comments (start with ;) and doesnt contain [_tab_] string (?) and does not start with # and if not blank (zero length)
if (brac ~ /\[ *bondtypes *\]/   &&   $0 !~ /\[ *bondtypes *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
# Prints out only crossterms for the scaled atom-types 
# printf "%11s%13s%4d%14.5e%13.5e\n %11s%13s%4d%14.5e%13.5e\n", $1,$2"_sc",$3,$4,sqrt(gamma)*$5 , $1"_sc",$2,$3,$4,sqrt(gamma)*$5
# no-scaling of parameters - not required
 printf "%11s%13s%4d%14.5e%13.5e\n %11s%13s%4d%14.5e%13.5e\n", $1,$2"_sc",$3,$4,$5 , $1"_sc",$2,$3,$4,$5
else
 print $0

}' ffbonded.itp | \
\
awk -v gamma=$GAMMA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *angletypes *\]/   &&   $0 !~ /\[ *angletypes *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
# printf "%11s%13s%13s%4d%14.5e%13.5e\n %11s%13s%13s%4d%14.5e%13.5e\n %11s%13s%13s%4d%14.5e%13.5e\n %11s%13s%13s%4d%14.5e%13.5e\n %11s%13s%13s%4d%14.5e%13.5e\n %11s%13s%13s%4d%14.5e%13.5e\n" , $1"_sc",$2"_sc",$3,$4,$5,sqrt(gamma)*$6 , $1,$2"_sc",$3"_sc",$4,$5,sqrt(gamma)*$6 , $1"_sc",$2,$3"_sc",$4,$5,sqrt(gamma)*$6 , $1"_sc",$2,$3,$4,$5,sqrt(gamma)*$6 , $1,$2"_sc",$3,$4,$5,sqrt(gamma)*$6 , $1,$2,$3"_sc",$4,$5,sqrt(gamma)*$6
# no-scaling of parameters - not required
 printf "%11s%13s%13s%4d%7.1f%13.5e\n %11s%13s%13s%4d%7.1f%13.5e\n %11s%13s%13s%4d%7.1f%13.5e\n %11s%13s%13s%4d%7.1f%13.5e\n %11s%13s%13s%4d%7.1f%13.5e\n %11s%13s%13s%4d%7.1f%13.5e\n" , $1"_sc",$2"_sc",$3,$4,$5,$6 , $1,$2"_sc",$3"_sc",$4,$5,$6 , $1"_sc",$2,$3"_sc",$4,$5,$6 , $1"_sc",$2,$3,$4,$5,$6 , $1,$2"_sc",$3,$4,$5,$6 , $1,$2,$3"_sc",$4,$5,$6
else
 print $0

}' | \
\
awk -v gamma=$GAMMA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *dihedraltypes *\]/   &&   $0 !~ /\[ *dihedraltypes *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
 # All 14 crossterm combinations of dihedrals
 printf "  %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n %11s%13s%13s%13s%4d%7.1f%13.5e%3d\n" , $1,$2"_sc",$3"_sc",$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2,$3"_sc",$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2"_sc",$3,$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2"_sc",$3"_sc",$4,$5,$6,sqrt(gamma)*$7,$8 , $1,$2,$3"_sc",$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1,$2"_sc",$3,$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1,$2"_sc",$3"_sc",$4,$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2,$3,$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2,$3"_sc",$4,$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2"_sc",$3,$4,$5,$6,sqrt(gamma)*$7,$8 , $1,$2,$3,$4"_sc",$5,$6,sqrt(gamma)*$7,$8 , $1,$2,$3"_sc",$4,$5,$6,sqrt(gamma)*$7,$8 , $1,$2"_sc",$3,$4,$5,$6,sqrt(gamma)*$7,$8 , $1"_sc",$2,$3,$4,$5,$6,sqrt(gamma)*$7,$8
else
 print $0

}' | \
\
awk -v gamma=$GAMMA '{
# if the line contains #define xxxx , do the scaling...
# special dihedrals for crossterms -- must be explicitly stated in the topology!!
# the names of the dihedrals cant be too long
if ($0 ~ /.*#define tor*/)  
 printf "%7s%38s%7.1f%13.5e%3d\n", $1,$2"_cr",$3,sqrt(gamma)*$4,$5
else
 if ($0 ~ /.*#define improper*/)  
  printf "%7s%28s%7.1f%14.5e%3d\n", $1,$2"_cr",$3,sqrt(gamma)*$4,$5
 else
  print $0

}' | \
\
# delete lines with X_sc to prevent unnecessary duplicities (Might be missing, though)
# Term X LP2 LP2_sc X  req'd for the topology --- add by hand
sed  '/ X_sc /d' | sed '/ X /d' > ffbonded_scaled-crossterms.itp

