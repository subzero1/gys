<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.dataObject.*"%>
<%@ page import="com.netsky.service.*"%>
<%@ page import="com.netsky.baseObject.*"%>
<html>
	<head>
		<title>∏≈‘§À„≤‚ ‘</title>
	</head>
	<body>
		<%
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			SaveService saveService = (SaveService) ctx.getBean(ServiceName.SaveService);
			Object o[] = new Object[2];
			TestObject t = new TestObject();
			t.setText("123");
			o[0] = t;
			TestObject t2 = new TestObject();
			t2.setText("123456");
			o[1] = t2;
			saveService.save(o);
		%>
		<form action="/gys/afuer/save" method="post">
			<input name="text" value="">
			<input type="submit" value="±£¥Ê">
		</form>
	</body>
</html>
