#BSUB-J merge.R1.R2               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.merge.R1.R2
#BSUB-eo stderr.merge.R1.R2

ls -d Sample_*[0-9] | xargs -I {} sh -c "cat {}/*1_R1_001.fastq.gz {}/*2_R1_001.fastq.gz > {}/{}_merged_R1_001.fastq.gz"
ls -d Sample_*[0-9] | xargs -I {} sh -c "cat {}/*1_R2_001.fastq.gz {}/*2_R2_001.fastq.gz > {}/{}_merged_R2_001.fastq.gz"


