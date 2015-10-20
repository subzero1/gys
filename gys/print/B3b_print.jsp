<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.service.PrintService" %>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd05_b3j"%>
<%@ page import="com.netsky.dataObject.Gd06_b3y"%>
<%@ page import="com.netsky.viewObject.PrintB3ybVo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.DateFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="org.hibernate.criterion.Order" %>
<%
    List list=new ArrayList();
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	Integer dxgc_id=new Integer(request.getParameter("dxgc_id"));
	Integer gcxm_id=new Integer(request.getParameter("gcxm_id"));
	String bgbh = request.getParameter("bgbh");
	QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder.eq("gcxm_id",gcxm_id);
	if(dxgc_id!=null){
		queryBuilder.eq("id",dxgc_id);
	}
	ResultObject ro = queryService.search(queryBuilder);
	Gd02_dxgc dxgc = new Gd02_dxgc();
	int startPage = Integer.parseInt(request.getParameter("startPage"));
	int pageCount = 1;
	while(ro.next()){
		dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
		String jsjd = "";
		if(dxgc.getJsjd().intValue() == 1){
			jsjd = "����";
		}else if(dxgc.getJsjd().intValue() == 2){
			jsjd = "Ԥ��";
		}else if(dxgc.getJsjd().intValue() == 3){
			jsjd = "����";
		}else if(dxgc.getJsjd().intValue() == 4){
			jsjd = "����";
		}
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id",dxgc_id);
		queryBuilder1.eq("lb",new String("YB"));
		queryBuilder1.addOrderBy(Order.asc("xh"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		double tzxs = 1.00;//����ϵ��
		double ybhjtzxs =1.00;//�Ǳ�ϼƵ���ϵ��
		double zj =0.00;//�ܼ� 
		double hj = 0.00;//�ϼ�
		double ybsyf= 0.00;//�Ǳ�ʹ�÷�  
		while(ro1.next()){
			Gd06_b3y b3y = (Gd06_b3y)ro1.get(Gd06_b3y.class.getName());
			if(b3y!=null){
				QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd05_b3j.class);
				queryBuilder2.eq("dxgc_id", dxgc_id);
				queryBuilder2.eq("gcxm_id", gcxm_id);
				queryBuilder2.eq("id", b3y.getB3j_id());
				ResultObject ro2 = queryService.search(queryBuilder2);
				Gd05_b3j b3j = new Gd05_b3j();
				if(ro2.next()){
					b3j = (Gd05_b3j)ro2.get(Gd05_b3j.class.getName());
				}
				if(b3y.getTzxs()!=null && b3y.getTzxs().doubleValue()!=0.0){
					tzxs=b3y.getTzxs().doubleValue();
				}
				double sl=0.0;
				if(b3j.getSl()!=null){
					sl=b3j.getSl().doubleValue();
				}
				ybsyf =NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(sl, b3y.getGlsl().doubleValue()),b3y.getDj().doubleValue()),tzxs),ybsyf);
			list.add(b3y);
			}
			tzxs=1.00;//�����ûأ�
		}	
		hj = ybsyf;
		if(dxgc.getB3_ybf_tzxs()!=null){
			ybhjtzxs = dxgc.getB3_ybf_tzxs().doubleValue();
			zj = NumberFormatUtil.mulToDouble(ybsyf,ybhjtzxs);
		}
		if(hj!=0.0){
			Gd06_b3y HJ =new Gd06_b3y();
			HJ.setMc(new String("���������������ϡ�����������"));
			HJ.setDj(new Double(hj));
			list.add(HJ);
		}
		
		if(dxgc.getB3_ybf_tzxs()!=null&&dxgc.getB3_ybf_tzxs().doubleValue()!=1.0){
			Gd06_b3y ZJ = new Gd06_b3y();
			StringBuffer zjmc=new StringBuffer("") ;
			if(dxgc.getB3_ybf_tzxs().doubleValue()!=1.0){
				zjmc= new StringBuffer("�ܡ���");
			}else{
				zjmc = new StringBuffer("���������������ܡ�����������");
			}
			if(dxgc.getB3_ybf_tzxs()!=null&&dxgc.getB3_ybf_tzxs().doubleValue()!=1.0){
				zjmc.append("�����Ϻϼ� ");
				zjmc.append(NumberFormatUtil.roundToString(hj)); 
				zjmc.append("���Ǳ����ϵ�� "+NumberFormatUtil.roundToString(ybhjtzxs));
				zjmc.append("��");
			}
			//else{
			//	zjmc.append(NumberFormatUtil.roundToString(hj));
			//}
			ZJ.setMc(new String(zjmc));	
			ZJ.setDj(new Double(zj));
			if(ro1.getLength()!=0){
				list.add(ZJ);
			}
		}
		Gd06_b3y[] data = (Gd06_b3y[])list.toArray(new Gd06_b3y[list.size()]);	
		int pages = printService.getB3bpages(dxgc.getId()).intValue();
		for(int j = 0; j < pages; j++){	
%>

<pages>
		<table width="257mm">
		  <tr height="20mm">
		   <td width="257mm"><p  font="Simhei" font-size="15pt" align="center">������װ���������Ǳ�ʹ�÷�<%=jsjd%>����������</p></td>
		  </tr>
		</table>
		<table width="257mm">
		  <tr height="5mm">
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">�������ƣ�</p></td>
			<td width="96mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(dxgc.getGcmc())%></p></td>
			<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">���赥λ���ƣ�</p></td>
			<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(dxgc.getJsdw())%></p></td>
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">����ţ�</p></td>
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=dxgc.getBgbh()+"-"+bgbh%></p></td>
			<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">��<%=pageCount%>ҳ�����ܵ�<%=startPage+(pageCount++)%>ҳ</p></td>
		  </tr>
		</table>

		<table width="257mm">
			<tr height="7mm">
				<td width="6mm" rowspan="2" border="1px solid black" border-top="2px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" align="center">���</p></td>
				<td width="20mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">������</p></td>
				<td width="79mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��Ŀ����</p></td>
				<td width="20mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��λ</p></td>
				<td width="20mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">����</p></td>
				<td width="40mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">�Ǳ�����</p></td>
				<td width="36mm" colspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��λ����ֵ</p></td>
				<td width="36mm" colspan="2" border="1px solid black" border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">�ϼ�ֵ</p></td>
			</tr>
			<tr height="7mm">
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">����������(̨��)</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">������(Ԫ)</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">����������(̨��)</p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">�ϡ���(Ԫ)</p></td>
			</tr>
			<tr height="7mm">
				<td width="6mm" border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" align="center">I</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">II</p></td>
				<td width="79mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">III</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">IV</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">V</p></td>
				<td width="40mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VI</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VII</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VIII</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">IX</p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">X</p></td>
			</tr>
			<%
				int b = j * 18;
				int i = j * 18;
				for (; i < b + 18; i++) {
						if (i < list.size() && data[i] != null) {
							PrintB3ybVo b3ybVo = new PrintB3ybVo();
							if(data[i].getBh()!=null){//���ǺϼƲ���
								QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd05_b3j.class);
					  			queryBuilder9.eq("id",data[i].getB3j_id());
					  			ResultObject ro9 = queryService.search(queryBuilder9);
					  			Gd05_b3j data9 = new Gd05_b3j();
					  			if(ro9.next()){
					  				data9 = (Gd05_b3j)ro9.get(Gd05_b3j.class.getName());
					  			}
					  			if(data[i].getXh()!=null){
					  				b3ybVo.setXh(data[i].getXh().toString());
					  			}else{
					  				b3ybVo.setXh(String.valueOf(i+1));
					  			}
					  			b3ybVo.setDebh(data9.getDebh());
					  			b3ybVo.setDemc(data9.getDemc());
					  			b3ybVo.setDw(data9.getDw());
								b3ybVo.setSl(NumberFormatUtil.roundToString(data9.getSl()));
								b3ybVo.setYbmc(data[i].getMc());
								b3ybVo.setDwsl(NumberFormatUtil.roundToString(data[i].getGlsl()));
								b3ybVo.setDwdj(NumberFormatUtil.roundToString(data[i].getDj()));
								b3ybVo.setHjsl(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data9.getSl().doubleValue(),data[i].getGlsl().doubleValue())));
								b3ybVo.setHjjg(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
				    					NumberFormatUtil.mulToDouble(data9.getSl().doubleValue(),data[i].getDj().doubleValue()),data[i].getGlsl().doubleValue()),data[i].getTzxs().doubleValue())));
							}else{
								b3ybVo.setDemc(data[i].getMc());
								b3ybVo.setHjjg(NumberFormatUtil.roundToString(data[i].getDj()));
							}
			%>
			<tr height="7mm">
				<td width="6mm" border="1px solid black" border-left="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center"><%if(b3ybVo.getXh()!=null){out.print(b3ybVo.getXh());}else{out.print("��");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getDebh()!=null){out.print(b3ybVo.getDebh());}else{out.print("��");} %></p></td>
				<td width="79mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getDemc()!=null){out.print(b3ybVo.getDemc());}else{out.print("��");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center"><%if(b3ybVo.getDw()!=null){out.print(b3ybVo.getDw());}else{out.print("��");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getSl()!=null){out.print(NumberFormatUtil.roundToString(b3ybVo.getSl(),3));}else{out.print("��");} %></p></td>
				<td width="40mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getYbmc()!=null){out.print(b3ybVo.getYbmc());}else{out.print("��");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getDwsl()!=null&&!b3ybVo.getDwsl().equals("0.00")){out.print(b3ybVo.getDwsl());}else{out.print("��");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getDwdj()!=null&&!b3ybVo.getDwdj().equals("0.00")){out.print(b3ybVo.getDwdj());}else{out.print("��");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getHjsl()!=null&&!b3ybVo.getHjsl().equals("0.00")){out.print(b3ybVo.getHjsl());}else{out.print("��");} %></p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getHjjg()!=null&&!b3ybVo.getHjjg().equals("0.00")){out.print(b3ybVo.getHjjg());}else{out.print("��");} %>��</p></td>
			</tr>
			<%}else{%>
			<tr height="7mm">
				<td width="6mm" border="1px solid black" border-left="2px solid black"<%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="79mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="40mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
			</tr>
			<%}}%>
		</table>
		<table width="257mm">
		   <tr height="6mm">
			<td width="51mm"><p font="Simsun" font-size="9pt">��Ƹ����ˣ�<%=StringFormatUtil.format(dxgc.getSjfzr())%></p></td>	
			<td width="51mm"><p font="Simsun" font-size="9pt">��ˣ�<%=StringFormatUtil.format(dxgc.getShr()) %></p></td>
			<td width="110mm"><p font="Simsun" font-size="9pt">���ƣ�<%=StringFormatUtil.format(dxgc.getBzr()) %></p></td>
			<td width="18mm"><p font="Simsun" font-size="9pt">�������ڣ�</p></td>
			<td width="27mm" align="left"><p font="Simsun" font-size="9pt"><%=DateFormatUtil.Format(dxgc.getBzrq(),"yyyy��MM��dd��") %></p></td>
		  </tr>
		</table>
	</pages>
<%}}%>
