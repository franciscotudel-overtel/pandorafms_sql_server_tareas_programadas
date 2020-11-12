SET NOCOUNT ON
DECLARE @plan varchar(40)
declare @subplan varchar (40)

--set @plan=$(TR)
set @plan=N'$(TAREA)'
set @subplan = null
-- Primera fila succeeded 1=OK 0=KO
-- Segunda hora de ejecucion
-- Horas de vieja que tiene la copia o el plan

-- <module>
-- <name><![CDATA[tmpfs]]></name>
-- <type><![CDATA[generic_data]]></type>
-- <data><![CDATA[0]]></data>
-- <description>% of usage in this volume</description>
-- </module>
 
if (@subplan is not null) 
	SELECT top 1 
	  convert(varchar(15),DATEDIFF (hh,msdb.dbo.sysmaintplan_log.end_time,getdate()))
	  /*'<module>' + Char(10) + 
	  '<name><![CDATA[Tarea ' + s.name + ' - ' + sp.subplan_name + ' Resultado]]></name>' + Char(10) + 
	  '<type><![CDATA[generic_data]]></type>'  + Char(10) + 
	  '<data><![CDATA[' + convert(varchar(15),DATEDIFF (hh,msdb.dbo.sysmaintplan_log.end_time,getdate()))  + ']]></data>' + Char(10) + 
	  '<description>Resultado de ejecucion</description>' + Char(10) +
	  '</module>'*/
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
	  convert(varchar(15),DATEDIFF (hh,msdb.dbo.sysmaintplan_log.end_time,getdate()))
	  /*'<module>' + Char(10) + 
	  '<name><![CDATA[Tarea ' + s.name + ' - ' + sp.subplan_name + ' Resultado]]></name>' + Char(10) + 
	  '<type><![CDATA[generic_data]]></type>'  + Char(10) + 
	  '<data><![CDATA[' + convert(varchar(15),DATEDIFF (hh,msdb.dbo.sysmaintplan_log.end_time,getdate()))  + ']]></data>' + Char(10) + 
	  '<description>Resultado de ejecucion</description>' + Char(10) +
	  '</module>'*/
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