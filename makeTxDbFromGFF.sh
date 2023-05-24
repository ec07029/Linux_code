#BSUB-J makeTxDbFromGFF            # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 2
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.makeTxDbFromGFF
#BSUB-eo stderr.makeTxDbFromGFF

Rscript makeTxDbFromGFF.R
