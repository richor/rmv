for host in  n72x24 n61x24 n79x24 n71x12 n66x8 n67x8 ;
do
ssh -l songys $host "top -b -n 1" |awk -v host=$host 'NR==8{print host, $2,$9,$12}'
done
ssh -l songyongshun n64x24 "top -b -n 1" |awk 'NR==8{print "n64x24",$2,$9,$12}'

