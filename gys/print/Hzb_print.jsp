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
<%@ page import="com.netsky.dataObject.Gd01_gcxm"%>
<%@ page import="com.netsky.dataObject.Gd03_gcfysz"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%
/**
 * 汇总表打印xml页面
 * @param gcxm_id 工程项目id
 * @param dxgc_id 单项工程id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
String gcxm_id = request.getParameter("gcxm_id");
String dxgc_ids = request.getParameter("dxgc_ids");
String printBgbh = request.getParameter("printBgbh");
int startPage = Integer.parseInt(request.getParameter("startPage"));
if("".equals(dxgc_ids)){
	dxgc_ids = null;
}

Gd02_dxgc gd02;
Gd01_gcxm gd01;
Gd03_gcfysz gd03;
ResultObject ro,ro2;
int Hzb_onePagesRows = printService.getHzb_onePagesRows();
QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd01_gcxm.class);
queryBuilder.eq("id", Integer.valueOf(gcxm_id));
ro = queryService.search(queryBuilder);
int pageCount = 1;

int listCount = 0;
if(ro.next()){
	gd01 = (Gd01_gcxm) ro.get(Gd01_gcxm.class.getName());
	String jsjd = "预算";
	if(gd01.getJsjd() != null){
		if(gd01.getJsjd().intValue() == 1){
			jsjd = "概算";
		}else if(gd01.getJsjd().intValue() == 2){
			jsjd = "预算";
		}else if(gd01.getJsjd().intValue() == 3){
			jsjd = "结算";
		}else if(gd01.getJsjd().intValue() == 4){
			jsjd = "决算";
		}
	}
	int pages = 0;
	if(dxgc_ids != null)
		pages = printService.getHzbTotalpages(Integer.valueOf(gcxm_id),dxgc_ids).intValue();
	else
		pages = printService.getHzbTotalpages(Integer.valueOf(gcxm_id),null).intValue();
	queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder.eq("gcxm_id",Integer.valueOf(gcxm_id));
	if(dxgc_ids != null){
		Integer dxgc_id[] = new Integer[(dxgc_ids.split(",")).length];
		for(int i = 0; i < dxgc_id.length; i++){
			dxgc_id[i] = Integer.valueOf(dxgc_ids.split(",")[i]);
		}
		queryBuilder.in("id",dxgc_id);
	}
	ro = queryService.search(queryBuilder);
	for(int i = 0; i < pages; i ++){
		%>
		<pages>
			<table width="257mm">
				<tr height="25mm">
					<td width="257mm">
						<p font="Simhei" font-size="16pt" color="black" align="center">
							建设项目总<%=jsjd%>表（汇总表）
						</p>
					</td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="5mm">
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">建设项目名称：</p></td>
					<td width="91mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getXmmc())%></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">建设单位名称：</p></td>
					<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getJsdw())%></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号：</p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getBgbh()+"-"+printBgbh)%></p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">第<%=pageCount%>页　　总第<%=startPage+(pageCount++)%>页</p></td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="10mm">
					<td width="10mm" border="1px solid black" border-left="2px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">序号</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号</p></td>
					<td width="45mm" border="1px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">工程名称</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">小型建筑　　工程费</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">需要安装　　的设备费</p></td>
					<td width="26mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">不需要安装的　　　设备、工器具费</p></td>
					<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">建筑安装　　工程费</p></td>
					<td width="19mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">其他费用</p></td>
					<td width="19mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">预备费</p></td>
					<td width="47mm" border="1px solid black" border-top="2px solid black" colspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">总价值</p></td>
					<td width="20mm" border="1px solid black" border-right="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">生产准备及　　开办费</p></td>
				</tr>
				<tr height="6mm">
					<td colspan="6" border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（元）</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">人民币（元）</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">其中外币（　）</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（元）</p></td>
				</tr>
				<tr height="6mm">
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
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">XI</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">XII</p></td>
				</tr>
				<%
				int rowIndex = 0;
				while(rowIndex < Hzb_onePagesRows){
					rowIndex++;
					if(ro.next()){
						gd02 = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
						String hj = "0.00";
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center"><%=++listCount%></p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=gd02.getBgbh() %></p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=gd02.getGcmc() %></p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","建筑工程费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","需安设备费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","不需安设备费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","建筑安装工程费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","表5合计其他费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","预备费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%=hj%></p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","生产准备及开办费");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"　"));
									}
									%>
								</p>
							</td>
						</tr>
						<%
					}else{
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
						</tr>
						<%
					}
				}
				%>
			</table>
			<table width="257mm">
				<tr height="6mm">
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">设计负责人：</p></td>
					<td width="45mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getSjfzr()) %></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="right">审核：</p></td>
					<td width="40mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getShr()) %></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">编制：</p></td>
					<td width="60mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getBzr()) %></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">编制日期：</p></td>
					<td width="27mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=DateFormatUtil.Format(gd01.getBzrq(),"yyyy年MM月dd日") %></p></td>
				</tr>
			</table>
		</pages>
		<%
	}
}
%>