#Pooja Singh
#pooja.singh09@gmail.com
#June2020
#replace alleles in a reference fasta with alternative alleles (from a vcf or snp table)
#pseudogenomes are useful for using as a species/strain specific reference for mapping and snp-calling or for building phylogenies
# this script takes 20 to 30 mins to process a 14Gb ref genome.

## convert fasta to tab. this is important for the awk code to work. seqkit can be installed from here https://bioinf.shenwei.me/seqkit/

seqkit fx2tab ref.fa > ref.tab



#awk to replace alleles in the reference. the alleles2replace.txt file should ONLY contain the loci that you wish to replace
#alleles2replace.txt file's first four columns should be CHROM, POS, REF, ALT, with CHROM & POS being the loci that you are targetting, 
REF being the reference alleles and ALT being the alternative allele. alleles2replace.txt can be the first four columns of a vcf file 
that has been generated from mapping and snp-calling. Be sure to remove multiallelic loci before you run this.

awk 'FILENAME=="ref.tab" {fa[$1]=$2; next} {fa[$1]=substr(fa[$1], 1, $2-1) $4 substr(fa[$1], $2+1, length(fa[$1])-$2)} END {for (id in fa){print ">" id "\n" fa[id]}}' ref.tab alleles2replace.txt > ref.replaced.fa


# make sure you do some spot checking of ref versus replaced fasta files but viewing alingments in seaview or similar program

