<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName" %>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseFormatUtils.*" %> 
<%@ page import="com.netsky.dataObject.Gb05_yhk" %>
<%@ page import="com.netsky.dataObject.Gb01_yhb" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
request.setCharacterEncoding("gb2312");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
Gb05_yhk gb05;
if(request.getParameter("yhk_id") != null){
	gb05 = (Gb05_yhk) queryService.searchById(Gb05_yhk.class,Integer.valueOf(request.getParameter("yhk_id")));	
}else{
	gb05 = new Gb05_yhk();
}
if(request.getParameter("flag") != null && request.getParameter("flag").equals("save")){
	%>
	<script language="javascript">
		opener.window.location.reload();
	</script>
	<%
}
Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
Integer user_id=yh.getId();

%>

<html>

<head>
<title>费率库维护</title>
<link href="../css/main.css" rel="stylesheet">
<script language="javascript" src="../js/functionlib.js"></script>
<script language="javascript">
 function sfgx(obj){
   var objvalue=document.getElementById("GXBZ");
   if(obj.checked)
   {
     objvalue.value=1;
   }else{
     objvalue.value=0;
     alert("0");
   }
 }
</script>
</head>
<body topmargin="0" leftmargin="0" id="main-body">
<div align="center">
	<form name="form1" method="post" action="../afuer/dataWriter">
	  <input type="hidden" name="dispatchStr" value="/system/userclwhEdit.jsp">
	  <input type="hidden" name="perproty" value="yhk_id,Gb05_yhk,ID/flag">
	  <input type="hidden" name="tableInfomation" value="noFatherTable:Gb05_yhk">
	  <input type="hidden" name="flag" value="save">
      <%
      if(gb05.getId() != null){
      %>
      <input type="hidden" name="Gb05_yhk.ID" value="<%=gb05.getId()%>">
      <%
      }else{
      %>
      <input type="hidden" name="Gb05_yhk.ID" value="">
      <%
      }
      %>
	<table width="98%" border="0"  cellspacing="0" cellpadding="0">
		<tr>
	        <td height="21"></td>
        </tr>
        <tr>
	        <td height="40">
		        <table width="100%" height="40" border="0"  cellpadding="0" cellspacing="0">
			        <tr>
				        <td width="10"><img src="../images/main-images/gypms_main_bar_left.gif" width="10" height="40"></td>
			         	 <td valign="bottom" background="../images/main-images/gypms_main_bar_bg.gif">
				        	<table height="30" border="0" cellpadding="0" cellspacing="0">
					                <tr>
					                	<td width="20"><img src="../images/main-images/dot.png" width="18" height="18"></td>
					                	<td width="100"><b>费率库维护</b></td>
					        			</tr>
				        		</table>
			        	</td>
	                	<td align="right" valign="top" background="../images/main-images/gypms_main_bar_bg.gif">
		                	
		                </td>
				         <td width="10"><img src="../images/main-images/gypms_main_bar_right.gif" width="10" height="40"></td>
			        </tr>
		        </table>
	        </td>
        </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" width="98%" id="mainTable">
        <tr>
	        <td align="center" id="main-data" height="70" valign="middle">
				
	        <table border="0" cellpadding="3" cellspacing="0" style="border-collapse:collapse;height:14px;" width="95%">
		        <tr>
					<td colspan="2">&nbsp;</td>
					<input type="hidden" name="CJR_ID" value="<%=user_id.intValue()%>">
					<input type="hidden" name="CJSJ" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %>">
				</tr>
        		<tr>
        			<td width="100" align="right">基础库名称：</td>
        			<td><input type="text" name="MC" value="<%=StringFormatUtil.format(gb05.getMc())%>" class="td-input"></td>
        		</tr>
        		<tr>
        			<td width="100" align="right">库分类：</td>
        			<td>
        				<select name="LB" <%if("xg".equals(request.getParameter("xgbz"))){ %>onbeforeactivate="return false" onfocus="this.blur()" onmouseover="this.setCapture()"   onmouseout="this.releaseCapture()"<%} %>>
						  <option value="">--材料类别--</option>
        				  <option value="ZC" <%if(StringFormatUtil.format(gb05.getLb()).equals("ZC")){out.print("selected");}%>>主材</option>
        				  <option value="SB" <%if(StringFormatUtil.format(gb05.getLb()).equals("SB")){out.print("selected");}%>>设备</option>
        				  <option value="JX" <%if(StringFormatUtil.format(gb05.getLb()).equals("JX")){out.print("selected");}%>>机械</option>
        				  <option value="YB" <%if(StringFormatUtil.format(gb05.getLb()).equals("YB")){out.print("selected");}%>>仪表</option>
        			    </select>
        			</td>
        		</tr>
        		<tr>
        			<td width="100" align="right">是否共享：</td>
        			<td><input type="hidden" id="GXBZ" name="GXBZ" value="<%=StringFormatUtil.format(gb05.getGxbz())%>">
        			<input type="checkbox" name="GXBZxz" value="" onClick="sfgx(this)" <%if("1".equals(StringFormatUtil.format(gb05.getGxbz()))){ %>checked<%} %>></td>
        		</tr>
        		<tr>
        			<td width="100" align="right">备注：</td>
        			<td><input type="text" name="BZ" value="<%=StringFormatUtil.format(gb05.getBz())%>" class="td-input"></td>
        		</tr>
          </table>          
		<table height="30" border="0" cellpadding="0" cellspacing="0" id="form-button">
		  <tr>
		  	<br>
			<td width="5" align="left"><input type="button" name="b2" value=" 保 存 "  onclick="javascript:document.form1.submit();" title="保存对当前文档的修改（新建）"></td>
			<td width="5" align="right"><input type="button" name="b2" value=" 关 闭 "  onclick="javascript:window.close()" title="关闭当前文档" ></td>			
		  	<td width="5" align="center"><br></td>
		  </tr> 
		  <tr>
		  <td width="5" align="center"><br><br><br></td>
		  	
		  </tr>
		</table>
		</td>
        </tr>
    </table>
    </form> 
</div>
</body>

</html>

