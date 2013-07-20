#!/bin/sh

# http://n00bsys0p.co.uk/blog/2012/07/09/wget-entire-ftp-folder-its-index-regex-introduction

# gets plant data
for i in $(wget ftp://ftp.ncbi.nih.gov/refseq/release/plant/ -O - | grep "ftp://" | sed 's/^.*href=\"//g' | sed 's/\".*$//g' | grep protein.faa.gz); do
    wget $i;
done
