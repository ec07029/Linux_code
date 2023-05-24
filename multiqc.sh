#BSUB-J multiqc              # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 9
#BSUB-M 4
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.multiqc
#BSUB-o stderr.multiqc

multiqc .
