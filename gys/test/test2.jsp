<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.dataObject.*"%>
<%@ page import="com.netsky.service.*"%>
<%@ page import="com.netsky.baseObject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			Object o = Class.forName("com.netsky.dataObject.TestObject").newInstance();
			Object o2 = Class.forName("com.netsky.dataObject.TestObject2").newInstance();
			TestObject t = (TestObject) o;
			TestObject2 t2 = (TestObject2) o2;
			t.setId(new Integer(1));
			
			PropertyInject.inject(request,t,0);
			out.print(t.getId());
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			SaveService saveService = (SaveService) ctx.getBean(ServiceName.SaveService);
			saveService.save(t);
		%>
	</body>
</html>
