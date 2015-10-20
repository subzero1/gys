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
<%@ page import="org.hibernate.criterion.Order" %>
<%
/**
 * ��5�ܴ�ӡxmlҳ��
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

Gd02_dxgc gd02;
Gd03_gcfysz gd03;
ResultObject ro,ro2;
int B5j_onePageRows = printService.getB5j_onePageRows();
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
	queryBuilder.eq("bgbh","B5");
	queryBuilder.addOrderBy(Order.asc("fy_id"));
	ro2 = queryService.search(queryBuilder);
	int pages = printService.getB5jpages(gd02.getId()).intValue();
	boolean setHj = true;
	boolean setSczbf = true;
	int rowCount = 0;
	for(int i = 0; i < pages; i ++){
		%>
		<pages>
			<table width="257mm">
				<tr height="30mm">
					<td width="257mm">
						<p font="Simhei" font-size="16pt" color="black" align="center">
							���̽�����������<%=jsjd%>�����壩
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
					<td width="12mm" border="1px solid black" border-left="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
					<td width="60mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�ѡ��á�������</p></td>
					<td width="80mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�������ݼ�����</p></td>
					<td width="30mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�𡡶Ԫ��</p></td>
					<td width="75mm" border="1px solid black" border-right="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">������ע</p></td>
				</tr>
				<tr height="6mm">
					<td border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">I</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">II</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">III</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IV</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">V</p></td>
				</tr>
				<%
				int rowIndex = 0;
				while(rowIndex < B5j_onePageRows){
					rowIndex++;
					if(ro2.next()){
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center"><%=++rowCount %></p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">��<%=gd03.getFymc() %></p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getGsbds(),"��")%></p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%=NumberFormatUtil.roundToString(gd03.getFyz(),"��")%></p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd03.getBz(),"��")%></p></td>
						</tr>
						<%
					}else if(setHj){
						setHj = false;
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">�ϡ�������</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("dxgc_id",gd02.getId());
									queryBuilder.eq("fymc","��5�ϼ�������");
									ResultObject ro3 = queryService.search(queryBuilder);
									String Hj = "��";
									if(ro3.next()){
										gd03 = (Gd03_gcfysz) ro3.get(Gd03_gcfysz.class.getName());
										Hj = NumberFormatUtil.roundToString(gd03.getFyz(),"��");
									}
									out.print(Hj);
									%>
								</p>
							</td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
						</tr>
						<%
					}else if(setSczbf){
						setSczbf = false;
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center"><%=++rowCount %></p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">������׼��������ѣ���Ӫ�ѣ�</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("dxgc_id",gd02.getId());
									queryBuilder.eq("fymc","����׼���������");
									ResultObject ro3 = queryService.search(queryBuilder);
									String Hj = "��";
									if(ro3.next()){
										gd03 = (Gd03_gcfysz) ro3.get(Gd03_gcfysz.class.getName());
										Hj = NumberFormatUtil.roundToString(gd03.getFyz(),"��");
									}
									out.print(Hj);
									%>
								</p>
							</td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
						</tr>
						<%
					}else{
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B5j_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
						</tr>
						<%
					}
				}
				%>
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
}
%>