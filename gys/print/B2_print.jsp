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
<%@ page import="java.util.*"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="org.hibernate.criterion.MatchMode" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%
/**
 * 表2打印xml页面
 * @param gcxm_id 工程项目id
 * @param dxgc_id 单项工程id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
String gcxm_id = request.getParameter("gcxm_id");
String dxgc_id = request.getParameter("dxgc_id");
String printBgbh = request.getParameter("printBgbh");
int startPage = Integer.parseInt(request.getParameter("startPage"));
if("".equals(dxgc_id)){
	dxgc_id = null;
}
Integer pages = printService.getB2pages(Integer.valueOf(gcxm_id),Integer.valueOf(dxgc_id));

Gd02_dxgc gd02;
Gd03_gcfysz gd03;
ResultObject ro,ro2;
QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
queryBuilder.eq("gcxm_id", Integer.valueOf(gcxm_id));
if(dxgc_id != null){
	queryBuilder.eq("id", Integer.valueOf(dxgc_id));
}
ro = queryService.search(queryBuilder);
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
	queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
	queryBuilder.eq("dxgc_id",gd02.getId());
	queryBuilder.addCriterion(Restrictions.or(Restrictions.eq("bgbh", "B2"), Restrictions.like("bgbh", "B3", MatchMode.ANYWHERE)));
	ro2 = queryService.search(queryBuilder);
	Map map = new HashMap();
	while(ro2.next()){
		Gd03_gcfysz object = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
		map.put(object.getFymc(),object);
	}
	%>
	<pages>
		<table width="257mm">
			<tr height="30mm">
				<td width="257mm">
					<p font="Simhei" font-size="16pt" color="black" align="center">
						建筑安装工程费用<%=jsjd%>表（表二）
					</p>
				</td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="5mm">
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">工程名称：</p></td>
				<td width="96mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getGcmc())%></p></td>
				<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">建设单位名称：</p></td>
				<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getJsdw())%></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号：</p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=gd02.getBgbh() + "-" + printBgbh%></p></td>
				<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">第<%=pageCount%>页　　总第<%=startPage+(pageCount++)%>页</p></td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="10mm">
				<td width="11mm" border="1px solid black" border-top="2px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">序号</p></td>
				<td width="39mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">费用名称</p></td>
				<td width="58mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">依据和计算方法</p></td>
				<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">合计（元）</p></td>
				<td width="0.5mm" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<td width="11mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">序号</p></td>
				<td width="39mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">费用名称</p></td>
				<td width="58mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">依据和计算方法</p></td>
				<td width="20mm" border="1px solid black" border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">合计（元）</p></td>
			</tr>
			<tr height="6mm">
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("建筑安装工程费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　建筑安装工程费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("夜间施工增加费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">8</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　夜间施工增加费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("直接费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">一</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　直接费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("冬雨季施工增加费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">9</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　冬雨季施工增加费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("直接工程费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（一）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　直接工程费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("生产工具用具使用费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">10</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　生产工器具使用费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("人工费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　人工费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("施工用水电蒸汽费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">11</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　施工用水电蒸汽费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("技工费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（1）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　技工费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("特殊地区施工增加费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">12</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　特殊地区施工增加费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("普工费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（2）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　普工费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("已完工程及设备保护费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">13</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　已完工程及设备保护费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("材料费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　材料费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("运土费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">14</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　运土费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("主要材料费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（1）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　主要材料费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("施工队伍调遣费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">15</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　施工队伍调遣费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("辅助材料费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（2）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　辅助材料费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("大型施工机械调遣费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">16</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　大型施工机械调遣费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("机械使用费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　机械使用费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("间接费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">二</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　间接费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("仪器仪表使用费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　仪表使用费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("规费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（一）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　规费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("措施费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（二）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　措施费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("工程排污费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　工程排污费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("环境保护费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　环境保护费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("社会保障费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　社会保障费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("文明施工费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　文明施工费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("住房公积金");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　住房公积金</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("工地器材搬运费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　工地器材搬运费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("危险作业意外伤害保险费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　危险作业意外伤害保险费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("工程干扰费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　工程干扰费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("企业管理费");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">（二）</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　企业管理费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("工程点交、场地清理费");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">5</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　工程点交、场地清理费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("利润");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">三</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　利润</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("临时设施费用");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">6</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　临时设施费</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("税金");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">四</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　税金</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("工程车辆使用费");
				%>
				<td border="1px solid black" border-left="2px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">7</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　工程车辆使用费</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"　")%></p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"　")%></p></td>
				<td border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">　</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">　</p></td>
				<td border="1px solid black" border-bottom="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right">　</p></td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="6mm">
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">设计负责人：</p></td>
				<td width="45mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getSjfzr()) %></p></td>
				<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="right">审核：</p></td>
				<td width="40mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getShr()) %></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">编制：</p></td>
				<td width="60mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getBzr()) %></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">编制日期：</p></td>
				<td width="27mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=DateFormatUtil.Format(gd02.getBzrq(),"yyyy年MM月dd日") %></p></td>
			</tr>
		</table>
	</pages>
	<%
}
%>