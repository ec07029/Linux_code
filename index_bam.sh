#BSUB-J index_bam               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 3
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.index_bam
#BSUB-eo stderr.index_bam

#samtools index ADA_1_nanopore_passed.bam
#samtools index ADA_2_nanopore_passed.bam
#samtools index ADA_3_nanopore_passed_cb.bam

#samtools index WT_1_nanopore_passed.bam
#samtools index WT_2_nanopore_passed.bam
#samtools index WT_3_nanopore_passed_cb.bam

samtools index ADA_1_nanopore_passed_subset_sig_sites.dedupped.bam
samtools index ADA_2_nanopore_passed_subset_sig_sites.dedupped.bam
