SET NOCOUNT ON
DECLARE @data as varchar (max)
DECLARE @json as varchar (max)
set @json = ''

DECLARE _cursor CURSOR FOR
    SELECT
	  AA.name + '-' + a.subplan_name + Char(13) + Char(10)
	  --AA.name + Char(10)
      /*FOR SELECT  AA.name + ';' + a.subplan_name + ';' + Char(10)*/
      /*FOR SELECT  '<module>' + Char(10) +  '<name><![CDATA[' + AA.name + ' - ' + a.subplan_name + ']]></name>' + Char(10) +  '<type><![CDATA[generic_data]]></type>' + Char(10) +  '<data><![CDATA[' + ']]></data>' + Char(10) +  '<description>Hola</description>' + Char(10) +  '</module>' + Char(10) as data*/
	from
	  msdb.dbo.sysmaintplan_subplans A 
	inner join
	  msdb.dbo.sysmaintplan_plans AA on A.plan_id = AA.id 
OPEN _cursor  

FETCH NEXT FROM _cursor into @data

while @@FETCH_STATUS =0
begin 
	set @json = @json + @data
	FETCH NEXT FROM _cursor into @data
end
close _cursor
deallocate _cursor 

print @json