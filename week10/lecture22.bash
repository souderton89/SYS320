#!/bin/bash
countingCurlAccess() {
	curl --version | grep "curl " | cut 'x86_64-pc-linux-gnu'
	grep "curl" /var/log/apache2/access.log | awk '{print$1}' | sort | uniq -c
}

countingCurlAccess
