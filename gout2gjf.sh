#!/bin/bash
# First created by ChemiAndy, 2014.03.11
# upload to github and modified by Richor, 2019 
# Purpose：从高斯输出文件中提取坐标信息生成xyz文件和输入文件
# Usage： gout2gjf xxxx.log 后面为高斯输出文件名作为参数
# Can run both on MacOS and Linux
#
  
# get the prefix of the gaussian output file
NAME=`echo $1|sed "s/\..*$//"`
  
# Find CHARGE and MULTIPlicity, get the first value in case more than one result found
CHARGE=`awk '/Charge =/{print $3}' $1 | awk 'NR==1'`
MULTIP=`awk '/Charge =/{print $6}' $1 | awk 'NR==1'`
  
# Find how many atoms by reading the first string of the last line
NATOM=`grep "NAtoms=" $1 | tail -1 | awk '{print $2}' `
  
echo "$NATOM in inputfile $1 "
echo "Charge:   $CHARGE"
echo "Multiplicity:     $MULTIP"
  
# Find the block of the coordination, delete extra lines, and
# Change the element index into their NAMEs, to be improved
sed '/Standard orientation:/,/Rotational constants/!d' $1 | grep -v -E 'I|C|N|D|R|\-\-\-' | tail -$NATOM | awk '{gsub(17,"Cl",$2); gsub(16,"S",$2); gsub("1","H",$2); gsub(6,"C",$2); gsub(7,"N",$2); gsub(8,"O",$2); gsub(30,"Zn",$2);  printf "%5s %10.6f %10.6f %10.6f\n", $2, $4, $5, $6}' > $NAME.tmp

# Create xyz file
echo -e "${NATOM}\n${NAME}" > $NAME.xyz 
cat $NAME.tmp >>$NAME.xyz
echo "$NAME.xyz created."

echo -e "#opt b3lyp/6-31+g(d,p)\n\n${NAME}\n\n${CHARGE} ${MULTIP}" >$NAME.gjf
echo "add freeze tag? [Y/N]"
read ans
if [ $ans = "Y" ]; then
awk '{printf("%5s -1 %10.6f %10.6f %10.6f\n", $1,$2,$3,$4)}' $NAME.tmp >> $NAME.gjf
else
cat $NAME.tmp >> $NAME.gjf
fi
echo -e "\n" >> $NAME.gjf
echo "$NAME.gjf created."
  
# Clean tmp file
rm $NAME.tmp
echo "End!"
