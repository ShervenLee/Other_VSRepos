<!-- #include file="inc/conn-bbs.asp" -->
<!-- #include file="inc/myurl.asp" -->
<%

title=bbsset_sitename
board_name=""
select case left(myurl,1)
	case "p"		
		sql="select * from BBS_Topic where topic_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then
			topic_title=rs("topic_title")
			board_id=rs("board_id")
		end if
		topic_title=left(topic_title,25)
		sql="select board_name from BBS_Board where board_id="& board_id &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=topic_title		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		title=title&"-"&bbsset_sitename
		where_now=" > <a href=?b"& board_id &".html>"&board_name&"</a> > <span>"& topic_title &"</span>"
		goto_file="page"
	case "b"
		sql="select board_name from BBS_Board where board_id="& topic_no &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_name=rs(0)
		title=board_name		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>"&board_name&"</span>"
		goto_file="board"
	case "u"		
		board_name=chk_db("BBS_User","user_id",topic_no,"user_name")		
		title=board_name&" ������"		
		if page_no>1 then title=title&"-��"& page_no &"ҳ"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>"&board_name&" ������</span>"
		goto_file="board"
	case "n"	
		title="����������"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>����������</span>"
		goto_file="post"
	case "r"	
		title="ע���»�Ա"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>ע���»�Ա</span>"
		goto_file="reg"
	case "e"	
		title="�޸Ļ�Ա����"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>�޸�����</span>"
		goto_file="edit_userinfo"
	case "z"	
		title="�༭����"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>�༭����</span>"
		goto_file="edit_topic"
	case "h"	
		title="�༭�ظ�"
		title=title&"-"&bbsset_sitename
		where_now=" > <span>�༭�ظ�</span>"
		goto_file="edit_replay"
	case else
		goto_file="main"
end select

%>
<!doctype html>
<html>
<head>
<meta charset="gb2312">
<link rel="stylesheet" type="text/css" href="inc/index.css"/>
<title><%=title%></title>


<div class="css_top" style="background-color:#f2f2f2; border-bottom:1px #cdcdcd solid; ">
	<div class="css_top_div">
 		<div class="css_top_title" style="color:#333;">
            asp+access��Դ����̳
        </div> 

	</div>	
</div>



<div class="css_top_blank">
    <div class="css_top_blank2">
        <div class="css_top_logo"  style="padding-top:15px;">
            <a href="/" title="��ҳ"><img src="img/logo.png" alt="��ҳ"></a>

            
        </div>
        <div>
        <div style="float:right; width:30%; padding-top:20px; padding-bottom:20px;">
        <!-- #include file="main/user_state.asp" -->

        </div>
        </div>
    </div>
</div>


<div class="page_single_top">
    <ul>
        <li><a href="/">��̳��ҳ</a></li>
        <li><a href="http://www.cnw6.com/cnw6/bbs/" target="_blank">С����̳</a></li>
        <li><a href="http://www.cnw6.com/" target="_blank">ֱ�����</a></li>

    </ul>
</div>









<div class="page_single_main">
	<div class="page_single_main_div">
        
<div style="float:left"><div class="page_single_main_title"><a href="<%=BBS_folder%>"><%=bbsset_sitename%></a><%=where_now%></div></div>
        <div class="page_single_content">        	
			<div class="bbs_content">
			
			<%server.execute("main/"&goto_file&".asp")%>
            
            </div>
        </div>
    </div>
</div>

<!-- #include file="main/login.asp" -->





<div class="css_end_3">
    <ul>


 
        <li>Powered by <a href="http://www.cnw6.com/cnw6/bbs/" target="_blank">С����̳</a> v1.0</li>  
        <li><a href="http://www.cnw6.com/" target="_blank" title="ֱ�����">ֱ�����</a></li>  
                <li style=" margin-bottom:20px; clear:both;">
        	
        </li>
         
    </ul>
</div>



</bod></html>