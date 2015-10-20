<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<html>
<%
  ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
  QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
  request.setCharacterEncoding("utf-8");
  String gcxm_id=request.getParameter("gcxm_id");
  String user_name=request.getParameter("user_name");
  //String user_name="审核员";
  String HSql1="select gd01 from Gd01_gcxm gd01 where ID='"+gcxm_id+"' and CJR='"+user_name+"'";
  ResultObject ro = queryService.search(HSql1);
  if(ro.next())
  {
      response.sendRedirect("dataManage/projectMain.jsp?gcxm_id="+gcxm_id);
  }else{
      response.sendRedirect("shyl.jsp?gcxm_id="+gcxm_id);
  }
 %>
  <head>
    <title></title>
  </head>
  <body>
  </body>
</html>
