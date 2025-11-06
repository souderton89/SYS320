#!/bin/bash

pageCount() {
cut -d' ' -f7 /var/log/apache2/access.log | sort | uniq -c | sort -n
}

pageCount
