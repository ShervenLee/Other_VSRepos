<div id="login_div">
	<div class="login_div_title">用户登录</div>
    <form action="inc/chk_login.asp" method="post" name="login">
    <table>
  <tbody>
    <tr>
      <td style="text-align:right;" width="25%">用户名：</td>
      <td  width="45%"><input name="user_num" placeholder="用户名" class="input_style"></td>
      <td  width="30%"><a href="?r.html">立即注册</a></td>
    </tr>
    <tr>
      <td style="text-align:right;">密码：</td>
      <td><input type="password" placeholder="密码" name="user_password" class="input_style"></td>
      <td></td>
    </tr>
    <tr>
      <td ></td>
      <td>
      <input type="hidden" name="re_myurl" value="<%=myurl%>">
      <input type="submit" class="submit_style" value="登录"></td>
      <td></td>
    </tr>
  </tbody>
</table>
</form>
<div class="close_logindiv"><img src="img/close1.gif" onMouseOver="this.src='img/close2.gif'" onMouseOut="this.src='img/close1.gif'" title="关闭" onClick="window.document.getElementById('login_div').style.display='none';"></div>
</div>