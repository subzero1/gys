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
 * ���ܱ��ӡxmlҳ��
 * @param gcxm_id ������Ŀid
 * @param dxgc_id �����id
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
	String jsjd = "Ԥ��";
	if(gd01.getJsjd() != null){
		if(gd01.getJsjd().intValue() == 1){
			jsjd = "����";
		}else if(gd01.getJsjd().intValue() == 2){
			jsjd = "Ԥ��";
		}else if(gd01.getJsjd().intValue() == 3){
			jsjd = "����";
		}else if(gd01.getJsjd().intValue() == 4){
			jsjd = "����";
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
							������Ŀ��<%=jsjd%>�����ܱ�
						</p>
					</td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="5mm">
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">������Ŀ���ƣ�</p></td>
					<td width="91mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getXmmc())%></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">���赥λ���ƣ�</p></td>
					<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getJsdw())%></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">����ţ�</p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getBgbh()+"-"+printBgbh)%></p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">��<%=pageCount%>ҳ�����ܵ�<%=startPage+(pageCount++)%>ҳ</p></td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="10mm">
					<td width="10mm" border="1px solid black" border-left="2px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">�����</p></td>
					<td width="45mm" border="1px solid black" border-top="2px solid black" rowspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">��������</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">С�ͽ����������̷�</p></td>
					<td width="18mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��Ҫ��װ�������豸��</p></td>
					<td width="26mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">����Ҫ��װ�ġ������豸�������߷�</p></td>
					<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">������װ�������̷�</p></td>
					<td width="19mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��������</p></td>
					<td width="19mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">Ԥ����</p></td>
					<td width="47mm" border="1px solid black" border-top="2px solid black" colspan="2"><p font="Simsun" font-size="9pt" color="black" align="center">�ܼ�ֵ</p></td>
					<td width="20mm" border="1px solid black" border-right="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">����׼�������������</p></td>
				</tr>
				<tr height="6mm">
					<td colspan="6" border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��Ԫ��</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">����ң�Ԫ��</p></td>
					<td border="1px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">������ң�����</p></td>
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��Ԫ��</p></td>
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
									queryBuilder.eq("fymc","�������̷�");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","�谲�豸��");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","���谲�豸��");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","������װ���̷�");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","��5�ϼ�������");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","Ԥ����");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%=hj%></p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>>
								<p font="Simsun" font-size="9pt" color="black" align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","����׼���������");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										out.print(NumberFormatUtil.roundToString(gd03.getFyz(),"��"));
									}
									%>
								</p>
							</td>
						</tr>
						<%
					}else{
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == Hzb_onePagesRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right">��</p></td>
						</tr>
						<%
					}
				}
				%>
			</table>
			<table width="257mm">
				<tr height="6mm">
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">��Ƹ����ˣ�</p></td>
					<td width="45mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getSjfzr()) %></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="right">��ˣ�</p></td>
					<td width="40mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getShr()) %></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">���ƣ�</p></td>
					<td width="60mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd01.getBzr()) %></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="right">�������ڣ�</p></td>
					<td width="27mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=DateFormatUtil.Format(gd01.getBzrq(),"yyyy��MM��dd��") %></p></td>
				</tr>
			</table>
		</pages>
		<%
	}
}
%>