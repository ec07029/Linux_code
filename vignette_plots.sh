#BSUB-J vignette_plots           # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 10
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.vignette_plots
#BSUB-eo stderr.vignette_plots

Rscript vignette_plots.R
