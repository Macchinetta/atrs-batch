#!/bin/bash

cd `dirname ${0}`
cd ../

source ./scripts/env/classpath.sh

java -cp "${CLASSPATH}" org.springframework.batch.core.launch.support.CommandLineJobRunner META-INF/jobs/JBBA02001.xml JBBA02001
exit $?

