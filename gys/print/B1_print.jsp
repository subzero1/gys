<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.PrintService"%>
<%@ page import="com.netsky.service.QueryService" %>
<%@ page import="com.netsky.baseObject.ResultObject" %>
<%@ page import="com.netsky.baseObject.QueryBuilder" %>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder" %>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="com.netsky.dataObject.Gd01_gcxm" %>
<%@ page import="java.util.HashMap"%>
<%
	request.setCharacterEncoding("GBK");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
	Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
	Integer pages = printService.getB1pages(gcxm_id,dxgc_id);
	String bgbh = request.getParameter("bgbh");
	int startPage = Integer.parseInt(request.getParameter("startPage"));
	Gd01_gcxm gd01 = new Gd01_gcxm();
	QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd01_gcxm.class);
	queryBuilder9.eq("id",gcxm_id);
	ResultObject ro9 = queryService.search(queryBuilder9);
	if(ro9.next()){
		gd01 = (Gd01_gcxm)ro9.get(Gd01_gcxm.class.getName());
	}
	Gd02_dxgc gd02 = new Gd02_dxgc();
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder.eq("gcxm_id",gcxm_id);
	if(dxgc_id != null){
		queryBuilder.eq("id",dxgc_id);
	}
	ResultObject ro = queryService.search(queryBuilder);
	int pageCount = 1;
	while(ro.next()){
		gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
		String jsjd = "";
		if(gd02.getJsjd().intValue() == 1){
			jsjd = "概算";
		}else if(gd02.getJsjd().intValue() == 2){
			jsjd = "预算";
		}else if(gd02.getJsjd().intValue() == 3){
			jsjd = "结算";
		}else if(gd02.getJsjd().intValue() == 4){
			jsjd = "决算";
		}
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd03_gcfysz.class);	
		queryBuilder1.eq("dxgc_id",gd02.getId());
		ResultObject ro1 = queryService.search(queryBuilder1);	
		Gd03_gcfysz gd03 = new Gd03_gcfysz();
	 	HashMap bg=new HashMap();
        HashMap gs=new HashMap();
        HashMap jsgs=new HashMap();
		while(ro1.next()){
			gd03 = (Gd03_gcfysz)ro1.get(Gd03_gcfysz.class.getName());
			if(gd03!=null){
				bg.put(gd03.getFymc(),gd03.getFyz());
                gs.put(gd03.getFymc(),gd03.getGsbds());
  		       	jsgs.put(gd03.getFymc(),gd03.getJsgs());
			}
		}
		int m=0;//记录几行显示
