<%
call chk_webconfig()

'开始读取缓存里面的设置
Set objXML2 = Server.CreateObject("Msxml2.DOMDocument") 
objXML2.async = False
loadResult = objXML2.load(Server.MapPath(DB_folder&"cache/webconfig.xml")) 
if not loadResult then 
	Response.write "装载网站设置参数的XML文件错误，请检查" 
	Response.end 
end If 
Set objNodes = objXML2.getElementsByTagName("bbsset") 
if objNodes.length>0 then
	bbsset_sitename=objNodes(0).selectSingleNode("bbsset_sitename").Text
	bbsset_boardpagesize=objNodes(0).selectSingleNode("bbsset_boardpagesize").Text
	bbsset_topicpagesize=objNodes(0).selectSingleNode("bbsset_topicpagesize").Text
	bbsset_topicpoststate=objNodes(0).selectSingleNode("bbsset_topicpoststate").Text
end if
set objNodes = Nothing 
Set objXML = Nothing 

bbsset_boardpagesize=chk_num(bbsset_boardpagesize)
bbsset_topicpagesize=chk_num(bbsset_topicpagesize)
bbsset_topicpoststate=chk_num(bbsset_topicpoststate)


'检查网站配置文件是否存在，如果不存在就生成
sub chk_webconfig()
	if chkFile(DB_folder&"cache/webconfig.xml")="no" then
		call gotoFolder(DB_folder&"cache/")
		sql="select * from BBS_Setting"
		set rs=bbsconn.execute(sql)
		config_html="<?xml version=""1.0"" encoding=""gb2312""?><bbsset>"
		do while not rs.eof
			set_name=rs("set_name")
			set_value=rs("set_value")
			config_html=config_html&"<"& set_name &">"& set_value &"</"& set_name &">"
		rs.movenext
		loop
		config_html=config_html&"</bbsset>"
		call gotoFile(DB_folder&"cache/webconfig.xml",config_html)
	end if
end sub

Function getHTTPPage(Path) 
t = GetBody(Path) 
getHTTPPage=BytesToBstr(t,"GB2312") 
End function 

Function BytesToBstr(body,Cset) 
dim objstream 
'session("gl_user")="html"
set objstream = Server.CreateObject("adodb.stream") 
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset = Cset 
BytesToBstr = objstream.ReadText 
objstream.Close 
set objstream = nothing 
End Function 

Function GetBody(url) 
'on error resume next 
Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
With Retrieval
.Open "Get", url, False, "", "" 
.Send 
GetBody = .ResponseBody 
End With 
Set Retrieval = Nothing 
End Function 


'生成html文件
sub gotoFile(path_html,path_asp)
	'path_asp=Server.MapPath(path_asp)
	'html=getHTTPPage(path_asp)
	html=path_asp
	if len(html)>0 then	
		Set fso=Server.CreateObject("Scripting.FileSystemObject")
		Set htmlwrite=fso.CreateTextFile(Server.MapPath(path_html),true,false)
		htmlwrite.WriteLine(html)
		htmlwrite.close()
	end if
end sub

'检查文件是否存在
function chkFile(path)
    chkFile="no"
    Set fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.FileExists(Server.MapPath(path)) then chkFile="yes"	
    set fso=Nothing
end function

'检查文件夹是否存在，如果不存在，则创建
sub gotoFolder(path)
    Set fso=Server.CreateObject("Scripting.FileSystemObject") 
	'On Error Resume Next	
	path2=Server.MapPath(path)	
	If fso.FolderExists(path2)=false Then	    	
		Set htmlwrite=fso.CreateFolder(path2)
		set htmlwrite=Nothing
	end if	
    set fso=Nothing
end sub
%>