<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.dataObject.*"%>
<%@ page import="com.netsky.service.*"%>
<%@ page import="com.netsky.baseObject.*"%>
<%
String HSql = "select ga08 from Ga08_flmx ga08 left outer join Ga07_qfqj ga07 on ga08.qj_id=ga07.id";
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
ProjectService projectService = (ProjectService)ctx.getBean(ServiceName.ProjectService);
//out.print(projectService.copyProject(new Integer(1101),null,"copyProjectTest"));
%>