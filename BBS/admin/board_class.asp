<!-- #include file="../inc/conn-bbs.asp" -->
<!-- #include file="checksession.asp" -->
<!-- #include file="fun-admin.asp" -->
<%
page_no=chk_num(trim_fun(request("page_no")))
mydo=trim_fun(request("mydo"))
modid=chk_num(trim_fun(request("modid")))
board_name=trim_fun(request("board_name"))
board_demo=trim_fun(request("board_demo"))
board_belong=chk_num(trim_fun(request("board_belong")))
see_level=chk_num(trim_fun(request("see_level")))
if see_level<=0 then see_level=1
see_belong=chk_num(trim_fun(request("see_belong")))
select case mydo
	case "del"
		call dperror(modid=0,"��ȡ�����Ϣ���������µ�¼���ٲ���","")	
		sql="select * from BBS_Board where board_belong="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(not rs.eof,"�ð������¼���飬����ɾ���¼�����ٲ���","?see_level=1")
		sql="select * from BBS_Topic where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(not rs.eof,"�ð����ڲ�Ʒ������ɾ����Ʒ�ٲ���","?see_level=1")
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror(rs.eof,"��ȡ���������µ�¼�����","?see_level=1")
		board_belong=chk_num(rs("board_belong"))
		rs.delete
		rs.update
		call dperror(true,"ɾ���ɹ�","?see_belong="&board_belong)
	case "addok"
		call dperror(len(board_name)=0 or isnull(board_name),"������Ʋ���Ϊ��","?see_level=1")
		board_level=0
		sql="select * from BBS_Board where board_id="& board_belong &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_level=rs("board_level")
		board_level=chk_num(board_level)+1
		board_id=0
		sql="select max(board_id) from BBS_Board"
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_id=rs(0)
		board_id=chk_num(board_id)+1
		sql="select * from BBS_Board where board_name='"& board_name &"' and board_level="& board_level &" and board_belong="& board_belong &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror(not rs.eof,"�����������ͬ������","")		
		rs.addnew
			rs("board_name")=board_name
			rs("board_demo")=board_demo			
			rs("board_level")=board_level
			rs("board_belong")=board_belong
			rs("board_id")=board_id
		rs.update
		call dperror(true,"��ӳɹ�","?see_belong="&board_belong)
	case "modok"
		call dperror(modid=0,"��ȡ�����Ϣ���������µ�¼���ٲ���","")			
		call dperror(len(board_name)=0 or isnull(board_name),"������Ʋ���Ϊ��","?see_level=1")
		board_level=0
		sql="select * from BBS_Board where board_id="& board_belong &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then board_level=rs("board_level")
		board_level=chk_num(board_level)+1
		sql="select * from BBS_Board where board_name='"& board_name &"' and board_level="& board_level &" and board_belong="& board_belong &" and board_id<>"& modid &""
		set rs=bbsconn.execute(sql)
		call dperror(not rs.eof,"�����������ͬ������","")
		
		old_board_belong=0
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=bbsconn.execute(sql)
		if not rs.eof then old_board_belong=rs("board_belong")
		if board_belong<>chk_num(old_board_belong) then
			sql="select * from BBS_Board where board_belong="& modid &""
			set rs=bbsconn.execute(sql)
			call dperror(not rs.eof,"�ð������¼���飬����ɾ���¼�����ٸı��������","?see_level=1")
			sql="select * from BBS_Topic where board_id="& modid &""
			set rs=bbsconn.execute(sql)
			call dperror(not rs.eof,"�ð����ڲ�Ʒ������ɾ����Ʒ�ٲ���","?see_level=1")
		end if
		
		sql="select * from BBS_Board where board_id="& modid &""
		set rs=server.CreateObject("adodb.recordset")
		rs.open sql,bbsconn,1,3
		call dperror(rs.eof,"��ȡ�����Ϣ���������µ�¼���ٲ���","")
			rs("board_name")=board_name
			rs("board_demo")=board_demo	
			rs("board_belong")=board_belong
			rs("board_level")=board_level
		rs.update
		call dperror(true,"�޸ĳɹ�","?see_belong="&board_belong)
end select

%>

<html>
<head>
<title>������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


	<link href="../inc/wdiii/common.css" rel="stylesheet">
   <link href="../inc/wdiii/table.css" rel="stylesheet">
   <script src="../inc/wdiii/index.js" type="text/javascript"></script>


</head>

<body>

