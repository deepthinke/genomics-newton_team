#!/bin/bash
#download the file DNA.fa

wget  https://raw.githubusercontent.com/HackBio-Internship/wale-home-tasks/main/DNA.fa
#count the number of sequences in the file downloaded

grep -c  "^>" DNA.fa

grep -c  "^>" DNA.fa

#geting the total A,T,G,C counts for all the sequnce above

grep -Eo "A|T|G|C" DNA.fa | sort | uniq -c | awk '{print $2": $1}' 

#setting up miniconda environment
#installing miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sour Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
source ~/bashrc


#installing 3 required software
 sudo apt-get  -y fastp
 sudo apt-get  -y fastqc
 sudo apt-get  -y bwa

#download the datasets

wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R2.fastq.gz?raw=true
wget  https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R1.fastq.gz?raw=true
wget  https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R2.fastq.gz?raw=true
wget  https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R1.fastq.gz
wget  https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R2.fastq.gz?raw=true

#create a folder called output
mkdir output

#implementing the 3 software  installed om the downloaded files

#using fastqc to check the quality of the  raw_read files directind it to output folder


fastqc *.fastqc.gz -o output/

#using fastp to trim adapters and low quality reads

#create a list of the samples

SAMPLES=(
  "ACBarrie"
  "Alsen"
  "Baxter"
)
#create a for loop to activate fastp for both the forward and reverse of each sample

for SAMPLE in "${SAMPLES[@]}"; do

        fastp \
          -i "$PWD/${SAMPLE)_R1.fastq.gz" \
          -I "$PWD/${SAMPLE)_R2.fastq.gz" \
          -o "output/${SAMPLE)_R1.fastq.gz" \
          -O "output/${SAMPLE)_R2.fastq.gz" \
          --html "output/${SAMPLE}_fastp.html"
done 

#implementing the burrow wheeler alignment tool(bwa) for genome mapping

#the bwa requires 3 processes, doing repairs for with the bbtools repair.sh, buiding a reference genome index with bwa index and performing alignment wit>
#change directory to  output folder

cd output

#create a file called reference
 mkdir references

#download the reference genome into the folder
wget https://github.com/josoga2/yt-dataset/raw/main/dataset/references/reference.fasta

#create a list for the samples
#create a list for the samplesinto the folder


SAMPLES=(
  "ACBarrie"
  "Alsen"
  "Baxter"
)

bwa index output/reference.fasta
mkdir repaired



#using a for loop


for SAMPLE in "${SAMPLES[@]}"; do

        repair.sh in1="output/${SAMPLE}_R1.fastq.gz" in2="output/${SAMPLE}_R2.fastq.gz" out1="repaired/${SAMPLE}_R1_rep.fastq.gz" out2="repaired/${SAMPLE>

echo PWD
 
bwa mem -t 1 \
references/reference.fasta \
"repaired/${SAMPLE}_R1_rep.fastq.gz" "repaired/${SAMPLE}_R2_rep.fastq.gz" \

done


