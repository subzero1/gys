<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil;"%>
							<%
							ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
                            QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
                            request.setCharacterEncoding("utf-8");
                            String gcxm_id=request.getParameter("gcxm_id");
                            String dxgc_id="1";
                            String print_src="";
							String HSql2="select gd02 from Gd02_dxgc gd02 where gd02.gcxm_id="+gcxm_id;
	  		                ResultObject ro2 = queryService.search(HSql2);
		                    int i=0;
		                    if(ro2.next()){
		                       Gd02_dxgc gd02=(Gd02_dxgc)ro2.get("gd02");
		                       if(gd02!=null){
		                         dxgc_id=gd02.getId().toString();
		                         print_src="print/print.jsp?type=print&dxgc_id="+dxgc_id+"&Cb_bgxd=1&gcxm_id="+request.getParameter("gcxm_id");
		                       }
		                    }
							 %>
<html>
  <head>
    <title></title>
  </head>
  
  <body>
  <table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
  <tr>
    <td align="middle" id="frmTitle" nowrap valign="center" name="frmTitle" height="10%">
      <iframe frameBorder="0" id="top" name="top" scrolling=auto src="shyltop.jsp?gcxm_id=<%=request.getParameter("gcxm_id") %>&dxgc_id=<%=dxgc_id %>" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2" target=data>
      </iframe>
    </td>
</tr>
  <tr>
    <td height="1%"><hr>
    </td>
</tr>
<tr>
    <td style="WIDTH: 100%" bgcolor="#ffffff">
      <iframe frameBorder="0" id="data" name="data" scrolling="yes" src=<%=print_src %> style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1;background:#ffffff">
      </iframe>
    </td>
</tr>
</table>
  </body>
</html>
