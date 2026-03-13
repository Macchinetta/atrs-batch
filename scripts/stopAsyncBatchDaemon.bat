@ECHO OFF

CD %~dp0..\

CALL scripts\env\setAsyncBatchEnv.bat

TYPE NUL > %BATCH_TERMINATE_FILE%
