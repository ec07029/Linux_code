#BSUB-J cutadapt               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 3
#BSUB-M 40
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.cutadapt
#BSUB-eo stderr.cutadapt

# To trim a 3’ adapter, the basic command-line for Cutadapt is:
# cutadapt -a AACCGGTT -o output.fastq input.fastq

ls -d Sample_*[0-9] | xargs -I {} sh -c "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o {}/{}_R1_001.fastq_cutadapt.gz {}/*_R1_001.fastq.gz"
ls -d Sample_*[0-9] | xargs -I {} sh -c "cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o {}/{}_R2_001.fastq_cutadapt.gz {}/*_R2_001.fastq.gz"


# cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o Sample_input-4OHT-1_IGO_09569_2/input-4OHT-1_IGO_09569_2_S13_R1_001_cutadapt.fastq.gz Sample_input-4OHT-1_IGO_09569_2/input-4OHT-1_IGO_09569_2_S13_R1_001.fastq.gz 
