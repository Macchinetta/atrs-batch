#!/bin/bash

cd `dirname ${0}`
cd ../

source ./scripts/env/setAsyncBatchEnv.sh

touch ${BATCH_TERMINATE_FILE}
exit $?