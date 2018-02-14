#!/bin/bash

cd `dirname ${0}`
cd ../

source ./scripts/env/setAsyncBatchEnv.sh
source ./scripts/env/classpath.sh

rm -f ${BATCH_TERMINATE_FILE}

java -cp "${CLASSPATH}" org.terasoluna.batch.async.db.AsyncBatchDaemon
exit $?
