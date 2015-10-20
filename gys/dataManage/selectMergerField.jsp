<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%
	String bgxx_id = StringFormatUtil.format(request.getParameter("bgxx_id"),"-1");
	String gcxm_id = StringFormatUtil.format(request.getParameter("gcxm_id"),"-1");
	String dxgc_id = StringFormatUtil.format(request.getParameter("dxgc_id"),"-1");
	String closeFlag = StringFormatUtil.format(request.getParameter("close"),"false");
	if(closeFlag.equals("true"))
		out.println("<script>opener.window.location.reload();window.close();</script>");
%>
<html>
  <head>
    <title></title> 
	<link href="../css/data.css" rel="stylesheet" type="text/css">  
  </head>
  <script type="text/javascript">
  function mm(){
  	document.form1.action="../afuer/ClsbOp?gcxm_id=<%=gcxm_id%>&dxgc_id=<%=dxgc_id%>&bgxx_id=<%=bgxx_id%>&flag=0";
	document.form1.submit(); 
  }
  </script>
  <body>
  <div align="center">
  	<form action="" name="form1" method="post">
    <table width="250">
    	<tr>
    		<td><input type="radio" name="fields" value="bh,dj"/>按编码和单价合并</td>
    	</tr>
    	<tr>
    		<td><input type="radio" name="fields" value="bh,xhgg,dj"/>按编码、型号规格和单价合并</td>
    	</tr>
    	<tr>
    		<td><input type="radio" name="fields" value="bh,mc,xhgg,dj" checked/>按编码、名称、型号规格和单价合并</td>
    	</tr>
    	<tr>
    		<td><input type="radio" name="fields" value="mc,xhgg,dj"/>按名称、型号规格和单价合并</td>
    	</tr>
    	<tr>
    		<td></td>
    	</tr>
    	<tr>
    		<td align="center"><input type="button" name="ok" value=" 确 定 " onclick="mm()">&nbsp;&nbsp;<input type="button" name="cancle" value=" 取 消 " onclick="window.close();"></td>
    	</tr>
    </table>
    </form>
   </div>
  </body>
</html>
