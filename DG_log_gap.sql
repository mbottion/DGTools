select process,status,sequence# from v$managed_standby;

SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last Sequence Received", APPL.SEQUENCE# "Last Sequence Applied", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference" FROM (SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH,(SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL WHERE ARCH.THREAD# = APPL.THREAD# ORDER BY 1;

select thread#, max(sequence#) "Last Standby Seq Received" from v$archived_log val,
v$database vdb where val.resetlogs_change# = vdb.resetlogs_change# group by thread# order by 1;

select thread#, max(sequence#) "Last Standby Seq Applied" from v$archived_log val,
v$database vdb where val.resetlogs_change# = vdb.resetlogs_change# and val.applied in
('YES','IN-MEMORY') group by thread# order by 1;

select CHECKPOINT_TIME, count(*) from v$datafile_header group by CHECKPOINT_TIME order by 1;

