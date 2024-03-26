#!/bin/bash

cd `dirname ${0}`
cd ../

source ./scripts/env/classpath.sh

java -cp "${CLASSPATH}" org.springframework.batch.core.launch.support.CommandLineJobRunner META-INF/jobs/JBBA01001.xml JBBA01001
exit $?

