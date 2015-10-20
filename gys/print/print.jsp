<?xml version="1.0" encoding="GB2312"?>
<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.service.PrintService" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc" %>
<%@ page import="com.netsky.dataObject.Gb03_bgxx" %>
<%@ page import="com.netsky.baseObject.*" %>
<%@ page import="java.util.*" %>
<%
	List list = new ArrayList();
	if(request.getParameter("xx")==null){
		String  []results = request.getParameterValues("Cb_bgxd"); 
		for(int i=0;i<results.length;i++){
			list.add(results[i]);
		}
	}else{
		String xx=request.getParameter("xx");
		String []results  = new String[(xx.split(",")).length];
		for(int i = 0; i < results.length; i++){
			results[i] = String.valueOf(xx.split(",")[i]);
		}
		for(int i=0;i<results.length;i++){
			list.add(results[i]);
		}
	}
	String []results = (String[])list.toArray(new String[list.size()]);
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
	if (request.getParameter("type") != null && request.getParameter("type").equals("print")) {
		%>
		<?xml-stylesheet type="text/xsl" href="printCss.xsl"?>
		<%
	}
	String []startPage = new String[17];
	String totalPage = "";//request.getParameter("totalPage");
	String gcxm_id = request.getParameter("gcxm_id");
	String dxgc_id = request.getParameter("dxgc_id");
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
	String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
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
     for(int j=0;j<18;j++)
     {
       bgxx_xh[j]=0;
     }
     while(ro4.next())
     {
          Gb03_bgxx gb03=null;
          gb03=(Gb03_bgxx)ro4.get("gb03");
          bgxx_xh[gb03.getId().intValue()]=gb03.getId().intValue();
          bgxx_bgbh[gb03.getId().intValue()]=gb03.getBgbh();
          bgxx_bg[gb03.getId().intValue()]=gb03.getDyscbgbh();
     }
    bgxx_xh[1]=1;
    int total=0;
    if(gd.getBgqsym()!=null){
    	total=gd.getBgqsym().intValue()-1;
    }   
    
   	if(bgxx_xh[1]==1){
   		startPage[0]=String.valueOf(total);
   		total += printService.getHzbTotalpages(Integer.valueOf(gcxm_id),dxgc_id).intValue();
   	}
   	if(bgxx_xh[2]==2){
   		startPage[1]=String.valueOf(total);
   		total++;
   	}
   	if(bgxx_xh[3]==3){
   		startPage[2]=String.valueOf(total);
   		total += printService.getB2pages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id)).intValue();
   	}
   	if(bgxx_xh[4]==4 ){
   		startPage[3]=String.valueOf(total);
   		total += printService.getB3jTotalpages(new Integer(gcxm_id),new Integer(dxgc_id)).intValue();
   	}
   	if(bgxx_xh[5]==5){
   		startPage[4]=String.valueOf(total);
		total += printService.getB3yTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id)).intValue();
   	}
   	if(bgxx_xh[6]==6){
   		startPage[5]=String.valueOf(total);
   		total += printService.getB3bTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id)).intValue();  		
   	}
   	if(bgxx_xh[7]==7){
   		startPage[6]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[7]).intValue();	
   	}
   	if(bgxx_xh[8]==8){
   		startPage[7]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[8]).intValue();   		
   	}
   	if(bgxx_xh[9]==9){
   		startPage[8]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[9]).intValue();
   		  		
   	}
   	if(bgxx_xh[10]==10){
   		startPage[9]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[10]).intValue(); 
   			
   	}
   	if(bgxx_xh[11]==11){
   		startPage[10]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[11]).intValue();  	
   		 		
   	}
   	if(bgxx_xh[12]==12){
   		startPage[11]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[12]).intValue();   		 		
   	}
   	if(bgxx_xh[13]==13){
   		startPage[12]=String.valueOf(total);
   		total += printService.getB5jTotalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id)).intValue();    		
   	}
   	if(bgxx_xh[14]==14){
   		 startPage[13]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[14]).intValue();   		 		
   		  		
   	}
   	if(bgxx_xh[15]==15){
   		startPage[14]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[15]).intValue();
   		  		
   	}
   	if(bgxx_xh[16]==16){
   		startPage[15]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[16]).intValue(); 
   			
   	}
   	if(bgxx_xh[17]==17){
   		startPage[16]=String.valueOf(total);
   		total += printService.getB4Totalpages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id),bgxx_bgbh[17]).intValue();  		
   	}
     
%>
<page>
	<page-header font="Simhei" font-size="8pt" color="black"></page-header>
	<page-footer font="Simhei" font-size="8pt" align="right"></page-footer>
	<total-pages><%=totalPage%></total-pages>
	<%if(results!=null){
	for(int i=0;i<results.length;i++){ 
		if(results[i].equals("1")){
	%>
	<jsp:include page="Hzb_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[0]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_ids" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[1] %>"/>
		<jsp:param name="printBgbh" value="HZB"/>
	</jsp:include>	
	<%}else if(results[i].equals("2")){ %>
	<jsp:include page="B1_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[1]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[2] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[2] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("3")){ %>
	<jsp:include page="B2_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[2]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[3] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[3] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("4")){ %>
	<jsp:include page="B3j_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[3]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[4] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[4] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("5")){ %>
	<jsp:include page="B3y_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[4]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[5] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[5] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("6")){ %>
	<jsp:include page="B3b_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[5]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[6] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[6] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("7")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[6]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[7] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[7] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("8")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[7]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[8] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[8] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("9")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[8]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[9] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[9] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("10")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[9]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[10] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[10] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("11")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[10]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[11] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[11] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("12")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[11]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[12] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[12] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("13")){ %>
	<jsp:include page="B5j_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[12]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[13] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[13] %>"/>
	</jsp:include>	
	<%}else if(results[i].equals("14")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[13]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[14] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[14] %>"/>
	</jsp:include>	
	<%}else if(results[i].equals("15")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[14]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[15] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[15] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("16")){ %>
	<jsp:include page="B4_print.jsp" flush="true">
		<jsp:param name="startPage" value="<%=startPage[15]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[16] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[16] %>"/>
	</jsp:include>
	<%}else if(results[i].equals("17")){ %>
	<jsp:include page="B4_print.jsp" >
		<jsp:param name="startPage" value="<%=startPage[16]%>" />
		<jsp:param name="totalPage" value="<%=totalPage%>" />
		<jsp:param name="gcxm_id" value="<%=gcxm_id%>" />
		<jsp:param name="dxgc_id" value="<%=dxgc_id%>" />
		<jsp:param name="bgbh" value="<%=bgxx_bgbh[17] %>"/>
		<jsp:param name="printBgbh" value="<%=bgxx_bg[17] %>"/>
	</jsp:include>
	<%} }}%>
	<cover show="false">
	</cover>
</page>
