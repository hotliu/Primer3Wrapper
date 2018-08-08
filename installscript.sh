#
# IMPORTANT NOTE: This script did not run to completion using `packer build`,
# so I ran the remaining lines manually. I also had to copy over a non-public
# version of gfPcr.
#
#

# TODO: Not sure why this magic is needed
sudo apt-get install unzip
sudo apt-get -f install --yes && sudo dpkg --configure -a

#Installing isPcr
cd /mnt/data
wget http://hgwdev.cse.ucsc.edu/~kent/exe/linux/isPcr.zip && mkdir isPcr && unzip isPcr.zip -d isPcr
ln -s /mnt/data/isPcr ~/isPcr
# blat
mkdir blat && wget http://hgwdev.cse.ucsc.edu/~kent/exe/linux/blatSuite.zip && unzip blatSuite.zip -d blat
ln -s /mnt/data/blat ~/blat

# Primer3
sudo apt-get install -y primer3

# python2, twoBitToFa
export PATH=$HOME/anaconda/bin:$PATH
conda create -n python2 anaconda python=2
source activate python2
conda install -c bioconda ucsc-twobittofa

# fastinterval
sudo apt-get install -y liblzo2-dev zlib1g-dev
pip install fastinterval

# genomes
cd /mnt/data
mkdir genome
cd genome
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.2bit
twoBitToFa hg38.2bit hg38.fa
wget http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/mm10.2bit
twoBitToFa mm10.2bit mm10.fa
ln -s /mnt/data/genome ~/genome

# SNP genomes
cd /mnt/data/genome
mkdir hg38snp142
cd hg38snp142
curl --remote-name-all http://hgdownload.cse.ucsc.edu/goldenPath/hg38/snp142Mask/chr[1-22].subst.fa.gz
curl --remote-name-all http://hgdownload.cse.ucsc.edu/goldenPath/hg38/snp142Mask/chr{X,Y}.subst.fa.gz
gzip -d *.gz

cat *.subst.fa > ../hg38.snp142.fa

cd /mnt/data/genome
mkdir mm10snp142
cd mm10snp142
curl --remote-name-all http://hgdownload.cse.ucsc.edu/goldenPath/mm10/snp142Mask/chr[1-19].subst.fa.gz
curl --remote-name-all http://hgdownload.cse.ucsc.edu/goldenPath/mm10/snp142Mask/chr{X,Y}.subst.fa.gz
gzip -d *.gz

cat *.subst.fa > ../mm10.snp142.fa

# For login
echo >> ~/.profile
echo "source activate python2" >> ~/.profile

# Test with...
# aegea launch -t t2.large crispr-primer
# aegea ssh ubuntu@crispr-primer
# ./crispr_primer.py -f example_input.bed.csv -g hg38 -o example_output.csv
