#BSUB-J primary_chr               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.primary_chr
#BSUB-eo stderr.primary_chr


# awk '/^chr[0-9]*\t/ {printf("%s\t0\t%s\n",$1,$2);}' human_g1k_v37_prefix.fasta.fai  > your.bed

# Create bed file by copying pasting chr number, 0, length of chr
# cat /data/leslie/chuk/index_Karen/GRCm38_dna_primary_assembly/Mus_musculus.GRCm38.dna.primary_assembly.fa.fai


#/data/leslie/chuk/bin/samtools-1.11/samtools view -L Mus_musculus.GRCm38.dna.primary_assembly.bed -o ADA_2_nanopore_passed_primary_chr.bam ADA_2_nanopore_passed.bam
#samtools index ADA_2_nanopore_passed_primary_chr.bam

#/data/leslie/chuk/bin/samtools-1.11/samtools view -L Mus_musculus.GRCm38.dna.primary_assembly.bed -o ADA_1_nanopore_passed_primary_chr.bam ADA_1_nanopore_passed.bam
/data/leslie/chuk/bin/samtools-1.11/samtools index ADA_1_nanopore_passed_primary_chr.bam

#/data/leslie/chuk/bin/samtools-1.11/samtools view -L Mus_musculus.GRCm38.dna.primary_assembly.bed -o WT_1_nanopore_passed_primary_chr.bam WT_1_nanopore_passed.bam
/data/leslie/chuk/bin/samtools-1.11/samtools index WT_1_nanopore_passed_primary_chr.bam

#/data/leslie/chuk/bin/samtools-1.11/samtools view -L Mus_musculus.GRCm38.dna.primary_assembly.bed -o WT_2_nanopore_passed_primary_chr.bam WT_2_nanopore_passed.bam
/data/leslie/chuk/bin/samtools-1.11/samtools index WT_2_nanopore_passed_primary_chr.bam

# use samtools idxstats input.bam to see read coverage for different chromosomes (make sure the DNA scaffolds have no read counts to them)