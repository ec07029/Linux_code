#BSUB-J rnaseq_read_count            # name of the job
#BSUB-W 99:00                   	# Time limit in minutes
#BSUB-n 4
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-o stdout.rnaseq_read_count
#BSUB-eo stderr.rnaseq_read_count

Rscript rnaseq_read_count_mouse_with_intron_annotation_Dart-seq.R
