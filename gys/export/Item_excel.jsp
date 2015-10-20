<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.ExportService"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.service.PrintService" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.baseFormatUtils.*" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jxl.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>Insert title here</title>
</head>
<body>
<%
	String []results = request.getParameterValues("Cb_bgxd");
	String temp;
   	for (int i=0;i<results.length;i++){//对选中结果进行正序排序
        for (int j=0;j<results.length-i-1;j++){
             if(Integer.valueOf(results[j]).intValue()>Integer.valueOf(results[j+1]).intValue()){
                 temp=results[j];
                 results[j] =results[j+1];
                 results[j+1] =temp;
            }
        }
    }
	String  []dxgc_id = request.getParameterValues("gcxm_print");  
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
	ExportService exportService = (ExportService)ctx.getBean(ServiceName.ExportService); 
	
	String totalPage = "";//request.getParameter("totalPage");
	String gcxm_id = request.getParameter("gcxm_id");
	StringBuffer dxgc_ids =new StringBuffer("");
	for(int m=0;m<dxgc_id.length;m++){
		if(dxgc_id[m]!=null&&dxgc_id[m]!="" && m!=dxgc_id.length-1){
			dxgc_ids.append(dxgc_id[m]);
			dxgc_ids.append(",");
		}
		if(m==dxgc_id.length-1){
			dxgc_ids.append(dxgc_id[m]);
		}
	}
	response.reset();
	response.setContentType("application/vnd.ms-excel;charset=GBK;filename=export.xls");
	jxl.write.WritableWorkbook wwb = Workbook.createWorkbook(response.getOutputStream());
	int total=0;
	total += printService.getHzbTotalpages(Integer.valueOf(gcxm_id),new String(dxgc_ids)).intValue();
	if(results[0].equals("1")){
		jxl.write.WritableSheet hzb = wwb.createSheet("汇总表",0);
		exportService.exportHzbtoExcel(hzb,new Integer(gcxm_id),new String(dxgc_ids),0,new String("HZB"));
	}
	int m=0;
	for(int j=0; j<dxgc_id.length;j++){
			String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id[j];
		    ResultObject ro3 = queryService.search(HSql3);
		    Gd02_dxgc gd=null;
		    String bgxd=null;
		     if(ro3.next()){
		        gd=(Gd02_dxgc)ro3.get("gd02");
		        bgxd=gd.getBgxd();
		     }
		     String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
		     ResultObject ro4 = queryService.search(HSql4);
		     String[] bgxx_bgbh= new String[18];
		     String[] bgxx_bg = new String[18];
		     int[] bgxx_xh=new int[18];
		     for(int k=0;k<18;k++)
		     {
		       bgxx_xh[k]=0;
		     }
		     while(ro4.next())
		     {
		          Gb03_bgxx gb03=null;
		          gb03=(Gb03_bgxx)ro4.get("gb03");
		          bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
		          bgxx_bgbh[gb03.getId().intValue()]=gb03.getDyscbgbh();
		          bgxx_bg[gb03.getId().intValue()]= gb03.getBgbh();
		     }
		     List list=new ArrayList();
		     for(int a=1;a<18;a++){
		     	if(bgxx_xh[a]==a){
		     		list.add(String.valueOf(a));
		     	}
		     }
			String []dxgc_print = (String[])list.toArray(new String[list.size()]);
			
			List finallist = new ArrayList();
			for(int b=0;b<results.length;b++){
				for(int c=0;c<dxgc_print.length;c++){
						if(results[b].equals(dxgc_print[c])){
							finallist.add(results[b]);		
						}
				}
			}
			String []finalresults = (String[])finallist.toArray(new String[finallist.size()]);
			
			String []startPage = new String[17];

   	if(bgxx_xh[2]==2){
   		startPage[1]=String.valueOf(total);
   		total++;
   	}
   	if(bgxx_xh[3]==3){
   		startPage[2]=String.valueOf(total);
   		total += printService.getB2pages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j])).intValue();
   	}
   	if(bgxx_xh[4]==4 ){
   		startPage[3]=String.valueOf(total);
   		total += printService.getB3jTotalpages(new Integer(gcxm_id),new Integer(dxgc_id[j])).intValue();
   	}
   	if(bgxx_xh[5]==5){
   		startPage[4]=String.valueOf(total);
		total += printService.getB3yTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j])).intValue();
   	}
   	if(bgxx_xh[6]==6){
   		startPage[5]=String.valueOf(total);
   		total += printService.getB3bTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j])).intValue();  		
   	}
   	if(bgxx_xh[7]==7){
   		startPage[6]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[7]).intValue();	
   	}
   	if(bgxx_xh[8]==8){
   		startPage[7]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[8]).intValue();   		
   	}
   	if(bgxx_xh[9]==9){
   		startPage[8]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[9]).intValue();
   		  		
   	}
   	if(bgxx_xh[10]==10){
   		startPage[9]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[10]).intValue(); 
   			
   	}
   	if(bgxx_xh[11]==11){
   		startPage[10]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[11]).intValue();  	
   		 		
   	}
   	if(bgxx_xh[12]==12){
   		startPage[11]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[12]).intValue(); 
   		 		
   	}
   	if(bgxx_xh[13]==13){
  	 	startPage[12]=String.valueOf(total);
   		total += printService.getB5jTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j])).intValue();  
 		 		
   	}
   	if(bgxx_xh[14]==14){
   		startPage[13]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[14]).intValue(); 	  		
   	}
   	if(bgxx_xh[15]==15){
   		startPage[14]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[15]).intValue();
   		  		
   	}
   	if(bgxx_xh[16]==16){
   		startPage[15]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[16]).intValue(); 
   			
   	}
   	if(bgxx_xh[17]==17){
   		startPage[16]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id[j]),bgxx_bgbh[17]).intValue();  		
   	}
	if(finalresults!=null){
	for(int i=0;i<finalresults.length;i++){
	if(finalresults[i].equals("2")){
		m++; 
		jxl.write.WritableSheet b1 = wwb.createSheet("表一-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB1toExcel(b1,new Integer(dxgc_id[j]),(new Integer(startPage[1])).intValue(),bgxx_bgbh[2]);
	}else if(finalresults[i].equals("3")){
		m++; 
		jxl.write.WritableSheet b2 = wwb.createSheet("表二-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB2toExcel(b2,new Integer(dxgc_id[j]),(new Integer(startPage[2])).intValue(),bgxx_bgbh[3]);
	}else if(finalresults[i].equals("4")){
		m++; 
		jxl.write.WritableSheet b3j = wwb.createSheet("表三甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB3JtoExcel(b3j,new Integer(dxgc_id[j]),(new Integer(startPage[3])).intValue(),bgxx_bgbh[4]);
	}else if(finalresults[i].equals("5")){
		m++; 
	 	jxl.write.WritableSheet b3y = wwb.createSheet("表三乙-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB3ytoExcel(b3y,new Integer(dxgc_id[j]),(new Integer(startPage[4])).intValue(),bgxx_bgbh[5]);
	}else if(finalresults[i].equals("6")){ 
		m++; 
		jxl.write.WritableSheet b3b = wwb.createSheet("表三丙-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB3btoExcel(b3b,new Integer(dxgc_id[j]),(new Integer(startPage[5])).intValue(),bgxx_bgbh[6]);
	}else if(finalresults[i].equals("7")){
		m++; 
		jxl.write.WritableSheet b4 = wwb.createSheet("国内需要安装设备表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[7],(new Integer(startPage[6])).intValue(),bgxx_bgbh[7]);
	}else if(finalresults[i].equals("8")){
		m++; 
		jxl.write.WritableSheet b4 = wwb.createSheet("国内不需要安装设备表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[8],(new Integer(startPage[7])).intValue(),bgxx_bgbh[8]);	
	}else if(finalresults[i].equals("9")){ 
		m++; 
		jxl.write.WritableSheet b4 = wwb.createSheet("国内备品备件表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[9],(new Integer(startPage[8])).intValue(),bgxx_bgbh[9]);	
    }else if(finalresults[i].equals("10")){
    	m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("国内维护器具表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[10],(new Integer(startPage[9])).intValue(),bgxx_bgbh[10]);
    }else if(finalresults[i].equals("11")){
    	m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("国内主要材料表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[11],(new Integer(startPage[10])).intValue(),bgxx_bgbh[11]);	
    }else if(finalresults[i].equals("12")){
   		m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("国内主要材料附表（表四）甲-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[12],(new Integer(startPage[11])).intValue(),bgxx_bgbh[12]);
    }else if(finalresults[i].equals("13")){
    	m++; 
    	jxl.write.WritableSheet b5 = wwb.createSheet("表五-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB5toExcel(b5,new Integer(dxgc_id[j]),(new Integer(startPage[12])).intValue(),bgxx_bgbh[13]);
    }else if(finalresults[i].equals("14")){ 
    	m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("建筑工程表-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[14],(new Integer(startPage[13])).intValue(),bgxx_bgbh[14]);	
    }else if(finalresults[i].equals("15")){
    	m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("回收设备表-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[15],(new Integer(startPage[14])).intValue(),bgxx_bgbh[15]);
    }else if(finalresults[i].equals("16")){
    	m++; 
    	jxl.write.WritableSheet b4 = wwb.createSheet("回收主材表-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[16],(new Integer(startPage[15])).intValue(),bgxx_bgbh[16]);	
    }else if(finalresults[i].equals("17")){
    	m++; 
   		jxl.write.WritableSheet b4 = wwb.createSheet("国内光电缆设备表-"+StringFormatUtil.format(gd.getGcbh()),m);
		exportService.exportB4toExcel(b4,new Integer(dxgc_id[j]),bgxx_bg[17],(new Integer(startPage[16])).intValue(),bgxx_bgbh[17]);	
    }}}}
	wwb.write();
	wwb.close();
	response.getOutputStream().flush();
	response.getOutputStream().close();
%>
</body>
</html>