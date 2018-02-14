@ECHO OFF

CD %~dp0..\

CALL scripts\env\setAsyncBatchEnv.bat
CALL scripts\env\classpath.bat

DEL /Q %BATCH_TERMINATE_FILE%

java org.terasoluna.batch.async.db.AsyncBatchDaemon

pause