for bam in *bam; do name=`basename ${bam} .bam`; samtools flagstat ${bam} > ${name}_flagstat.txt; echo $bam; done
