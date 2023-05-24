#BSUB-J organize            
#BSUB-W 24:00                   	
#BSUB-n 5
#BSUB-M 20
#BSUB-R "span[ptile=9]"

#BSUB-eo ./stderr.organize
#BSUB-o ./stdout.organize

#input="experiment_report_2020_5_29_21h_38m_modified_KC.csv"
rm stderr.organize
rm stdout.organize

mkdir merged_bed
input="test.txt"

while read -r p; do # -r reads without interpreting the backslashes and keeps them

	echo $p

	# obtain gene name
	IFS=' ' # separate string by space
	read -ra ROW <<< "$p" # make the row into an array, which is ZERO indexed
	gene="${ROW[2]}"
	mkdir ./merged_bed/${gene} # will not make directory if folder exists, but for loop will still continue to next step
	echo "$gene"

	# create output directories
	outputbed="./merged_bed/${gene}"

	# obtain files
	filenames=${ROW[5]}
	bedfile=$(find /data/leslie/chuk/Encode_eCLIP_RBP_K562_hg19_bed/ -regex ".*\($filenames\).*" -name "*bed.gz")
	bedfinal=${bedfile//$'\n'/' '}
	echo $bedfinal

	IFS=' ' # separate string by space
	read -ra BED <<< "$bedfinal"
	# echo "${BED[0]}"

	for i in "${BED[@]}"
	do 
		# get filename
		basename_of_file="$(basename -- "$i")"
		# echo $basename_of_file

		# get basename of file
		basename_of_save_file="${basename_of_file%.gz}" # .bed
		# sorted_suffix_name="_sorted.bed"
		sorted_bed_filename="${basename_of_save_file%.bed}_sorted.bed" #_sorted.bed
		# echo $basename_of_save_file

		# gunzip
		gunzip -c ./$basename_of_file > $outputbed/$basename_of_save_file #.bed

		line=$(head -n 1 $outputbed/$basename_of_save_file)
		# echo $line

		if [[ "$line" == *"IDR"* ]]; then
			echo $basename_of_save_file
  			echo "It's there."
  			mkdir $outputbed/IDR_sample
  			mv $outputbed/$basename_of_save_file $outputbed/IDR_sample/
  			ls $outputbed/IDR_sample/
		fi

		# sort bed
		# echo ${sorted_bed_filename}
		# sort -k1,1 -k2,2n $outputbed/$basename_of_save_file > $outputbed/$sorted_bed_filename
		# save_file="${basename_of_save_file%.bed}_merged.bed"
		# mergeBed -s -i $outputbed/$sorted_bed_filename > $outputbed/$save_file # -s merges regions on same strand

	done


	# merge bed
	cat_bed_filename="${gene}_cat.bed"
	sorted_bed_filename="${gene}_sorted.bed"
	merge_bed_save_filename="${gene}_merged.bed"
	# echo $merge_bed_filename
	# echo $outputbed/*_sorted.bed
	# cat $outputbed/*_sorted.bed > $outputbed/$cat_bed_filename
	# mergeBed -s -i $outputbed/$merge_bed_filename > $outputbed/$merge_bed_save_filename # -s merges regions on same strand

	cat $outputbed/*.bed > $outputbed/$cat_bed_filename
	sort -k1,1 -k2,2n $outputbed/$cat_bed_filename > $outputbed/$sorted_bed_filename
	mergeBed -s -i $outputbed/$sorted_bed_filename > $outputbed/$merge_bed_save_filename # -s merges regions on same strand


done < $input




# while read p; do
#   row=$p
#   echo $row
#   dir.name=$(awk '{ print $3 }') # get column
#   echo $dir.name
  # mkdir ./test/"$dir.name"

  # for r in $row; do
  #   dir.name=$(awk '{ print $3 }' $row)
  #   mkdir ./test/"$dir.name"
  #   echo $(awk '{ print $6 }')
  # done

# done < $input

# while IFS= read -r line
# do
#   #echo "$line"
#   col=$(awk '{ print $3 }')
#   mkdir ./test/"$col"
# done < "$input"