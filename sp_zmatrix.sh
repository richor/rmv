#used to obtain the gjf file of 3d potential scan.
#need a gjf file as input
#several data needs provide: 1. the specified bond, angle and dihedral. Actually, only need to provide which line of the gjf file. 2. the range of these parameters, and step size.


# initial parameters
gjf_file='dha1.gjf'
out_gjf='dha2.gjf'
n=27
bond_a=3.1
bond_b=4.6
bond_step=0.3
angle_a=49
angle_b=149
angle_step=20
dihedral_a=120
dihedral_b=180
dihedral_step=20

# below, please don't change

n_b=$(echo "($bond_b-($bond_a))/$bond_step+1" | bc)
n_a=$(echo "($angle_b-($angle_a))/$angle_step+1" | bc)
n_d=$(echo "($dihedral_b-($dihedral_a))/$dihedral_step+1" | bc)

bond=`awk -v n=$n '{if(NR==n) print $3}' $gjf_file | cut -b 2- ` 
angle=`awk -v n=$n '{if(NR==n) print $5}' $gjf_file | cut -b 2- ` 
dihedral=`awk -v n=$n '{if(NR==n) print $7}' $gjf_file | cut -b 2- ` 

awk -v n=$n '{if(NR<n) print }' $gjf_file >$out_gjf 
for((i=$bond;i<$(($bond+$n_b));i++))
do
for((j=$angle;j<$(($angle+$n_a));j++))
do
for((k=$dihedral;k<$(($dihedral+$n_d));k++))
do
awk -v i=$i -v j=$j -v k=$k -v n=$n '{if(NR==n) {printf("%s  %s  B%d  %s  A%d  %s  D%d  \n",$1,$2,i,$4,j,$6,k) }}' $gjf_file >>$out_gjf 
done
done
done
awk -v n=$n '{if(NR>n) print }' $gjf_file >>$out_gjf 

sed -i '$d' $out_gjf

for((i=$bond;i<$(($bond+$n_b));i++))
do
echo "B$i  $bond_a" >> $out_gjf
bond_a=$( echo "$bond_a+$bond_step" |bc)
done
for((j=$angle;j<$(($angle+$n_a));j++))
do
echo "A$j  $angle_a"  >> $out_gjf
angle_a=$( echo "$angle_a+$angle_step" |bc)
done
for((k=$dihedral;k<$(($dihedral+$n_d));k++))
do
echo "D$k  $dihedral_a" >> $out_gjf
dihedral_a=$( echo "$dihedral_a+$dihedral_step" |bc)
done

echo -e "" >> $out_gjf
