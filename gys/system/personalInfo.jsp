<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%
	Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");	
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户密码修改</title>
<script language="javascript" src="../js/functionlib.js"></script>
<link href="../css/list.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
	function check1(){ 
		if(document.all.form1.PASSWD.value==""){
			alert("新密码不能为空！");
			return;
		}
		if(document.all.form1.PASSWD1.value==""){
			alert("密码确定不能为空!");
			return;
		}
		if(document.all.form1.PASSWD.value != document.all.form1.PASSWD1.value){
			alert("两次输入的密码不一样!");
			document.all.form1.PASSWD.value="";
			document.all.form1.PASSWD1.value="";
			return;
		}
	  	document.form1.action= "../afuer/dataWriter";
		document.form1.submit(); 	
		alert("修改成功！");
		window.close(); 
		return true;
	} 
</script>
<body topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" style="height:100%; background:#FFFFFF" scroll="yes">
<form name="form1" id="form1" method="post" action="">
<input type="hidden" name="dispatchStr" value="../system/personalInfo.jsp">
<input type="hidden" name="tableInfomation" value="noFatherTable:Gb01_yhb">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td background="../images/main-images/gypms_main_blue.png" height="30" valign="top" align="right">
	</td>
  </tr> 
  <tr>
  	<td height="20"></td>
  </tr>
  <tr>
    <td align="center" valign="top">
    	<table width="95%" height="24" border="0" cellpadding="0" cellspacing="0">
    		<tr>
    			<td>
    			<b>用户密码修改</b>
    			</td>
    		</tr>
    		<tr hight="10"></tr>
    		<tr>	
			<table width="100%" height="24" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="99%">
 				    		<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
 				    			<tr>
 				    				<td width ="8"></td>
	 				    			<td>
	 				    			输入新密码：<input type="password" name="PASSWD" value="">
	 				    			<input type="hidden" name="Gb01_yhb.LOGIN_ID" value="<%=yh.getLogin_id() %>"> 
	 				    			<input type="hidden" name="Gb01_yhb.ID" value="<%=yh.getId()%>"> 			 				   
									</td>								
	        					</tr>
	        					<tr>
	        						<td width ="8"></td>
		        					<td>
									确定新密码：<input type="password" name="PASSWD1" value="">
									</td>	
	        					</tr>
	        				</table></td> 
					<td width="1%"></td>
				</tr>
				<tr>
				<td align="center">
    			<input name=button type="button" value=" 提 交 " onclick="check1()">
    			</td>
    			<td>
    			</td></tr>
			</table>							
    		</tr>
    	</table>
    </td>
  </tr>
</table>
</div>
<input type="hidden" name="list_validate" value="姓名:Gb01_yhb.NAME:VARCHAR:30:0;登陆名:Gb01_yhb.LOGIN_ID:VARCHAE:30:0;登陆密码:Gb01_yhb.PASSWD:VARCHAE:30:0;">
</form>
</body>
</html>