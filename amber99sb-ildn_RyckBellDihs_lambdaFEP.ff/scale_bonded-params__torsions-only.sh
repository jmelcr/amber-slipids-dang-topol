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
# Prints out the scaled atom-types only (and no combinations)
 printf "%11s%13s%4d%14.5e%13.5e\n", $1"_sc",$2"_sc",$3,$4,$5
else
 print $0

}' ffbonded.itp | \
\
awk -v gamma=$GAMMA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *angletypes *\]/   &&   $0 !~ /\[ *angletypes *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
 printf "%11s%13s%13s%4d%7.1f%13.5e\n", $1"_sc",$2"_sc",$3"_sc",$4,$5,$6
else
 print $0

}' | \
\
awk -v gamma=$GAMMA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *dihedraltypes *\]/   &&   $0 !~ /\[ *dihedraltypes *\]/   &&   $0 !~ /^ *;/   &&   $0 !~ /^[ \t] *$/   &&   $0 !~ /^#/   &&   length($0) != 0 ) 
 printf "%11s%13s%13s%13s%4d%7.1f%13.5e%3d\n%11s%13s%13s%13s%4d%7.1f%13.5e%3d\n", $1,$2,$3,$4,$5,$6,$7,$8, $1"_sc",$2"_sc",$3"_sc",$4"_sc",$5,$6,gamma*$7,$8
else
 print $0

}' | \
\
awk -v gamma=$GAMMA '{
# if the line contains #define xxxx , do the scaling...
if ($0 ~ /.*#define tor*/)  
 printf " %7s%38s%7.1f%13.5e%3d\n %7s%38s%7.1f%13.5e%3d\n", $1,$2,$3,$4,$5, $1,$2"_sc",$3,gamma*$4,$5
else
 if ($0 ~ /.*#define improper*/)  
  printf "%7s%28s%7.1f%14.5e%3d\n", $1,$2"_sc",$3,gamma*$4,$5
 else
  print $0

}' > ffbonded_scaled.itp

sed -i 's/ X_sc /   X  /g' ffbonded_scaled.itp

