<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<html>
  <head>
    <title>My JSP 'gSession.jsp' starting page</title>
  </head>
  <body>
  ��Ԥ��ϵͳ<br>
  <% 
  	String v = request.getParameter("v");
	String mi = request.getParameter("mi");
	if(v == null) v="0";
	if(mi == null) mi="15";
	
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      out.println("���û���");
      return;
    }else{
      out.println("�û�����"+yh.getName());
      out.println("�û�����"+yh.getLogin_id());
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
	  ˢ�£�<%=v%>��<br>
	  ���ʱ�䣺<%=mi%>����
  </body>
</html>
