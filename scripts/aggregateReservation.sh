#!/bin/bash

cd `dirname ${0}`
cd ../

DB_HOSTNAME=127.0.0.1
DB_USERNAME=postgres
DBNAME=atrs_batch

psql -h ${DB_HOSTNAME} -U ${DB_USERNAME} -d ${DBNAME} -f sql/postgres/insert_job_data.sql -v start="$1" -v end="$2"