%>
		<pages>
			<table width="257mm">
				<tr height="25mm">
					<td width="257mm">
						<p font="Simhei" font-size="16pt" color="black" align="center">
							工程<%=jsjd%>总表（表一）
						</p>
					</td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="4mm" width="257mm">
					<td width="26mm"><p font="Simsun" font-size="9pt" color="black" align="left">建设项目名称：</p></td>
					<td width="90mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getXmmc())%></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">  </p></td>
					<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"> </p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center"> </p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"> </p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">  </p></td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="5mm" width="257mm">
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left">工程名称：</p></td>
					<td width="66mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getGcmc())%></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">建设单位名称：</p></td>
					<td width="76mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getJsdw())%></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号：</p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%if(gd02.getBgbh()!=null){out.print(gd02.getBgbh()+"-"+bgbh);}else{out.print("-"+bgbh);}%></p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">第<%=pageCount%>页　　总第<%=startPage+(pageCount++)%>页</p></td>
			   </tr>
			</table>
			<table width="257mm">
				<tr height="7mm">
					<td width="10mm" rowspan="2" border="1px solid black" border-left="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">序号</p></td>
					<td width="28mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号</p></td>
					<td width="59mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">费用名称</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">小型建筑工程费</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">需要安装的设备费</p></td>
					<td width="25mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">不需要安装的设备、工器具费</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">建筑安装工程费</p></td>
					<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">其他费用</p></td>
					<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">预备费</p></td>
					<td width="40mm" colspan="2" border="1px solid black" border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">总价值</p></td>
				</tr>
				<tr height="7mm">
					<td colspan="6" border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（元）</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">人民币（元）</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">其中外币（）</p></td>
				</tr>
				<tr height="7mm">
					<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">V</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">VI</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">VII</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">VIII</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IX</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">X</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">XI</p></td>
				</tr>
				<%
				if((Double)bg.get("建筑安装工程费")!=null&&((Double)bg.get("建筑安装工程费")).doubleValue()!=0.0) {
					m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B2</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >建筑安装工程费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("建筑安装工程费")!=null && ((Double)bg.get("建筑安装工程费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("建筑安装工程费")!=null && ((Double)bg.get("建筑安装工程费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%}if(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费")))) {
				m++;%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black"  ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B4J(GDLSBF)</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >光电缆设备费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("光电缆设备费")!=null && ((Double)bg.get("光电缆设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("光电缆设备费")!=null && ((Double)bg.get("光电缆设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("光电缆设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} if(NumberFormatUtil.roundToString((Double)bg.get("需安设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")))) {
				m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B4J(XASBF)</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >国内需安设备费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(bg.get("需安设备费")!=null && ((Double)bg.get("需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p>　</td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("需安设备费")!=null && ((Double)bg.get("需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} if(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")))) {
				m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B4J(BXASBF)</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >国内不需安设备费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(bg.get("不需安设备费")!=null && ((Double)bg.get("不需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("不需安设备费")!=null && ((Double)bg.get("不需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} if(NumberFormatUtil.roundToString((Double)bg.get("备品备件"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("备品备件")))) {
				m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B4J(BPBJF)</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >国内备品备件费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(bg.get("备品备件")!=null && ((Double)bg.get("备品备件")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("备品备件")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(bg.get("备品备件")!=null && ((Double)bg.get("备品备件")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("备品备件")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} if(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费"))!=""&&!"0.00".equals(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")))) {
				m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"><%= m%></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=StringFormatUtil.format(gd02.getBgbh())%>-B5J</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >工程建设其他费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(bg.get("表5合计其他费")!=null && ((Double)bg.get("表5合计其他费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black"  align="right"><%if(bg.get("表5合计其他费")!=null && ((Double)bg.get("表5合计其他费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%
				 	String zhj=NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("需安设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("不需安设备费"))),NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("建筑安装工程费")),NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费"))),NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")))),NumberFormatUtil.roundToString((Double)bg.get("备品备件")));
					if(!zhj.equals("0.00")){
						m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　　　　　合　　　　　计</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("需安设备费")!=null && ((Double)bg.get("需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(!(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")))).equals("0.00") ){out.print(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件"))));}else{out.print("");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(!NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")).equals("0.00")){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")));}else{out.print("");} %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(!NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("表5合计其他费")))).equals("0.00")){out.print(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("表5合计其他费")))));}else{out.print("");} %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" align="right"><%if(!zhj.equals("0.00")){out.print(zhj);}else{out.print("");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%if(bg.get("预备费")!=null && (Double)bg.get("预备费")!=null &&((Double)bg.get("预备费")).doubleValue()!=0.0){
					m++;//000
				 %>
				
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >预备费（工程费+其他费）× 4.0%</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("预备费")!=null && ((Double)bg.get("预备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("预备费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} 
					if(bg.get("建设期利息")!=null &&(Double)bg.get("建设期利息")!=null && ((Double)bg.get("建设期利息")).doubleValue()!=0.0){
					m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >建设期利息</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(bg.get("建设期利息")!=null && ((Double)bg.get("建设期利息")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("建设期利息")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%}
					if(bg.get("建筑工程费")!=null &&(Double)bg.get("建筑工程费")!=null && ((Double)bg.get("建筑工程费")).doubleValue()!=0.0){
					m++;
				 %>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >建筑工程费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("建筑工程费")!=null && ((Double)bg.get("建筑工程费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑工程费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				
				<%
					String zhj2=NumberFormatUtil.addToString(NumberFormatUtil.roundToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("需安设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("不需安设备费"))),NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double)bg.get("建筑安装工程费")),NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费"))),NumberFormatUtil.roundToString((Double)bg.get("表5合计其他费")))),NumberFormatUtil.roundToString(NumberFormatUtil.roundToString((Double)bg.get("预备费"))))),NumberFormatUtil.roundToString((Double)bg.get("建筑工程费")));
					if(!zhj2.equals("0.00")){//总合计为0不显示
						m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center"></p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　　　　　总　　　　　计</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("建筑工程费")!=null && ((Double)bg.get("建筑工程费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑工程费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("需安设备费")!=null && ((Double)bg.get("需安设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("需安设备费")));}else{out.print("　");}%></p></td>
						<%
							String bxasbf="";
							if(!(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")))).equals("0.00")){
						 		bxasbf =NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件"))) ;
						 	}
						 %>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%=bxasbf%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black"  align="right" ><%if(!NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")).equals("0.00")){out.print(NumberFormatUtil.roundToString((Double)bg.get("建筑安装工程费")));}else{out.print("");} %></p></td>
						<% 
							String b5jtaf=NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("光电缆设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("表5合计其他费"))),NumberFormatUtil.roundToDouble((Double)bg.get("建设期利息")))) ;
						 %>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(!b5jtaf.equals("0.00")){out.print(b5jtaf);}else{out.print("");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(!NumberFormatUtil.roundToString((Double)bg.get("预备费")).equals("0.00")){out.print(NumberFormatUtil.roundToString((Double)bg.get("预备费")));}else{out.print("");} %></p></td>
						
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black"  align="right" ><%if(!zhj2.equals("0.00")){out.print(zhj2);}else{out.print("");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%if(bg.get("生产准备及开办费")!=null &&(Double)bg.get("生产准备及开办费")!=null && ((Double)bg.get("生产准备及开办费")).doubleValue()!=0.0){ 
				m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >生产准备及开办费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("生产准备及开办费")!=null && ((Double)bg.get("生产准备及开办费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right" ><%if(bg.get("生产准备及开办费")!=null && ((Double)bg.get("生产准备及开办费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%if(bg.get("维护器具费")!=null &&(Double)bg.get("维护器具费")!=null && ((Double)bg.get("维护器具费")).doubleValue()!=0.0){ 
					m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=gd02.getBgbh()%>-B4JWHQJ</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >国内维护器具费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("维护器具费")!=null && ((Double)bg.get("维护器具费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("维护器具费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right" ><%if(bg.get("维护器具费")!=null && ((Double)bg.get("维护器具费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("维护器具费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<% if(bg.get("回收设备费")!=null && (Double)bg.get("回收设备费")!=null&& ((Double)bg.get("回收设备费")).doubleValue()!=0.0){
					m++;
				%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=gd02.getBgbh()%>-HSSB</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >回收设备费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("回收设备费")!=null && ((Double)bg.get("回收设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("回收设备费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right" ><%if(bg.get("回收设备费")!=null && ((Double)bg.get("回收设备费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("回收设备费")));}else{out.print("　");}  %></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%if(bg.get("回收主材费")!=null && (Double)bg.get("回收主材费")!=null &&((Double)bg.get("回收主材费")).doubleValue()!=0.0){ 
				m++;%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" ><%=gd02.getBgbh()%>-HSZC</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >回收主材费</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("回收主材费")!=null &&((Double)bg.get("回收主材费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("回收主材费")));}else{out.print("　");} %></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt"  align="right" ><%if(bg.get("回收主材费")!=null &&((Double)bg.get("回收主材费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("回收主材费")));}else{out.print("　");} %></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%} %>
				<%
					QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder2.eq("dxgc_id",gd02.getId());
					queryBuilder2.isNull("fy_id");	
					queryBuilder2.eq("bgbh","B1");
					ResultObject ro2 = queryService.search(queryBuilder2);
					Gd03_gcfysz gd032 = new Gd03_gcfysz();
					int i=0;
					double qtfy = 0.00;
					while(ro2.next()||i<(17-m)){//8-M
						i++;
						gd032=(Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
						if(gd032!=null){
							if(gd032.getFyz()!=null){
						 		qtfy =NumberFormatUtil.addToDouble(gd032.getFyz().doubleValue(),qtfy);
							}
				 %>
				 <tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" ><%if(gd032.getFymc()!=null){out.print(gd032.getFymc());}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right"><%if(gd032.getFyz()!=null&&gd032.getFyz().doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString(gd032.getFyz()));}else{out.print("　");}%></p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="right" ><%if(gd032.getFyz()!=null&&gd032.getFyz().doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString(gd032.getFyz()));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%}else{%>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black"  ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" ><p font="Simsun" font-size="9pt" >　</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
				<%}}%>
				<tr height="6mm">
					<% 	String sum1= "　";
						if(!NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费")))).equals("0.00")){
							sum1=NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费"))));
						}
						String sum2 ="　";
						if(!NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("生产准备及开办费")),qtfy) ).equals("0.00")){
							sum2=NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double)bg.get("生产准备及开办费")),qtfy) );
						}
						String sum3 = "　";
						if(!NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")),NumberFormatUtil.roundToString((Double)bg.get("维护器具费"))),NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费"))))),String.valueOf(qtfy)).equals("0.00")){
							sum3 =NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("生产准备及开办费")),NumberFormatUtil.roundToString((Double)bg.get("维护器具费"))),NumberFormatUtil.roundToString(NumberFormatUtil.addToString( NumberFormatUtil.roundToDouble((Double)bg.get("回收设备费")),NumberFormatUtil.roundToDouble((Double)bg.get("回收主材费"))))),String.valueOf(qtfy)) ;
						}
					 %>
					
					<td border="1px solid black" border-left="2px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black"  border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" ><%if(!sum3.equals("　")){ %>　　　　　合　　　　　计<%}else{ %>　<%} %></p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt"  align="right"><%=sum1%></p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt"  align="right"><%if(bg.get("维护器具费")!=null &&((Double)bg.get("维护器具费")).doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString((Double)bg.get("维护器具费")));}else{out.print("　");}%></p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" >　</p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt"  align="right"><%=sum2%></p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
					<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt"  align="right"><%=sum3%></p></td>
					<td border="1px solid black" border-bottom="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="left">　</p></td>
				</tr>
			</table>
			<table width="257mm">
			   <tr height="6mm">
				<td width="51mm"><p font="Simsun" font-size="9pt">设计负责人：<%=StringFormatUtil.format(gd02.getSjfzr()) %></p></td>	
				<td width="51mm"><p font="Simsun" font-size="9pt">审核：<%=StringFormatUtil.format(gd02.getShr()) %></p></td>
				<td width="100mm"><p font="Simsun" font-size="9pt">编制：<%=StringFormatUtil.format(gd02.getBzr()) %></p></td>
				<td width="18mm"><p font="Simsun" font-size="9pt">编制日期：</p></td>
				<td width="37mm" align="left"><p font="Simsun" font-size="9pt"><%=DateFormatUtil.Format(gd02.getBzrq(),"yyyy年MM月dd日") %></p></td>
			  </tr>
			</table>
			</pages>
		<%}%>