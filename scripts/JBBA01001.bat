@ECHO OFF

CD %~dp0..\

CALL scripts\env\classpath.bat

java org.springframework.batch.core.launch.support.CommandLineJobRunner META-INF/jobs/JBBA01001.xml JBBA01001

ECHO %ERRORLEVEL%

pause