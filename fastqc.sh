#BSUB-J fastqc              # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 4
#BSUB-M 5
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.fastqc
#BSUB-eo stderr.fastqc

mkdir fastqc
ls -d Sample_*[0-9] | parallel "/data/leslie/chuk/bin/FastQC/fastqc {}/*R1_001.fastq.gz {}/*R2_001.fastq.gz -o fastqc/"
