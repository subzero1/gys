<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.netsky.service.*"%>
<%@ page import="com.netsky.service.impl.*"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.baseFormatUtils.StringFormatUtil" %>
<%
	String gysgcid = StringFormatUtil.format(request.getParameter("gysgcid"),"-1");
	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);

	CalculateService cs = new CalculateServiceImpl();
	ExpenseService es = new ExpenseServiceImpl();

	String sHead = "<script>",sFoot = "</script>";
	Gd02_dxgc dxgcInfo = null;
	ResultObject rs = queryService.search("select gd02 from Gd02_dxgc gd02 where gcxm_id="+gysgcid);
	try{
		while(rs.next()){
			dxgcInfo = (Gd02_dxgc)rs.get("gd02");
			es.insertGd03(dxgcInfo);
			es.insertGd04(dxgcInfo);
			es.insertGd10(dxgcInfo, request);
			cs.B3Calculate(dxgcInfo.getId(), dxgcInfo.getGcxm_id());
			cs.B3yCalculate(dxgcInfo.getId(), dxgcInfo.getGcxm_id());
			cs.B3bCalculate(dxgcInfo.getId(), dxgcInfo.getGcxm_id());
			cs.B4Calculate(dxgcInfo.getGcxm_id(), dxgcInfo.getId(), new Integer(7));
			cs.B4Calculate(dxgcInfo.getGcxm_id(), dxgcInfo.getId(), new Integer(11));
			cs.Calculate(dxgcInfo.getId());
		}
		out.println(sHead+"alert('导入成功');"+sFoot);
	}catch(Exception e){
		out.println(sHead);
		out.println("parent.alert('导入失败: "+e.getMessage()+"');");
		out.println(sFoot);
	}
%>