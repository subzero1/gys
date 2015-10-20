<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.ExportService"%>
<%@ page import="java.io.*"%>
<%@ page import="jxl.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<%
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
ExportService exportService = (ExportService)ctx.getBean(ServiceName.ExportService);
response.reset();
response.setContentType("application/vnd.ms-excel;charset=GBK;filename=export.xls");
jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws0 = wwb.createSheet("汇总表",0);
//exportService.exportHzbtoExcel(ws0,new Integer(1321),null,1,1);
jxl.write.WritableSheet ws = wwb.createSheet("表二",1);
jxl.write.WritableSheet ws1 = wwb.createSheet("表三甲",1);
jxl.write.WritableSheet ws2 = wwb.createSheet("表三乙",2);
jxl.write.WritableSheet ws5 = wwb.createSheet("表三丙",2);
jxl.write.WritableSheet ws6 = wwb.createSheet("表一",2);
jxl.write.WritableSheet ws3 = wwb.createSheet("表四",2);
//exportService.exportB2toExcel(ws,new Integer(1781),1,1);
//exportService.exportB3JtoExcel(ws1,new Integer(141));
//exportService.exportB3ytoExcel(ws2,new Integer(2182));
////exportService.exportB3btoExcel(ws5,new Integer(2182));
//exportService.exportB1toExcel(ws6,new Integer(2182));
//exportService.exportB4toExcel(ws3,new Integer(1781),"B4ZC",1,1);
//jxl.write.WritableSheet ws4 = wwb.createSheet("表五",3);
//exportService.exportB5toExcel(ws4,new Integer(1781),1,1);
wwb.write();
wwb.close();
response.getOutputStream().flush();
response.getOutputStream().close();
%>
</body>
</html>