<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<html>
  <head>
    <title></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">    
<script laguage="javascript">
  
  function bgsd(obj_bg)
  {
    var Cb_bgxd=obj_bg.value;
    var dxgc_id=<%=request.getParameter("dxgc_id")%>;
    window.parent.data.location="print/print.jsp?type=print&dxgc_id="+dxgc_id+"&Cb_bgxd="+Cb_bgxd+"&gcxm_id=<%=request.getParameter("gcxm_id")%>";
  }
</script>
<base target="data"/>
  </head>
  
  <body>
  	<%
							ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
                            QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
                            request.setCharacterEncoding("utf-8");
                            String dxgc_id=request.getParameter("dxgc_id");
                            String gcmc="";
                            
                            String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
	                        ResultObject ro3 = queryService.search(HSql3);
	                        Gd02_dxgc gd=null;
	                        String bgxd=null;
	                        if(ro3.next()){
	                           gd=(Gd02_dxgc)ro3.get("gd02");
	                           bgxd=gd.getBgxd();
	                           gcmc=gd.getGcmc();
	                        }
			                %>
    <table><tr>
    <td>工程名称：</td>
    <td><%=gcmc %></td>
    <td>选择表格：</td>
    <td>
    <select size="1" name="xzbg" id="xzbg" onchange="bgsd(this)">
    <option value="1" selected>汇总表</option>	
    <%
                            
	                        String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
	                        ResultObject ro4 = queryService.search(HSql4);
	                        Gb03_bgxx gb03=null;
		                    while(ro4.next()){
		                    gb03=(Gb03_bgxx)ro4.get("gb03");
			                if(gb03!=null){ 
     %>
							<option value="<%=gb03.getId() %>" <%if(gb03.getId().toString().equals("1")){ %>selected <%} %>><%=gb03.getMc() %></option>	
	<%}} %>
	</select>
    </td>
    </tr></table>
  </body>
</html>
