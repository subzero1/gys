<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.baseObject.*"%>
<html>
	<head>
		<meta http-equiv="Content-Type"
			content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			request.setCharacterEncoding("GBK");
			//String jsgs = "5+([光电缆设备费]*5)*[费率]%+5*4";
			String jsgs = request.getParameter("jsgs");
			String fy = request.getParameter("fy");
			if(jsgs == null)
				jsgs = "";
			if(fy == null)
				fy = "";
			out.print("input jsgs:" + jsgs + "<br/> input fy: " + fy + "<br/>");
			out.print("output:" + Calculator.deleteFy(jsgs, fy));
			new String("123".getBytes("iso-8859-1"),"GBK");
			out.print("123a[费率]b456".replaceAll("\\[费率]","5"));
		%>
		<form method="post">
			计算公式：<input name="jsgs">
			<br/>
			费用：<input name="fy">
			<input type="submit">
		</form>
	</body>
</html>
