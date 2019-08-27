# obtain energy from scan log files
# if failed to finish, last line will have only energy.

input_log='dha.log'
output_txt='dha1.txt'
scan1='B20'
scan2='A19'
scan3='D18'

echo "aa" > temp
grep "SCF Done" $input_log >> temp
grep "Step number" $input_log > temp1
echo "Step number   1" >> temp1
paste temp temp1 |grep "Step number   1" |awk '{if(NR>1) print $5}' > temp2
grep "!       $scan1" $input_log  > temp
grep "!       $scan2" $input_log > temp1
grep "!       $scan3" $input_log  > temp1a
paste temp temp1 temp1a| awk '{if(NR>1) print $3,$10,$17}' > temp3
paste temp3 temp2 > $output_txt
