@ECHO OFF

CD %~dp0..\

SET DB_HOSTNAME=127.0.0.1
SET DB_USERNAME=postgres
SET DBNAME=atrs_batch

psql.exe -h %DB_HOSTNAME% -U %DB_USERNAME% -d %DBNAME% -f sql\postgres\insert_job_data.sql -v start='%1' -v end='%2'

pause