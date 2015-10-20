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
<%@ page import="com.netsky.dataObject.Gd07_b4"%>
<%@ page import="com.netsky.dataObject.Gb03_bgxx"%>
<%@ page import="com.netsky.dataObject.Ga00_zclb"%>
<%@ page import="com.netsky.viewObject.B4_printVo"%>
<%@ page import="com.netsky.dataObject.Gd04_clfysz"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="org.hibernate.criterion.Order" %>
<%@ page import="java.util.*"%>
<%
/**
 * ��4�ܴ�ӡxmlҳ��
 * @param gcxm_id ������Ŀid
 * @param dxgc_id �����id
 */
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
String gcxm_id = request.getParameter("gcxm_id");
String dxgc_id = request.getParameter("dxgc_id");
String bgbh = request.getParameter("bgbh");
int startPage = Integer.parseInt(request.getParameter("startPage"));
String printBgbh = request.getParameter("printBgbh");
if("".equals(dxgc_id)){
	dxgc_id = null;
}

Gd02_dxgc gd02;
Gd07_b4 gd07;
Gb03_bgxx gb03;
Ga00_zclb ga00;
Gd04_clfysz gd04;
B4_printVo vo;
ResultObject ro,ro2;
int B4_onePageRows = printService.getB4_onePageRows();

QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb03_bgxx.class);
queryBuilder.eq("bgbh",bgbh);
ro = queryService.search(queryBuilder);
ro.next();
gb03 = (Gb03_bgxx)ro.get(Gb03_bgxx.class.getName());
queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
queryBuilder.eq("gcxm_id", Integer.valueOf(gcxm_id));
if(dxgc_id != null){
	queryBuilder.eq("id", Integer.valueOf(dxgc_id));
}
ro = queryService.search(queryBuilder);
int pageCount = 1;

/**
 * ��ʾ����б�,�ڴ����ʾ���vo
 */
