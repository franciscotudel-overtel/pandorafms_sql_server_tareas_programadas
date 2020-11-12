SET NOCOUNT ON
DECLARE @plan varchar(40)
declare @subplan varchar (40)

set @plan=N'$(TAREA)'
set @subplan = null

 
if (@subplan is not null) 
	SELECT top 1 
	  convert(varchar(15),DATEDIFF (ss,msdb.dbo.sysmaintplan_log.start_time,msdb.dbo.sysmaintplan_log.end_time))
	FROM
	  msdb.dbo.sysmaintplan_log
	INNER JOIN
	  msdb.dbo.sysmaintplan_plans AS s ON msdb.dbo.sysmaintplan_log.plan_id=s.id 
	INNER JOIN
	  msdb.dbo.sysmaintplan_subplans AS sp ON sp.plan_id=s.id 
	WHERE
	  s.name =@plan and sp.subplan_name = @subplan
	ORDER BY
	  msdb.dbo.sysmaintplan_log.start_time desc
else
	SELECT Top 1 
	  convert(varchar(15),DATEDIFF (ss,msdb.dbo.sysmaintplan_log.start_time,msdb.dbo.sysmaintplan_log.end_time))
	FROM
	  msdb.dbo.sysmaintplan_log
	INNER JOIN
	  msdb.dbo.sysmaintplan_plans AS s ON msdb.dbo.sysmaintplan_log.plan_id=s.id 
	INNER JOIN
	  msdb.dbo.sysmaintplan_subplans AS sp ON sp.plan_id=s.id 
	WHERE
	  s.name =@plan 
	ORDER BY
	  msdb.dbo.sysmaintplan_log.start_time desc