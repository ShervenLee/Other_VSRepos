<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="checksession.asp" -->
<!-- #include file="fun-admin.asp" -->
<!Doctype html>
<html>
<%
		page_no=chk_num(trim_fun(request("page_no")))
		modid=chk_num(trim_fun(request("modid")))
		mydo=trim_fun(request("mydo"))
		call dperror(len(modid)=0 or isnull(modid),"��ȡ������Ϣ�������˳���¼���²���","")

  select case mydo
	  case "masking"
	  	'��������	  	
		sql="update BBS_Topic set topic_state=3 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"���γɹ�","admin_post.asp?see_type=3")
	  case "unmasking"
	  	'�������	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"������γɹ�","admin_post.asp?see_type=2")
	  case "checked"
	  	'�������	  	
		sql="update BBS_Topic set topic_state=2 where topic_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"������ӳɹ�","admin_post.asp?see_type=2")
		
	  case "del_topic"
	  	'ɾ������	
		call del_topic(modid)
		call dperror(true,"ɾ������ɹ�","admin_post.asp?see_type=1")
  end select


%>
<head>
<meta charset="gb2312">
<title><%=this_title%>����</title>
</head>
<body>
</body>
</html>