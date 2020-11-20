echo -e ID"\t"%Miss"\t"inferred_cluster_1"\t"inferred_cluster_2"\t"replication > summary_clustering.tsv
r=1
for f in rep_*; do
	if [ $r == 1 ] || [ $r == 8 ] || [ $r == 9 ] || [ $r == 10 ]; then
		awk -v rep=$r '{OFS="\t"} NR>1 {print $2,$3,$6,$5,rep}' $f >> summary_clustering.tsv;
	else
		awk -v rep=$r '{OFS="\t"} NR>1 {print $2,$3,$5,$6,rep}' $f >> summary_clustering.tsv;
	fi;
	r=$(bc -l <<< $r+1);

done

echo -e ID"\t"ref_pop > str_sample_reference
awk '{OFS="\t"} NR>1 {print $1,$2}' soc_np_usats.str >> str_sample_reference