<div class="table-topmenu" >

    <div class="table-topmenu-left">
      <%
	max_board_level=0
	sql="select max(board_level) from BBS_Board"
	set rs=bbsconn.execute(sql)
	if not rs.eof then max_board_level=rs(0)
	max_board_level=chk_num(max_board_level)
	for for_i=1 to max_board_level
	%>
    <A href="?see_level=<%=for_i%>" class="btn <%if see_level=for_i then %>btn-gray<%else%>btn-gray2<%end if%>" >��<%=for_i%>����</A>
	<%
	next
	%>
    	
 
    
    </div>
    
    <div class="table-topmenu-right">
    
<A href="?mydo=add&board_belong=<%=see_belong%>" class="btn btn-success" title="�����°��">�°��</A>
    </div>
    
</div>

<%
select case mydo
case "mod","add"
	mydohtml="����"
	if mydo="mod" then
		call dperror(modid=0,"��ȡ�����Ϣ���������µ�¼���ٲ���","")
		sql="select * from BBS_Board where board_id="& modid &""		
		set rs=bbsconn.execute(sql)
		call dperror(rs.eof,"��ȡ�����Ϣ���������µ�¼���ٲ���","")
		board_name=rs("board_name")
		board_demo=rs("board_demo")
		board_id=chk_num(rs("board_id"))
		board_belong=chk_num(rs("board_belong"))
		board_level=chk_num(rs("board_level"))
		mydohtml="�޸�"
	end if
	%>
	<form action="?mydo=<%=mydo%>ok&modid=<%=modid%>" name="form1" method="post">
   <table class="table table-bordered table-hover table-responsive">
   <thead>
        <tr> 
        	<th colspan="2"><%=mydohtml%>���</th>
        </tr>
    </thead>
        <tr> 
            <td><div align="right">�������:&nbsp;</div></td>
            <td><div align="left">
              &nbsp;<input class="form-control" name="board_name" value="<%=board_name%>">
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">�������:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<select class="form-control" name="board_belong">
                         <option value="0"  >�������</option>
						 <%call dis_shopclass(0,board_belong)%>                         
                     </select>
            </div></td>
        </tr>
        <tr> 
            <td><div align="right">���:&nbsp;</div></td>
            <td><div align="left">
             &nbsp;<textarea class="input_style" name="board_demo" style="  color:#000; width:50%; margin:auto; height:200px;"><%=board_demo%></textarea>
            </div></td>
        </tr>
       
			<tr> 
            <td></td>
            <td style="text-align:left;">
           <input type="submit" class="btn btn-primary" value="ȷ��">
            </td>
        </tr>
    		<tr><th colspan="2"></th></tr>
     </table>
				</form>
<%
case else
%>
	<table class="table table-bordered table-hover table-responsive">
    <thead>
          <tr>
            <th width="5%">���</th> 
            <th width="15%">�������</th>
            <th width="30%" style="text-align:left;">���</th>
            <th width="10%">��������</th>            
            <th width="10%">�������</th>
            <th width="10%">��鼶��</th>
            <th width="20%">����</th>
          </tr>
        </thead>
<%loop_i=chk_num(see_level)

call dis_class_table(see_level,see_belong,1)%>
    		<tr><th colspan="8">
            <ul class="pagination"><%=bbs_page_no(page_no,pagecount,"see_level="& see_level &"&see_belong="&see_belong)%></ul>
            </th></tr>
</table>
<%end select%>
</body>
</html>
<%

sub dis_class_table(see_level,see_belong,dis_type)
		  dim sql,rs,board_belong
		  sql="select * from BBS_Board where 1=1"
		  select case true
			  case see_belong>0
			  	sql=sql&" and board_belong="& see_belong &""
		  case see_level>0
			  	sql=sql&" and board_level="& see_level &""
		  end select
		  sql=sql&" order by id asc"
		  
		  set rs=server.CreateObject("adodb.recordset")
		  rs.open sql,bbsconn,1,3
		  i=1	  
		  page_size=10
			if rs.eof then
				if dis_type=1 then%>
					<tr> 
						<td colspan="7">
							���ް��                    
						</td>
				   </tr>
			   <%end if
	 		 else
				rs.PageSize=page_size
				pagecount=rs.PageCount '��ȡ��ҳ�� 
				if page_no<=0 then page_no=1 '�ж� 
				if page_no>pagecount then page_no=pagecount
				rs.AbsolutePage=page_no '���ñ�ҳҳ�� 
				allRecordCount=rs.RecordCount
				
			end if				
		  do while not rs.eof
		  		board_id=rs("board_id")
		  		board_name=rs("board_name")
				board_demo=rs("board_demo")
				board_belong=chk_num(rs("board_belong"))
				board_level=chk_num(rs("board_level"))
				if loop_i=0 then loop_i=board_level
				board_belong_html=""
				board_belong_board_id=0
				if board_belong>0 then
					sql_belong="select * from BBS_Board where board_id="& board_belong &""
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then
						board_belong_html=rs_belong("board_name")
						board_belong_board_id=rs_belong("board_id")
					end if
				end if
				board_belong_board_id_2=0
				if board_belong_board_id>0 then
					sql_belong="select * from BBS_Board where board_id="& board_belong_board_id &""
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then
						board_belong_board_id_2=rs_belong("board_belong")
					end if
				end if
				board_belong_board_id_2=chk_num(board_belong_board_id_2)


				'ͳ��ȫ���ж��ٸ���������
				have_board_belong=0
					sql_belong="select count(id) from BBS_Topic where board_id in (select board_id from BBS_Board where board_id="& board_id &" or  board_id in ("& dis_allmyclass(board_id) &"))"
					if chk_num(session("is_dl"))>0 then sql_belong=sql_belong&" and pro_dlid="& session("hyid") &""
					set rs_belong=bbsconn.execute(sql_belong)
					if not rs_belong.eof then have_board_belong=rs_belong(0)
					have_board_belong=chk_num(have_board_belong)
				
					

