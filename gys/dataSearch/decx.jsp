<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>定额库查询条件</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <frameset rows="23%,*">
 <frame noresize="noresize" src="dataSearch/query.jsp" name="Frame" id="Frame" title="Frame"  scrolling="no" />
 <frame noresize="noresize" src="dataSearch/display.jsp"  name="mainFrame" id="mainFrame" title="mainFrame" />
  </frameset>
<noframes><body>
</body>
</noframes></html>
  



