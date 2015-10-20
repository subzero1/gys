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
<%@ page import="com.netsky.dataObject.Gb01_yhb"%>
<%
    Gb01_yhb yh=(Gb01_yhb)session.getAttribute("yhb");
    if(yh==null)
    {
      %> <script language="javascript"> window.location.href="../index.jsp"; </script> <%
      return;
    }
 %>

<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��һ</title>
<link href="../css/data.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/functionlib.js"></script>
</head>

<body leftmargin="0" topmargin="0" id="main-body">
<table border="0" cellpadding="2" style="height:45px;border-collapse:collapse;" width="100%">
	<tr>
		<td style="height:15px"></td>
	</tr>
	<tr>
		<td style="vertical-aling:bottom;">
			&nbsp;<input type="button" name="b2" value=" ����Ԥ�� " onclick="allwinOpen('../print/print.jsp?type=print&dxgc_id=<%=request.getParameter("dxgc_id")%>&gcxm_id=<%=request.getParameter("gcxm_id")%>&Cb_bgxd=<%=1%>')">
			&nbsp;<input type="button" name=""   value=" ȫ��Ԥ�� "onclick="javascript:winOpen('../print/SingleProject_print.jsp?gcxm_id=<%=request.getParameter("gcxm_id")%>&dxgc_id=<%=request.getParameter("dxgc_id")%>'
					,'580','280','0')" >
		</td>
	</tr>
</table>
<div style="width:100%;background:#ffffff;" align="left">
<%
request.setCharacterEncoding("GBK");
ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
String gcxm_id = request.getParameter("gcxm_id");
//String dxgc_id = request.getParameter("dxgc_id");
int startPage = Integer.parseInt(request.getParameter("startPage"));


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
	QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder99.eq("gcxm_id",new Integer(gcxm_id));
		ResultObject ro99 = queryService.search(queryBuilder99);
		String []dxgc_id1 = new String[ro99.getLength()];
		int w=0;
		while(ro99.next()){
			Gd02_dxgc dd = (Gd02_dxgc)ro99.get(Gd02_dxgc.class.getName());
			if(dd.getId()!=null){
				dxgc_id1[w]=dd.getId().toString();
			} 
			w++;
		}
		StringBuffer dxgc_ids =null;
		for(int m=0;m<dxgc_id1.length;m++){
		    dxgc_ids =new StringBuffer("");
			if(dxgc_id1[m]!=null&&dxgc_id1[m]!="" && m!=dxgc_id1.length-1){
				dxgc_ids.append(dxgc_id1[m]);
				dxgc_ids.append(",");
			}
			if(m==dxgc_id1.length-1){
				dxgc_ids.append(dxgc_id1[m]);
			}
		}
	if(dxgc_ids != null){
		
		pages = printService.getHzbTotalpages(Integer.valueOf(gcxm_id),new String(dxgc_ids)).intValue();
		}
	else
		pages = printService.getHzbTotalpages(Integer.valueOf(gcxm_id),null).intValue();
	queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder.eq("gcxm_id",Integer.valueOf(gcxm_id));
	ro = queryService.search(queryBuilder);
	for(int i = 0; i < pages; i ++){
		%>
		<div class="file_title">������Ŀ��<%=jsjd%>�����ܱ�</div><br>
			<table id="list-table" border="0" cellpadding="0" style="border-collapse: collapse" width="990">
				<tr class="list-title">
					<td width="" rowspan="2">���</td>
					<td width="" rowspan="2">�����</td>
					<td width="" rowspan="2">��������</td>
					<td width="">С�ͽ���<br>���̷�</td>
					<td width="">��Ҫ��װ<br>���豸��</td>
					<td width="">����Ҫ��װ��<br>�豸�������߷�</td>
					<td width="">������װ<br>���̷�</td>
					<td width="">��������</td>
					<td width="">Ԥ����</td>
					<td width="" colspan="2">�ܼ�ֵ</td>
					<td width="">����׼��<br>�������</td>
				</tr>
				<tr class="list-title">
					<td colspan="6">��Ԫ��</td>
					<td> ����ң�Ԫ��</td>
					<td>������ң�����</td>
					<td>��Ԫ��</td>
				</tr>
				<tr class="list-title">
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
					<td>7</td>
					<td>8</td>
					<td>9</td>
					<td>10</td>
					<td>11</td>
					<td>12</td>
				</tr>
				<%
				int rowIndex = 0;
				while(rowIndex < Hzb_onePagesRows){
					rowIndex++;
					if(ro.next()){
						gd02 = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
						String hj = "0.00";
						%>
						<tr height="6">
							<td align="center"><%=++listCount%></td>
							<td align="left"><%=StringFormatUtil.format(gd02.getBgbh())%></td>
							<td align="left"><%=gd02.getGcmc() %></td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","�������̷�");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","�谲�豸��");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","���谲�豸��");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","������װ���̷�");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","��5�ϼ�������");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","Ԥ����");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										hj = NumberFormatUtil.addToString(hj,NumberFormatUtil.roundToString(gd03.getFyz()));
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
							<td align="right"><%if(!hj.equals("0.00")){out.print(hj);}else{out.print("");}%></td>
							<td align="right"></td>
							<td align="right">
									<%
									queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
									queryBuilder.eq("fymc","����׼���������");
									queryBuilder.eq("dxgc_id",gd02.getId());
									ro2 = queryService.search(queryBuilder);
									if(ro2.next()){
										gd03 = (Gd03_gcfysz)ro2.get(Gd03_gcfysz.class.getName());
										out.print(StringFormatUtil.nullstring(NumberFormatUtil.roundToString(gd03.getFyz())));
									}
									%>
							</td>
						</tr>
						<%
					}else{
						%>
						<tr height="6">
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
							<td ></td>
						</tr>
						<%
					}
				}
				%>
			</table>
		<%
	}
}
%>
</div>
</body>
</html>