<%
if len(session("admin_num"))=0 or isnull(session("admin_num")) then
%>
<script>
alert("��¼��ʱ��Ϊ��ȫ����������µ�¼�ٲ�����");
parent.window.location.href='../';
</script>
<%
	response.End()
end if

%>