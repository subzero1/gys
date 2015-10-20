<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<html>
  <head>
    <title>My JSP 'gSession.jsp' starting page</title>
  </head>
  <body>
  概预算系统<br>
  <% 
  	String v = request.getParameter("v");
	String mi = request.getParameter("mi");
	if(v == null) v="0";
	if(mi == null) mi="15";
	
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      out.println("无用户！");
      return;
    }else{
      out.println("用户名："+yh.getName());
      out.println("用户名："+yh.getLogin_id());
 %>
	  <script language='javascript'>
		var v = <%=v%>;
		var mi = <%=mi%>;
		var ms = mi * 60000;
		
		function rf(){
			v++;
			mi = mi+5;
			window.location.href="gSession.jsp?v=" + v + "&mi=" + mi;
		}
		
		var n=setTimeout("rf()",ms);
	   </script>
 <%
    }
    
 %>
  <br>
	  刷新：<%=v%>次<br>
	  间隔时间：<%=mi%>分钟
  </body>
</html>
