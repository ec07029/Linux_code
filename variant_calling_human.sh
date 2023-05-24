#BSUB-J variant_call        # name of the job
#BSUB-W 99:00                   	# Time limit 
#BSUB-n 9
#BSUB-R "span[ptile=9]"
#BSUB-M 25

#BSUB-o stdout.variant_call.split
#BSUB-eo stderr.variant_call.split

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

# Split reads
ls -d Sample*[0-9] | parallel 'java -jar /data/leslie/chuk/jartools/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar -T SplitNCigarReads -R /data/leslie/chuk/index_Karen/ucsc.hg19/hg19.fa -I {}.dedupped.bam -o {}.split.bam -rf ReassignOneMappingQuality -RMQF 255 -RMQT 60 -U ALLOW_N_CIGAR_READS'

# Call SNPs & annotate
ls -d Sample*[0-9] | parallel 'java -jar /data/leslie/chuk/jartools/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar -T HaplotypeCaller -R /data/leslie/chuk/index_Karen/ucsc.hg19/hg19.fa -I {}.split.bam -dontUseSoftClippedBases -stand_call_conf 10.0 -o {}.HaplotypesR.vcf --dbsnp /data/leslie/chuk/index_Karen/ucsc.hg19/dbsnp_138.hg19/dbsnp_138.hg19_reordered_FINAL-KC.vcf'
ls -d Sample*[0-9] | parallel 'java -jar /data/leslie/chuk/jartools/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar -T VariantFiltration -R /data/leslie/chuk/index_Karen/ucsc.hg19/hg19.fa -V {}.HaplotypesR.vcf -window 35 -cluster 3 -filterName FS -filter "FS > 30.0" -filterName QD -filter "QD < 2.0" -o {}.FinalR.vcf'

# To combine all samples into one vcf file. (Hyunwoo's help)
#java -jar /data/leslie/chuk/jartools/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar -T HaplotypeCaller -R databases/GRCm38_GencodeM15/GRCm38.primary_assembly.genome.fa -I {}sample1.split.bam -I {}sample2.split.bam -I {}sample3.split.bam -dontUseSoftClippedBases -stand_call_conf 10.0 -o merged.filename.1.20190806.HaplotypesR.vcf --dbsnp databases/dbsnp_mouse/dbsnp_151_mouse.sorted.vcf'
