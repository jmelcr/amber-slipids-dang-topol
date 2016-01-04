#!/bin/bash

#T_high = 1000K
BETA=0.31



#cd amber03.ff/

awk -v beta=$BETA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *bondtypes *\]/ && $0 !~ /\[ *bondtypes *\]/ && $0 !~ /^ *;/ && $0 !~ /^ *$/) { 
 if ($1 == $2)
    printf "%8s%8s%6d%11.5f%11.1f\n%8s%8s%6d%11.5f%11.1f\n",\
        $1,     $2, $3,$4,$5,\
    "Q_"$1, "Q_"$2, $3,$4,beta*$5
 else {
    printf "%8s%8s%6d%11.5f%11.1f\n%8s%8s%6d%11.5f%11.1f\n%8s%8s%6d%11.5f%11.1f\n%8s%8s%6d%11.5f%11.1f\n",\
        $1,     $2, $3,$4,$5,\
    "Q_"$1,     $2, $3,$4,sqrt(beta)*$5,\
	$1, "Q_"$2, $3,$4,sqrt(beta)*$5,\
    "Q_"$1, "Q_"$2, $3,$4,beta*$5
 }
}
else
 print $0

}' ffbonded.itp > ffbonded_temp.itp

awk -v beta=$BETA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *angletypes *\]/ && $0 !~ /\[ *angletypes *\]/ && $0 !~ /^ *;/ && $0 !~ /^ *$/) { 
  if ($1 == $3)
    printf "%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n",\
        $1,     $2,     $3, $4,$5,$6,\
    "Q_"$1,     $2,     $3, $4,$5,sqrt(beta)*$6,\
        $1, "Q_"$2,     $3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1, "Q_"$2,     $3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1,     $2, "Q_"$3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1, "Q_"$2, "Q_"$3, $4,$5,beta*$6
 else {
    printf "%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n%8s%8s%8s%6d%10.3f%10.3f\n",\
        $1,     $2,     $3, $4,$5,$6,\
    "Q_"$1,     $2,     $3, $4,$5,sqrt(beta)*$6,\
        $1, "Q_"$2,     $3, $4,$5,sqrt(beta)*$6,\
        $1,     $2, "Q_"$3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1, "Q_"$2,     $3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1,     $2, "Q_"$3, $4,$5,sqrt(beta)*$6,\
        $1, "Q_"$2, "Q_"$3, $4,$5,sqrt(beta)*$6,\
    "Q_"$1, "Q_"$2, "Q_"$3, $4,$5,beta*$6
 }
}
else
 print $0

}' ffbonded_temp.itp > ffbonded_temp2.itp

awk -v beta=$BETA '{
if ($0 ~ /\[.*\]/) brac = $0

if (brac ~ /\[ *dihedraltypes *\]/ && $0 !~ /\[ *dihedraltypes *\]/ && $0 !~ /^ *;/ && $0 !~ /^ *$/ &&   $0 !~ /^#/   &&   length($0) != 0 ) { 
    printf "%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n%8s%8s%8s%8s%6d%10.2f%10.5f%6d\n",\
        $1,     $2,     $3,     $4, $5,$6,$7,$8,\
    "Q_"$1,     $2,     $3,     $4, $5,$6,$7,$8,\
        $1,     $2,     $3, "Q_"$4, $5,$6,$7,$8,\
    "Q_"$1,     $2,     $3, "Q_"$4, $5,$6,$7,$8,\
        $1, "Q_"$2,     $3,     $4, $5,$6,sqrt(beta)*$7,$8,\
    "Q_"$1, "Q_"$2,     $3,     $4, $5,$6,sqrt(beta)*$7,$8,\
        $1, "Q_"$2,     $3, "Q_"$4, $5,$6,sqrt(beta)*$7,$8,\
    "Q_"$1, "Q_"$2,     $3, "Q_"$4, $5,$6,sqrt(beta)*$7,$8,\
        $1,     $2, "Q_"$3,     $4, $5,$6,sqrt(beta)*$7,$8,\
    "Q_"$1,     $2, "Q_"$3,     $4, $5,$6,sqrt(beta)*$7,$8,\
        $1,     $2, "Q_"$3, "Q_"$4, $5,$6,sqrt(beta)*$7,$8,\
    "Q_"$1,     $2, "Q_"$3, "Q_"$4, $5,$6,sqrt(beta)*$7,$8,\
        $1, "Q_"$2, "Q_"$3,     $4, $5,$6,beta*$7,$8,\
    "Q_"$1, "Q_"$2, "Q_"$3,     $4, $5,$6,beta*$7,$8,\
        $1, "Q_"$2, "Q_"$3, "Q_"$4, $5,$6,beta*$7,$8,\
    "Q_"$1, "Q_"$2, "Q_"$3, "Q_"$4, $5,$6,beta*$7,$8
# form suitable for type 4 dihedral

}
else
 print $0

}' ffbonded_temp2.itp | \
\
awk -v beta=$BETA '{
# if the line contains #define xxxx , do the scaling...
if ($0 ~ /.*#define tor*/)  
 printf " %7s%38s%7.1f%13.5e%3d\n %7s%38s%7.1f%13.5e%3d\n", $1,$2,$3,$4,$5, $1,"Q_"$2,$3,beta*$4,$5
else
 if ($0 ~ /.*#define improper*/)  
  printf "%7s%28s%7.1f%14.5e%3d\n", $1,$2"_sc",$3,gamma*$4,$5
 else
  print $0

}' > ffbonded_temp3.itp

sed "s/Q_X/  X/g" ffbonded_temp3.itp | awk '!x[$0]++' > ffbonded_scaled.itp_only_dih-type4

rm ffbonded_temp*.itp
