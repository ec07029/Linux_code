#BSUB-J betabinom            # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 4
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.betabinom
#BSUB-eo stderr.betabinom

Rscript betabinom.R
