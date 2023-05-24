#BSUB-J variant_call        # name of the job
#BSUB-W 99:00                   	# Time limit 
#BSUB-n 9
#BSUB-R "span[ptile=9]"
#BSUB-M 25

#BSUB-o stdout.variant_call
#BSUB-eo stderr.variant_call

# Load Java 8
module add java
# I converted the mm10 dbSNP annotation myself; Here is how I did it
# Indexing the fasta sequence
# java -jar ~/jartools/picard.jar CreateSequenceDictionary REFERENCE=mm10_star/GRCm38.primary_assembly.genome.fa OUTPUT=mm10_star/GRCm38.primary_assembly.genome.dict 
# samtools faidx mm10_star/GRCm38.primary_assembly.genome.fa
# Sort dbSNP VCF according to reference sequence
# java -jar ~/jartools/picard.jar SortVcf I=dbsnp_mouse/dbsnp_151_mouse.vcf  O=dbsnp_mouse/dbsnp_151_mouse.sorted.vcf  SEQUENCE_DICTIONARY=mm10_star/GRCm38.primary_assembly.genome.dict 

# Picard: add RG & mark duplicates
ls -d Sample*[0-9] | parallel 'java -jar /data/leslie/chuk/jartools/picard.jar AddOrReplaceReadGroups I={}.bam O={}.rg_added.bam RGID=id RGLB=library RGPL=ILLUMINA RGPU=machine RGSM=sample'
ls -d Sample*[0-9] | parallel 'java -jar /data/leslie/chuk/jartools/picard.jar MarkDuplicates I={}.rg_added.bam O={}.dedupped.bam CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT M=output.metrics'