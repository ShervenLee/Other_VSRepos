<%
myurl=Request.ServerVariables("QUERY_STRING")
temp=myurl
temp=replace(temp,".html","")
temp=replace(temp,"b","")
'���
temp=replace(temp,"p","")
'ҳ��
temp=replace(temp,"u","")
'�û���ҳ
temp=replace(temp,"n","")
'������
temp=replace(temp,"r","")
'ע���»�Ա
temp=replace(temp,"e","")
'�޸Ļ�Ա����
temp=replace(temp,"z","")
'�޸�������
temp=replace(temp,"h","")
'�޸Ļظ���
if instr(temp,"-")>0 then
	arr=split(temp,"-")
	topic_no=arr(0)
	page_no=arr(1)
else
	topic_no=temp
	page_no=1
end if
if len(myurl)>0 then
	if not(isnumeric(topic_no) and isnumeric(page_no)) and (left(myurl,1)="b" or left(myurl,1)="p" or left(myurl,1)="u") then
		response.Redirect("?")
		response.End()
	end if
end if

topic_no=chk_num(topic_no)
page_no=chk_num(page_no)
if topic_no<=0 then topic_no=1
if page_no<=0 then page_no=1
%>