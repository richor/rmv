# obtain energy from log files

input_log='dha.log'
output_txt='dha1.txt'

echo "aa" > temp
grep "SCF Done" $input_log >> temp
grep "Step number" $input_log > temp1
echo "Step number   1" >> temp1
paste temp temp1 |grep "Step number   1" |awk '{if(NR>1) print $5}' > temp2
grep "!       B20" $input_log  > temp
grep "!       A19" $input_log > temp1
grep "!       D18" $input_log  > temp1a
paste temp temp1 temp1a| awk '{if(NR>1) print $3,$10,$17}' > temp3
paste temp3 temp2 | sort > $output_txt
