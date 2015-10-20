<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%
  	  	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	    QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	    
	  	String user = request.getParameter("loginID");
		//String pass = request.getParameter("password");
		
	  	String HSql1="select gb01 from Gb01_yhb gb01 where login_id='"+user+"'";
	  	ResultObject ro = queryService.search(HSql1);
	  	if(ro.next())
	  	{
	  	  Gb01_yhb yhb=(Gb01_yhb)ro.get("gb01");
	  	  session.setAttribute("yhb",yhb);
	  	  //response.sendRedirect("gSession.jsp");
	  	}else{
	  	  //response.sendRedirect("loginError.jsp?cwbz=1");
	  	}

		//QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		//queryBuilder.eq("login_id", user);
		//queryBuilder.eq("passwd", pass);
		//ResultObject ro = queryService.search(queryBuilder);
 %>
<html>
  <head>
    <title></title>
  </head>
  <body>
  </body>
  <script language='javascript'>
	var webLoad = true;	
</script>
</html>
