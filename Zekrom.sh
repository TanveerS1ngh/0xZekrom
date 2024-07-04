#!/bin/bash

# Parse command line arguments
while getopts ":u:" opt; do
    case $opt in
        u)
            url="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Check if URL is provided
if [ -z "$url" ]; then
    echo "Please provide a URL using the -u flag."
    exit 1
fi

# Create a directory to store the downloaded pages
output_dir="website_crawl_$(date +%Y%m%d%H%M%S)"
mkdir "$output_dir"

# Crawl the website using wget and Grep domain and subdomain from crawled pages and remove crawled files

wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains "$url" --no-parent --span-hosts --level=inf -P "$output_dir" "$url" > /dev/null 2>&1 && echo "Crawling domain: $url" | grep -E -o "(http|https)://[a-zA-Z0-9./?=_-]*" "$output_dir"/* > domains.txt && rm -rf "$output_dir"

echo "Website crawl completed. Pages are saved in $output_dir directory."