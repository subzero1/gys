<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			ServletContext a = session.getServletContext();
			// 从在线列表中删除用户名
			Map onlineUserList = (Map) a.getAttribute("onlineUserList");
			if (onlineUserList != null) {
				Iterator it = onlineUserList.keySet().iterator();
				while (it.hasNext()) {
					Integer key = (Integer) it.next();
					Gb01_yhb gb01 = (Gb01_yhb) onlineUserList.get(key);
					out.print(gb01.getName() + "<br>");
				}
				out.print("游客数:" + (((Integer) a.getAttribute("totalSessions")).intValue() - onlineUserList.size()) + "<br>");
			}
			out.print("总在线人数:" + (Integer) a.getAttribute("totalSessions") + "<br>");
		%>
	</body>
</html>
