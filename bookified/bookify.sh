#! /bin/bash

# This script expects to find a file called "links" with a list of links to
# pngs. It downloads all the pngs, then uses ImageMagick's "convert" binary to
# collate them into a PDF.
#
# To generate the links file for Google Books, use this:
# https://github.com/mcdxn/google-books-preview-pages-downloader
#
# To generate the links file for scanned images on a remote server, run
#
# python -m http.server
#
# in the remote server's directory and run:
#
# for l in $(curl http://<ip>:8000 2>&1 | grep  -oP '[0-9a-zA-Z]+.png'); do
#     echo "http://<ip>:8000$l" >> links
# done

c=1
for l in $(cat links); do
    wget -O $c.png $l
    c=$((c+1))
done

# If you run into "cache resources exhausted", do this:
# https://stackoverflow.com/questions/31407010/cache-resources-exhausted-imagemagick
convert $(ls *png | sort -n) book.pdf
