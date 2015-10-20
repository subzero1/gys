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
 * ��2��ӡxmlҳ��
 * @param gcxm_id ������Ŀid
 * @param dxgc_id �����id
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
		jsjd = "����";
	}else if(gd02.getJsjd().intValue() == 2){
		jsjd = "Ԥ��";
	}else if(gd02.getJsjd().intValue() == 3){
		jsjd = "����";
	}else if(gd02.getJsjd().intValue() == 4){
		jsjd = "����";
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
						������װ���̷���<%=jsjd%>�������
					</p>
				</td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="5mm">
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">�������ƣ�</p></td>
				<td width="96mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getGcmc())%></p></td>
				<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">���赥λ���ƣ�</p></td>
				<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getJsdw())%></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">����ţ�</p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=gd02.getBgbh() + "-" + printBgbh%></p></td>
				<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">��<%=pageCount%>ҳ�����ܵ�<%=startPage+(pageCount++)%>ҳ</p></td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="10mm">
				<td width="11mm" border="1px solid black" border-top="2px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
				<td width="39mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��������</p></td>
				<td width="58mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���ݺͼ��㷽��</p></td>
				<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�ϼƣ�Ԫ��</p></td>
				<td width="0.5mm" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td width="11mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
				<td width="39mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��������</p></td>
				<td width="58mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���ݺͼ��㷽��</p></td>
				<td width="20mm" border="1px solid black" border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�ϼƣ�Ԫ��</p></td>
			</tr>
			<tr height="6mm">
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("������װ���̷�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��������װ���̷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("ҹ��ʩ�����ӷ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">8</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ҹ��ʩ�����ӷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("ֱ�ӷ�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">һ</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ֱ�ӷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("���꼾ʩ�����ӷ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">9</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����꼾ʩ�����ӷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("ֱ�ӹ��̷�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��һ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ֱ�ӹ��̷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("���������þ�ʹ�÷�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">10</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">������������ʹ�÷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("�˹���");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���˹���</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("ʩ����ˮ��������");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">11</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ʩ����ˮ��������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("������");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��1��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("�������ʩ�����ӷ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">12</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���������ʩ�����ӷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("�չ���");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��2��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���չ���</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("���깤�̼��豸������");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">13</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����깤�̼��豸������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("���Ϸ�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����Ϸ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("������");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">14</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("��Ҫ���Ϸ�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��1��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����Ҫ���Ϸ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("ʩ�������ǲ��");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">15</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ʩ�������ǲ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("�������Ϸ�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��2��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���������Ϸ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("����ʩ����е��ǲ��");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">16</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">������ʩ����е��ǲ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("��еʹ�÷�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����еʹ�÷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("��ӷ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����ӷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("�����Ǳ�ʹ�÷�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���Ǳ�ʹ�÷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("���");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��һ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("��ʩ��");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����ʩ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("�������۷�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���������۷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("����������");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">1</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">������������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("��ᱣ�Ϸ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����ᱣ�Ϸ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("����ʩ����");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">2</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">������ʩ����</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("ס��������");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��ס��������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("�������İ��˷�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">3</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">���������İ��˷�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("Σ����ҵ�����˺����շ�");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��Σ����ҵ�����˺����շ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("���̸��ŷ�");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">4</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����̸��ŷ�</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("��ҵ�����");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����ҵ�����</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("���̵㽻�����������");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">5</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����̵㽻�����������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("����");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">������</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("��ʱ��ʩ����");
				%>
				<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">6</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">����ʱ��ʩ��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<%
				gd03 = (Gd03_gcfysz) map.get("˰��");
				%>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��˰��</p></td>
				<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
			</tr>
			<tr height="6mm">
				<%
				gd03 = (Gd03_gcfysz) map.get("���̳���ʹ�÷�");
				%>
				<td border="1px solid black" border-left="2px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">7</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">�����̳���ʹ�÷�</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
				<td border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��</p></td>
				<td border="1px solid black" border-bottom="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="left">��</p></td>
				<td border="1px solid black" border-bottom="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
			</tr>
		</table>
		<table width="257mm">
			<tr height="6mm">
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">��Ƹ����ˣ�</p></td>
				<td width="45mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getSjfzr()) %></p></td>
				<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="right">��ˣ�</p></td>
				<td width="40mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getShr()) %></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">���ƣ�</p></td>
				<td width="60mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getBzr()) %></p></td>
				<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">�������ڣ�</p></td>
				<td width="27mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=DateFormatUtil.Format(gd02.getBzrq(),"yyyy��MM��dd��") %></p></td>
			</tr>
		</table>
	</pages>
	<%
}
%>