# Concatenate R1 fastq.gz files
for f in JAX_0401/*; do
output=$(sed 's@.*/@@' <<< $f) # print folder names
output=$output
echo *JAX*/$output/*R1* # Obtain R1 fastq.gz files
cat *JAX*/$output/*R1* > "${output}_R1_001.fastq.gz" # Concatenate both fastq files and save output to current directory
echo "\n"
done

# Concatenate R2 fastq.gz files
for f in JAX_0401/*; do
output=$(sed 's@.*/@@' <<< $f) # print folder names
output=$output
echo *JAX*/$output/*R2*
cat *JAX*/$output/*R2* > "${output}_R2_001.fastq.gz"
echo "\n"
done

# Create directories for sample names
for f in JAX_0401/*; do
output=$(sed 's@.*/@@' <<< $f) # print folder names
echo $output
mkdir $output
done

# Put appropriate filenames into matched folder names
for f in JAX_0401/*; do
output=$(sed 's@.*/@@' <<< $f) # print folder names
mv "${output}_R1_001.fastq.gz" $output
mv "${output}_R2_001.fastq.gz" $output
echo "\n"
done

# Now run tribe alignment and variant calling.
