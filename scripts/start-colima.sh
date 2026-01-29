#/bin/bash

colima start --cpus 4 --memory 6 && \
	dservices start
