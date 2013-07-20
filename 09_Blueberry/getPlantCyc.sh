#!/bin/sh

# http://n00bsys0p.co.uk/blog/2012/07/09/wget-entire-ftp-folder-its-index-regex-introduction

for i in $(wget ftp://ftp.plantcyc.org/tmp/private/plantcyc/ -O - | grep "ftp://" | sed 's/^.*href=\"//g' | sed 's/\".*$//g' | grep tar.gz); do
    wget $i;
done