if mydo<>"mod" and mydo<>"add" then
name_nbsp=""

temp_i=board_level-loop_i
for dis_i=1 to temp_i
	name_nbsp=name_nbsp&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
next

temp_count_1=have_board_belong

%>
<tr <%if dis_type=2 then%> style="background-color:#ccc;" <%end if%> >
    <td><%if dis_type=1 then%><%=i+(page_no-1)*page_size%><%end if%></td> 
    <td><a href="?see_belong=<%=board_id%>" title="[<%=board_name%>]���¼����"><%=board_name%></a>
    </td>
    <td style="text-align:left; line-height:20px; color:#666;"><%=board_demo%>
    </td>
    <td>
    	<%=temp_count_1%>
    
    </td>

    <td>
		<%if see_belong<>board_belong_board_id then%>
        	<a href="?see_belong=<%=board_belong_board_id%>" title="[<%=board_belong_html%>]���¼����"><%=board_belong_html%></a>
        <%else%>
        	<%=board_belong_html%>
        <%end if%>	
    </td>
    <td>
    <%if len(board_belong_html)>0 then%>
        <a href="?see_belong=<%=board_belong_board_id_2%>" title="[<%=board_belong_html%>]���ϼ����">��<%=board_level%>��</a>
    <%else%>
        ��<%=board_level%>��
    <%end if%>
    
								
    </td>
    <td>
       
                      
        <a href="?mydo=mod&modid=<%=board_id%>" class="btn btn-warning" title="�޸ı����">�޸�</a>
        <a href="?mydo=del&modid=<%=board_id%>" class="btn btn-danger" onClick="return makesure('����ɾ���ð�飬�Ƿ������');" title="ɾ�������">ɾ��</a>
        
    </td>               
</tr>
<%
end if
				  'if i>=page_size and dis_type=1 then exit do
				  i=i+1
				  'call dis_class_table(0,board_id,2)
				  rs.movenext
		  loop
		  
end sub
















'�г��÷����������з���ID,
function dis_allmyclass(board_id)
	dim count,sql_class,rs_class,this_board_id
	count=""
	sql_class="select * from BBS_Board where board_belong="& board_id &""
	set rs_class=bbsconn.execute(sql_class)
	do while not rs_class.eof
		this_board_id=rs_class("board_id")
		count=count&this_board_id&","
		count=count&dis_allmyclass(this_board_id)&","
		rs_class.movenext
	loop
	dis_allmyclass=count&board_id&","
	if right(dis_allmyclass,1)="," then dis_allmyclass=replace(dis_allmyclass&"+",",+","")
end function

'��ʾ����
sub dis_shopclass(board_id,board_belong)
	sql_belong="select * from BBS_Board where board_belong="& board_id &" and board_id<>"& board_id &""
	set rs_belong=bbsconn.execute(sql_belong)
	do while not rs_belong.eof
		board_name_1=rs_belong("board_name")
		board_id_1=chk_num(rs_belong("board_id"))
		board_level=chk_num(rs_belong("board_level"))
		board_level_html=""
		for loop_i=2 to board_level
			board_level_html=board_level_html&"&nbsp;&nbsp;&nbsp;&nbsp;"
		next
		%><option value="<%=board_id_1%>" <%if board_belong=board_id_1 then%> selected <%end if%> ><%=board_level_html%><%=board_name_1%></option><%
		call dis_shopclass(board_id_1,board_belong)
		rs_belong.movenext
	loop
end sub
%>
