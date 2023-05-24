#BSUB-J filter_sam2tsv               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.filter_sam2tsv
#BSUB-eo stderr.filter_sam2tsv

rm stderr.filter_sam2tsv
rm stdout.filter_sam2tsv

# Filter sam2tsv for significant edit sites
awk 'FNR==NR{a[$1,$3];next} (($4,$8) in a)'  Nanopore_at_edit_site_p.adj_lessthan_0.1_and_diff.freq_greaterthan_0.1.bed ADA_2_nanopore_passed_sam2tsv.txt | awk '$6=="G" || $6=="C" {print}' > ADA_2_nanopore_passed_sam2tsv_sig_edit_sites_p.adj_lessthan_0.1_and_diff.freq_greaterthan_0.1.txt