<%
'ɾ������
sub del_cache()
	'ɾ��վ�������Ϣ����
	del_fileurl=DB_folder&"cache/webconfig.xml"
	Set objfso = Server.CreateObject("Scripting.FileSystemObject")
	del_fileurl=server.mappath(del_fileurl)
	if objfso.fileexists(del_fileurl) then objfso.DeleteFile(del_fileurl)
end sub

'ɾ���ظ�
sub del_replay(replay_id)
	sql_del="select * from BBS_Reply where id="& replay_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="update BBS_Topic set replay_count=replay_count-1 where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
end sub

'ɾ������
sub del_topic(topic_id)	
	sql_del="select * from BBS_Topic where topic_id="& topic_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	if not rs_del.eof then
		topic_id=rs_del("topic_id")
		sql_del2="delete * from BBS_Reply where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	end if
end sub

'ɾ����Ա
sub del_user(user_id)
	call del_user_post(user_id)
	sql_del="delete * from BBS_User where user_id="& user_id &""
	set rs_del=bbsconn.execute(sql_del)
end sub
'ɾ����������
sub del_user_post(user_id)
	
	sql_del="select * from BBS_Topic where user_id="& user_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="delete * from BBS_Reply where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
	'ɾ�����Ļظ�
	sql_del="select * from BBS_Reply where user_id="& user_id &""
	set rs_del=server.CreateObject("adodb.recordset")
	rs_del.open sql_del,bbsconn,1,3
	do while not rs_del.eof 
		topic_id=rs_del("topic_id")
		sql_del2="update BBS_Topic set replay_count=replay_count-1 where topic_id="& topic_id &""
		set rs_del2=bbsconn.execute(sql_del2)
		rs_del.delete
		rs_del.update
	rs_del.movenext
	loop
end sub

'������ʾδ���ı������	
sub display_blanktr(i,page_size,colspan)
	if i>1 and i<page_size then 
	  do while i<=page_size
	  response.Write("<tr><td colspan="""& colspan &""" style=""background-color:#fff;"">&nbsp;</td></tr>")
	  i=i+1
	  loop
	end if
end sub	
%>