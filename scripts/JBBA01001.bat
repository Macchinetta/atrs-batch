@ECHO OFF

CD %~dp0..\

CALL scripts\env\classpath.bat

java org.springframework.batch.core.launch.support.CommandLineJobRunner jp.co.ntt.atrs.batch.jobs.JBBA01001Config JBBA01001

ECHO %ERRORLEVEL%

pause