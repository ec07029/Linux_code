#BSUB-J encode.download              # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 4
#BSUB-M 5
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.encode.download
#BSUB-eo stderr.encode.download

xargs -L 1 curl -O -L < files.txt