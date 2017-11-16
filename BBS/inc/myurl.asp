<%
myurl=Request.ServerVariables("QUERY_STRING")
temp=myurl
temp=replace(temp,".html","")
temp=replace(temp,"b","")
'板块
temp=replace(temp,"p","")
'页面
temp=replace(temp,"u","")
'用户主页
temp=replace(temp,"n","")
'发新贴
temp=replace(temp,"r","")
'注册新会员
temp=replace(temp,"e","")
'修改会员资料
temp=replace(temp,"z","")
'修改主题贴
temp=replace(temp,"h","")
'修改回复贴
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