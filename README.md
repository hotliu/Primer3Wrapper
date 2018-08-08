# Primer3Wrapper
This is a python script that intakes a CSV format and outputs primers to amplify that region.

This script intakes a MS-DOS CSV and output designed primers, with sequencing adapters, to amplify said region.
The primary application of this script has been to amplify DNA flanking a CRISPR-Cas9 site for DNA repair analysis. 

In short, the python script is called with the syntax `./crispr_ -f inputfile_csv -g genome_contig -o outputfile_prefix -s search_range -n cut_index`

Primer3 setting can be changed in the `primer3_settings.cnf` file.

And returns a total of 3x files:
1.) outputfile_prefix - formatted CSV with primer sequences, including tags, amplicon sequence, guide sequence, genomic locations
2.) outputfile_prefix.bed - formatted ".bed" file used as an input to many CRISPR-based applications or visualizations
3.) outputfile_prefix.bed.dropout - formatted csv file, in the same format as the entry file, containing all locations where primers were not found. 

A more detailed explanation:
crispr_primer takes as an input a formatted csv and uses Primer3 to find a number of forward and reverse primers that flank said sites. These output primers are dependent on total amplicon size (set in primer3_settings.cnf file), cutsite offset (found in crispr_primer.py script), as well as SNP regions (ispcr) and Tm calculations. As a final screen, all primers are subjected to a custom homodimer and heterodimer analysis - with adapters. This is important because Primer3 does not perform this function.  

Note that all dependent functions are not included in this repository and have to be installed seperately (see install.sh file) 
