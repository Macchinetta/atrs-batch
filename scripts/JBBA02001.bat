@ECHO OFF

CD %~dp0..\

CALL scripts\env\classpath.bat

java org.springframework.batch.core.launch.support.CommandLineJobRunner META-INF/jobs/JBBA02001.xml JBBA02001

ECHO %ERRORLEVEL%

pause