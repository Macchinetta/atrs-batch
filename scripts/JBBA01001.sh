#!/bin/bash

cd `dirname ${0}`
cd ../

source ./scripts/env/classpath.sh

java -cp "${CLASSPATH}" org.springframework.batch.core.launch.support.CommandLineJobRunner jp.co.ntt.atrs.batch.jobs.JBBA01001Config JBBA01001
exit $?

