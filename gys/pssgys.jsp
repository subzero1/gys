<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.listener.LoginListener"%>
<html>
  <head>
    
    <title></title>

  </head>
  
  <body>
    <%
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
    QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
    String gcxm_id = request.getParameter("gcxm_id");
    String dxgc_id = request.getParameter("dxgc_id");
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
    	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb01_yhb.class);
		queryBuilder.eq("id",new Integer(0));
		ResultObject ro = queryService.search(queryBuilder);
		if (ro.next()) {
			Gb01_yhb yhb = (Gb01_yhb) ro.get(Gb01_yhb.class.getName());
			//HttpSession session = request.getSession();
			session.removeAttribute("LoginListener");
			session.setAttribute("yhb", yhb);
			session.setAttribute("LoginListener", new LoginListener(yhb));
		}
		response.sendRedirect("dataManage/projectMain.jsp?dxgc_id="+dxgc_id+"&gcxm_id="+gcxm_id);
    }else{
    	response.sendRedirect("dataManage/projectMain.jsp?dxgc_id="+dxgc_id+"&gcxm_id="+gcxm_id);
    }
     %>
  </body>
</html>
