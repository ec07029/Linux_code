#BSUB-J sam2tsv               # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.sam2tsv
#BSUB-eo stderr.sam2tsv

module add java
#java -jar /data/leslie/chuk/bin/jvarkit/dist/sam2tsv.jar -R /data/leslie/chuk/index_Karen/GRCm38_dna_primary_assembly/Mus_musculus.GRCm38.dna.primary_assembly_corrected_chr_annotation.fa /data/leslie/chuk/sc-HyperTRIBE/from_Nathan/minimap_bams/ADA_2_nanopore_passed.bam > ADA_2_nanopore_passed_sam2tsv.txt

java -jar /data/leslie/chuk/bin/jvarkit/dist/sam2tsv.jar -R /data/leslie/chuk/index_Karen/GRCm38_dna_primary_assembly/Mus_musculus.GRCm38.dna.primary_assembly_corrected_chr_annotation.fa /data/leslie/chuk/sc-HyperTRIBE/from_Nathan/minimap_bams/ADA_1_nanopore_passed.bam > WT_1_nanopore_passed_sam2tsv.txt

java -jar /data/leslie/chuk/bin/jvarkit/dist/sam2tsv.jar -R /data/leslie/chuk/index_Karen/GRCm38_dna_primary_assembly/Mus_musculus.GRCm38.dna.primary_assembly_corrected_chr_annotation.fa /data/leslie/chuk/sc-HyperTRIBE/from_Nathan/minimap_bams/WT_1_nanopore_passed.bam > ADA_1_nanopore_passed_sam2tsv.txt

java -jar /data/leslie/chuk/bin/jvarkit/dist/sam2tsv.jar -R /data/leslie/chuk/index_Karen/GRCm38_dna_primary_assembly/Mus_musculus.GRCm38.dna.primary_assembly_corrected_chr_annotation.fa /data/leslie/chuk/sc-HyperTRIBE/from_Nathan/minimap_bams/WT_2_nanopore_passed.bam > WT_2_nanopore_passed_sam2tsv.txt

# REMEMBER ADA1 IS ACTUALLY WT1 AND VICE VERSA