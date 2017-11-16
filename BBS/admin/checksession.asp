<%
if len(session("admin_num"))=0 or isnull(session("admin_num")) then
%>
<script>
alert("登录超时，为安全起见，请重新登录再操作！");
parent.window.location.href='../';
</script>
<%
	response.End()
end if

%>