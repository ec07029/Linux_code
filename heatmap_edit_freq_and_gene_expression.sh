#BSUB-J heatmap_edit_freq_and_gene_expression           # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 1
#BSUB-M 10
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.heatmap_edit_freq_and_gene_expression
#BSUB-eo stderr.heatmap_edit_freq_and_gene_expression

Rscript heatmap_edit_freq_and_gene_expression.R
