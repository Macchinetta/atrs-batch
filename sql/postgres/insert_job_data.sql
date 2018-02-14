BEGIN;
INSERT INTO BATCH_JOB_REQUEST(job_name,job_parameter,polling_status,create_date) VALUES('JBBB01001','firstDateStr=' || :start || ', lastDateStr=' || :end,'INIT',current_timestamp);
INSERT INTO BATCH_JOB_REQUEST(job_name,job_parameter,polling_status,create_date) VALUES('JBBB01002','firstDateStr=' || :start || ', lastDateStr=' || :end,'INIT',current_timestamp);
INSERT INTO BATCH_JOB_REQUEST(job_name,job_parameter,polling_status,create_date) VALUES('JBBB01003','firstDateStr=' || :start || ', lastDateStr=' || :end,'INIT',current_timestamp);
COMMIT;
