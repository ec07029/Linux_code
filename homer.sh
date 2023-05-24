#BSUB-J homer            
#BSUB-W 24:00                   	
#BSUB-n 1
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-eo ./stderr.homer
#BSUB-o ./stdout.homer


input="Syncrip_MPP_plusminus_100bp_window.fa"
output="./"
background="Syncrip_MPP_3UTR_RANDOM_BACKGROUND.fa"

/data/leslie/chuk/bin/homer/bin/findMotifs.pl $input hg19 $output -fasta $background -p 1 -norevopp -noknown -basic -rna -len 6,7,8

compareinput="./homerMotifs.all.motifs"
compareoutput="./compareMotifs/"
rbpdatabase="/data/leslie/chuk/HOMER_database/CISBP/KarenChu_generated_motif_files_for_HOMER/CISBP.all.PWMs.motifs.txt"

/data/leslie/chuk/bin/homer/bin/compareMotifs.pl $compareinput $compareoutput -known $rbpdatabase -cpu 4 -rna -norevopp

