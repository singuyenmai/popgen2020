#!/bin/bash
theta=0.04

echo -e datasets"\t"Nm"\t"scheme"\t"pi > sample_stats.output
echo -e datasets"\t"Nm"\t"scheme"\t"pi_mean"\t"pi_95ci_low"\t"pi_95ci_high > stats.output

for d in 100 10000; do
	
	for migr in 0.4 40 400; do
		
		# scheme 1
		ms 40 "$d" -t $theta -I 4 40 0 0 0 "$migr" | sample_stats | cut -f 2 > scheme_1;
		awk -v da="$d" -v mi="$migr" '{FS="\t"; OFS="\t"} {print da, mi/4, 1, $1}' scheme_1 >> sample_stats.output;

		cat scheme_1 | stats .025 .975 | cut -f 1,7,9 | \
		awk -v da="$d" -v mi="$migr" '{FS="\t"; OFS="\t"} {print da, mi/4, 1, $1, $2, $3}' >> stats.output;

		# scheme 2
		ms 40 "$d" -t $theta -I 4 10 10 10 10 "$migr" | sample_stats | cut -f 2 > scheme_2;
		awk -v da="$d" -v mi="$migr" '{FS="\t"; OFS="\t"} {print da, mi/4, 2, $1}' scheme_2 >> sample_stats.output;

		cat scheme_2 | stats .025 .975 | cut -f 1,7,9 | \
		awk -v da="$d" -v mi="$migr" '{FS="\t"; OFS="\t"} {print da, mi/4, 2, $1, $2, $3}' >> stats.output;

	done;

done
