#BSUB-J volcano.plots           # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 10
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.volcano_plots_with_hypertribe_targets_colored
#BSUB-eo stderr.volcano_plots_with_hypertribe_targets_colored

Rscript volcano_plots_with_hypertribe_targets_colored.R
