<!-- #include file="conn-bbs.asp" -->
<!Doctype html>
<html>

    
<%
	topic_title=trim_fun(request("topic_title"))
	topic_id=chk_num(trim_fun(request("topic_id")))	
	topic_user_id=chk_num(trim_fun(request("topic_user_id")))	
	topic_Content=request("topic_Content")
	user_id=chk_num(session_user_id)
	
	call dperror(len(topic_title)=0 or isnull(topic_title),"���ⲻ��Ϊ��","")
	call dperror(len(topic_Content)=0 or isnull(topic_Content),"����������","")
	call dperror(user_id<>topic_user_id,"��û���޸�Ȩ��","")
	
	
	
	'��ȡ��Ա״̬
	sql="select * from BBS_User where user_id="& user_id &""
	set rs=bbsconn.execute(sql)
	user_state=0
	if not rs.eof then user_state=chk_num(rs("user_state"))
	call dperror(user_state=2,"����Ȩ�޷������ѱ�����","")
	call dperror(user_state=3,"����Ȩ�޷������ѱ�����","")
	
	
	sql="select * from BBS_Topic where topic_id="& topic_id &" and user_id="& user_id &""
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,bbsconn,1,3
	call dperror(rs.eof,"��û���޸�Ȩ��","")
		rs("topic_title")=topic_title
		rs("topic_Content")=topic_Content
		rs("lastedit_time")=thistime			
	rs.update
	
	
	call dperror(true,"�޸ĳɹ�","../?p"& topic_id &".html")
	response.End()


%>
<head>
<meta charset="gb2312">
<title>ע���Ա</title>
</head>
<body>
</body>
</html>