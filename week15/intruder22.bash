#!/bin/bash
for i in {1..20}
do

	curl 10.0.17.9/etc/passwd
	curl 10.0.17.9/bin/sh
	curl 10.0.17.9/cmd=
	curl 10.0.17.9/1=1#
        curl 10.0.17.9/bin/bash
	curl 10.0.17.9/1=1--
	curl 10.0.17.9
done