List list = new ArrayList();
int listCount = 0;
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
	
	/**
	 * ���������ۼ�
	 */
	int rowCount = 1;
	/**
	 * �ܼ�ֵ
	 */
	String zj = "0.00";
	queryBuilder = new HibernateQueryBuilder(Ga00_zclb.class);
	queryBuilder.addOrderBy(Order.asc("id"));
	ro2 = queryService.search(queryBuilder);
	int gg=0;
	while(ro2.next()){
		/**
		 * ���ϻ��豸˳���
		 */
		
		ga00 = (Ga00_zclb)ro2.get(Ga00_zclb.class.getName());
		queryBuilder = new HibernateQueryBuilder(Gd07_b4.class);
		queryBuilder.eq("dxgc_id",gd02.getId());
		queryBuilder.eq("zclb",ga00.getZclb());
		queryBuilder.eq("bgbh",bgbh);
		queryBuilder.addOrderBy(Order.asc("xh"));
		ResultObject ro3 = queryService.search(queryBuilder);
		if(ro3.getLength() > 0){
			/**
			 * ���Ӳ��������
			 */
			 vo = new B4_printVo();
			 vo.setMc(ga00.getMc() + "���ϣ�");
			 list.add(vo);
		}
		/**
		 * ����С���ۼӱ���
		 */
		String xj = "0";
		while(ro3.next()){
			/**
			 * ���������
			 */
			gd07 = (Gd07_b4)ro3.get(Gd07_b4.class.getName());
			vo = new B4_printVo();
			vo.setXh(String.valueOf(rowCount ++));
			vo.setMc(gd07.getMc());
			vo.setGgcs(gd07.getXhgg());
			vo.setGg(gd07.getGg());
			vo.setDw(gd07.getDw());
			vo.setSl(NumberFormatUtil.roundToString(gd07.getSl()));
			vo.setDj(NumberFormatUtil.roundToString(gd07.getDj()));
			vo.setHj(NumberFormatUtil.mulToString(gd07.getSl().toString(),gd07.getDj().toString()));
			vo.setBz(gd07.getBz());
			/**
			 * �������ϵ��
			 */
			if(gd07.getTzxs() != null && gd07.getTzxs().doubleValue() != 1){
				vo.setMc(vo.getMc() + "�����Ϸѵ��������Ϸѡ�" + NumberFormatUtil.roundToString(gd07.getTzxs()) + "��");
				vo.setHj(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(vo.getHj(),NumberFormatUtil.roundToString(gd07.getTzxs()))));
			}
			xj = NumberFormatUtil.addToString(xj,vo.getHj());	
			if(gd07.getSl().doubleValue()!=0.0){//���жϣ��������Ϊ0ȥ������
				list.add(vo);
			}
		}
		if(ro3.getLength() > 0){
			if(!ga00.getZclb().equals("YS")){
			 	/**
				 * ����С����
				 */
				vo = new B4_printVo();
				vo.setMc("��������������������С������������");
				vo.setHj(xj);
				list.add(vo);
				/**
				 * ���ӷ���
				 */
				queryBuilder = new HibernateQueryBuilder(Gd04_clfysz.class);
				queryBuilder.eq("bgbh",bgbh);
				queryBuilder.eq("dxgc_id",gd02.getId());
				queryBuilder.eq("zclb",ga00.getZclb());
				queryBuilder.addOrderBy(Order.asc("fy_id"));
				ro3 = queryService.search(queryBuilder);
				while(ro3.next()){
					gd04 = (Gd04_clfysz) ro3.get(Gd04_clfysz.class.getName());
					vo = new B4_printVo();
					vo.setMc(gd04.getFymc()+"����С�ơ�"+gd04.getFlz()+"%��");
					vo.setHj(NumberFormatUtil.roundToString(gd04.getFyz()));
					xj = NumberFormatUtil.addToString(xj,vo.getHj());
					if(gd04.getFlz()!=null&&gd04.getFlz().doubleValue()!=0.0){//ȥ������Ϊ0 ����
						list.add(vo);
					}
				}
			 }
			 /**
			  * ���ӷ�����ϼ���
			  */
			 vo = new B4_printVo();
			 vo.setMc("���������������������ϡ�����������");
			 vo.setHj(xj);
			 list.add(vo);
			 zj = NumberFormatUtil.addToString(zj,xj);
			 gg++;
		}		
		
	}
	if(gg==1){
		
	}else{
		if(list.size() > 0){
			/**
			 * �����ܼ���
			 */
			 vo = new B4_printVo();
			 vo.setMc("���������������������ܡ�����������");
			 vo.setHj(zj);
			 list.add(vo);
		}
	}
	int pages = printService.getB4pages(gd02.getId(),bgbh).intValue();
	for(int i = 0; i < pages; i ++){
		%>
		<pages>
			<table width="257mm">
				<tr height="25mm">
					<td width="257mm">
						<p font="Simhei" font-size="16pt" color="black" align="center">
							<%=gb03.getMc() %>
						</p>
						<p font="Simsun" font-size="13pt" color="black" align="center">
							��<%=gb03.getFbt() %>��
						</p>
					</td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="5mm">
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">�������ƣ�</p></td>
					<td width="96mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getGcmc())%></p></td>
					<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">���赥λ���ƣ�</p></td>
					<td width="36mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(gd02.getJsdw())%></p></td>
					<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">����ţ�</p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=gd02.getBgbh() + "-" + printBgbh%></p></td>
					<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">��<%=pageCount%>ҳ�����ܵ�<%=startPage+(pageCount++)%>ҳ</p></td>
				</tr>
			</table>
			<table width="257mm">
				<tr height="10mm">
					<td width="10mm" border="1px solid black" border-left="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
					<td width="85mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">����</p></td>
					<td width="70mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���</p></td>
					<td width="10mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�ͺ�</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��λ</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">����</p></td>
					<td width="15mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">���ۣ�Ԫ��</p></td>
					<td width="20mm" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">�ϼƣ�Ԫ��</p></td>
					<td width="43mm" border="1px solid black" border-right="2px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">��ע</p></td>
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
					<td border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" color="black" align="center">IX</p></td>
				</tr>
				<%
				int rowIndex = 0;
				while(rowIndex < B4_onePageRows){
					rowIndex++;
					if(listCount < list.size()){
						vo = (B4_printVo)list.get(listCount ++);
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center"><%=StringFormatUtil.format(vo.getXh()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");}%>><p font="Simsun" font-size="9pt" color="black" align="left"><%if(listCount==list.size() && gg==1){out.print("���������������������������ܡ�����������");}else{out.print(StringFormatUtil.format(vo.getMc()));} %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(vo.getGgcs()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(vo.getGg()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center"><%=StringFormatUtil.format(vo.getDw()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%=StringFormatUtil.format(vo.getSl()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%=StringFormatUtil.format(vo.getDj()) %></p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="right"><%if(vo.getHj()!=null){out.print(NumberFormatUtil.roundToString(vo.getHj()));}else{out.print("��");} %></p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(vo.getBz()) %></p></td>
						</tr>
						<%
					}else{
						%>
						<tr height="6mm">
							<td border="1px solid black" border-left="2px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
							<td border="1px solid black" border-right="2px solid black"<%if(rowIndex == B4_onePageRows){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" color="black" align="center">��</p></td>
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