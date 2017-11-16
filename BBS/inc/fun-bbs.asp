<%
'显示多久前访问的时间
Function howlong(This_time)
	howlong=""
	if len(This_time)>0 then
		cp_second=datediff("s",This_time,now())
		cp_day=datediff("d",This_time,now())
		displaytemp1=" "&right("00"&hour(This_time),2)&":"&right("00"&minute(This_time),2)
		displaytemp2=month(This_time)&"月"&day(This_time)&"日"
		'response.Write(cp_second)
		'response.End()
		select case true
			case cp_second<0
				howlong="时间格式错误"
			case cp_second<=5
				howlong="刚刚"
			case cp_second<60
				howlong=cp_second&"秒钟前"
			case cp_second<3600
				howlong=int(cp_second/60)&"分钟前"
			case cp_day=0
				howlong="今天"&displaytemp1
			case cp_day=1
				howlong="昨天"&displaytemp1
			case year(This_time)=year(now())
				howlong=displaytemp2&displaytemp1
			case else
				howlong=year(This_time)&"年"&displaytemp2&displaytemp1
		end select
	end if
end Function


'显示分页
function bbs_page_no(page_no,page_end,page_url)
	
	page_end=chk_num(page_end)
	if page_end=0 then page_end=1
	page_no=chk_num(page_no)
	if page_no=0 then page_no=1
	if page_end>1 then
		if len(page_url)=0 then page_url=left(myurl,1)
		
		bbs_page_no=bbs_page_no&"<li><a href=""?"& page_url & topic_no &".html"" title=""返回首页"">首页</a></li>"
		bbs_page_no=bbs_page_no&"<li><a href=""?"& page_url & topic_no &"-"& page_no-1 &".html"" title=""上一页""><</a></li>"
		loop_star=page_no-6
		if loop_star<1 then loop_star=1
		loop_end=page_no+6
		if loop_end>page_end then loop_end=page_end
		if loop_star>1 then bbs_page_no=bbs_page_no&"<li><a href=""?"& page_url & topic_no &".html"" title=""第1页"">1</a></li><li><a>…</a></li>"
		for page_i=loop_star to loop_end
			bbs_page_no=bbs_page_no&"<li"
			if page_i=page_no then bbs_page_no=bbs_page_no&" class=""active"""
			bbs_page_no=bbs_page_no&"><a href=""?"& page_url & topic_no &"-"& page_i &".html"" title=""第"& page_i &"页"" >"& page_i &"</a></li>"
		next	
		
		if loop_end<page_end then bbs_page_no=bbs_page_no&"<li><a>…</a></li><li><a href=""?"& page_url &"&page_no="& page_end &".html"" title=""第"& page_end &"页"">"& page_end &"</a></li>"	
		bbs_page_no=bbs_page_no&"<li><a href=""?"& page_url & topic_no &"-"& page_no+1 &".html"" title=""下一页"">></a></li>"
		bbs_page_no=bbs_page_no&"<li><a href=""?"& page_url & topic_no &"-"& page_end &".html"" title=""最后一页"">尾页</a></li>"	
	end if	
end function



'读取数据库某一个字段，读取的参数必须是数字类型，如ID
function chk_db(db_name,chk_num1,chk_num2,chk_num3)
	sql4="select "& chk_num3 &" from "& db_name &" where "& chk_num1 &"="& chk_num2 &""
	set rs4=bbsconn.execute(sql4)
	chk_db=""
	if not rs4.eof then chk_db=rs4(chk_num3)
	set rs4=nothing
end function



'正则替换所有html代码
function RegExphtml(html)
RegExphtml=html
if len(RegExphtml)>0 then
set reg = new RegExp 
reg.IgnoreCase = True
reg.Global = True 
'过滤全部HTML代码 
reg.Pattern = "<[^>]*>" 
RegExphtml = reg.Replace(RegExphtml,"")
set reg=nothing
RegExphtml=replace(RegExphtml," ","")
RegExphtml=replace(RegExphtml,"&nbsp;","")
RegExphtml=replace(RegExphtml,CHR(13),"")
RegExphtml=replace(RegExphtml,CHR(10),"")
RegExphtml=replace(RegExphtml,CHR(32),"")
RegExphtml=replace(RegExphtml,CHR(9),"")
RegExphtml=replace(RegExphtml,CHR(34),"")

end if
end function


'过滤输入的字符
function trim_fun(fString)
	if isnull(fString) then
		trim_fun=""
	else
		fString=trim(fString)
		fString=replace(fString,"'","''")
		fString=replace(fString,";","；")
		fString=replace(fString,"--","—")
		fString=server.htmlencode(fString)
		trim_fun=fString
	end if
end function
'显示错误信息
function dperror(iffalse,disinfo,goto_url)
	'如果前面的条件为真,则显示后面的错误信息
	if len(goto_url)=0 or isnull(goto_url) then
		goto_url="window.history.back();"
	else
		goto_url="window.location.href='"& goto_url &"';"
	end if
	if iffalse=true then
		response.write"<SCRIPT language=JavaScript>alert('"& disinfo &"！');"& goto_url &"</script>"
		response.end
	end if
end function
'显示错误信息

'检查是否是数字
function chk_num(num)
	if len(num)=0 or isnull(num) then
		chk_num=0
	else
		chk_num=cdbl(num)
	end if
end function
%>