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
	  case "gag"
	  	'���Ի�Ա	  	
		sql="update BBS_User set user_state=2 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"���Գɹ�","admin_meber.asp?see_type=2")
	  case "ungag"
	  	'�������	  	
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"������Գɹ�","admin_meber.asp?see_type=1")
	  case "lock"
	  	'������Ա	  	
		sql="update BBS_User set user_state=3 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"�����ɹ�","admin_meber.asp?see_type=3")
	  case "unlock"
	  	'������Ա
		sql="update BBS_User set user_state=1 where user_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(true,"�����ɹ�","admin_meber.asp?see_type=1")
	  case "del_user_post"
	  	'ɾ����Ա	
		call del_user_post(modid)
		call dperror(true,"ɾ���������ӳɹ�","admin_meber.asp?see_type=1")
	  case "del_user"
	  	'ɾ����Ա	
		call del_user(modid)
		call dperror(true,"ɾ����Ա�ɹ�","admin_meber.asp?see_type=1")
  end select


%>
<head>
<meta charset="gb2312">
<title><%=this_title%>��Ա</title>
</head>
<body>
</body>
</html>