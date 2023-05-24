#BSUB-J vcf.no.header               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.vcf.no.header
#BSUB-eo stderr.vcf.no.header

# STAR alignment
ls *.FinalR.vcf | parallel "sed '0,/#CHROM/d' {} > {}.no.header"

#Rscript rnaseq_read_count_mouse.R

# counts number of reads per gene
# --quantMode TranscriptomeSAM GeneCounts --sjdbGTFfile /data/leslie/chuk/index_Karen/GRCm38.p6_gtf/gencode.vM25.annotation.gtf
