#BSUB-J annotate_with_dbsnp       # name of the job
#BSUB-W 99:00                   	# Time limit 
#BSUB-n 1
#BSUB-R "span[ptile=9]"
#BSUB-M 20

#BSUB-o stdout.annotate_with_dbsnp
#BSUB-eo stderr.annotate_with_dbsnp

# Remove VCF header to process things easier downstream
#sed -n '/#CHROM/,$p' dbsnp_151_mouse.sorted.vcf > dbsnp_151_mouse.sorted_no_header.vcf
# sed -n '/#CHROM/,$p' ADA_1_illumina_minimap.FinalR.vcf > ADA_1_illumina_minimap_no_header.FinalR.vcf
# sed -n '/#CHROM/,$p' ADA_2_illumina_minimap.FinalR.vcf > ADA_2_illumina_minimap_no_header.FinalR.vcf
# sed -n '/#CHROM/,$p' ADA_3_illumina_minimap.FinalR.vcf > ADA_3_illumina_minimap_no_header.FinalR.vcf
# sed -n '/#CHROM/,$p' WT_1_illumina_minimap.FinalR.vcf > WT_1_illumina_minimap_no_header.FinalR.vcf
# sed -n '/#CHROM/,$p' WT_2_illumina_minimap.FinalR.vcf > WT_2_illumina_minimap_no_header.FinalR.vcf
# sed -n '/#CHROM/,$p' WT_3_illumina_minimap.FinalR.vcf > WT_3_illumina_minimap_no_header.FinalR.vcf


# annotate SNPs that occur in dbsnp as "dbsnp"
awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf ADA_1_illumina_minimap_no_header.FinalR.vcf > ADA_1_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf
awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf ADA_2_illumina_minimap_no_header.FinalR.vcf > ADA_2_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf
awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf ADA_3_illumina_minimap_no_header.FinalR.vcf > ADA_3_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf

awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf WT_1_illumina_minimap_no_header.FinalR.vcf > WT_1_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf
awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf WT_2_illumina_minimap_no_header.FinalR.vcf > WT_2_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf
awk 'BEGIN{OFS="\t"}{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]};print $0}}' dbsnp_151_mouse.sorted_no_header.vcf WT_3_illumina_minimap_no_header.FinalR.vcf > WT_3_illumina_minimap_no_header_dbsnp_annotated.FinalR.vcf


# awk 'FNR==NR{a[$1,$2];next} (($1,$2) in a)' | awk '$6=="G" || $6=="C" {print}' > ADA_2_illumina_minimap_sam2tsv_sig_edit_sites_p.adj_lessthan_0.1_and_diff.freq_greaterthan_0.1.txt

# dbsnp file can have multiples of the same genomic coordinate but different SNPs called at that coordinate.
# This code below obtains the last rs annotation that matches the position so it may not match the SNP associated with the rs ID.
# awk '{if(FNR==NR){a[$1,$2]=$3;next}else{if(($1,$2) in a) {$3=a[$1,$2]}print $0}}' test_input.vcf WT_1_illumina_minimap_no_header.FinalR.vcf > test_v2_output
