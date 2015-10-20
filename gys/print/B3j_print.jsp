<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.netsky.baseObject.ServiceName"%>
<%@ page import="com.netsky.service.QueryService"%>
<%@ page import="com.netsky.service.PrintService" %>
<%@ page import="com.netsky.baseObject.QueryBuilder"%>
<%@ page import="com.netsky.baseObject.HibernateQueryBuilder"%>
<%@ page import="com.netsky.baseObject.ResultObject"%>
<%@ page import="com.netsky.dataObject.Gd05_b3j"%>
<%@ page import="com.netsky.dataObject.Gd02_dxgc"%>
<%@ page import="com.netsky.dataObject.Gd10_b3fl"%>
<%@ page import="com.netsky.dataObject.Ga09_kcxs"%>
<%@ page import="com.netsky.viewObject.PrintB3jVO"%>
<%@ page import="org.hibernate.criterion.Order"%>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.DateFormatUtil" %>
<%@ page import="com.netsky.baseFormatUtils.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>

<%
    List list=new ArrayList();
	request.setCharacterEncoding("gb2312");
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
	PrintService printService = (PrintService) ctx.getBean(ServiceName.PrintService);
	QueryService queryService = (QueryService) ctx.getBean(ServiceName.QueryService);
	
	Integer dxgc_id=new Integer(request.getParameter("dxgc_id"));
	Integer gcxm_id=new Integer(request.getParameter("gcxm_id"));
	String bgbh = request.getParameter("bgbh");
	int B3j_onePageRows = printService.getB3j_onePageRows();
	int startPage = Integer.parseInt(request.getParameter("startPage"));
	
	QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd02_dxgc.class);
	queryBuilder9.eq("gcxm_id",gcxm_id);
	if(dxgc_id!=null){
		queryBuilder9.eq("id", dxgc_id);
	}
	ResultObject ro9 = queryService.search(queryBuilder9);
	Gd02_dxgc dxgc = new Gd02_dxgc();
	int pageCount = 1;
	while(ro9.next()){
		dxgc = (Gd02_dxgc) ro9.get(Gd02_dxgc.class.getName());
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
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
		queryBuilder.eq("dxgc_id",dxgc.getId());
		queryBuilder.addOrderBy(Order.asc("xh"));
		ResultObject ro = queryService.search(queryBuilder);
		double ckxsValue = 1.00;//����ϵ��
		double tzxs = 1.00;//����ϵ��	
		double jgsum = 0.00;//�������պϼ�
		double jhj= 0.00;//�ϼ�
		double phj= 0.00;//�ϼ�
		double pgsum = 0.00;//�չ����պϼ�
		double zgrSum = 0.00;//�ܹ���
		double kjjg = 0.00;//ȫ��������������
		double kjpg = 0.00;//ȫ�������չ�����
		double gyjg = 0.00;//��ԭ����������������
		double gypg = 0.00;//��ԭ�����չ���������
		double smjg = 0.00;//ɳĮ����������������
		double smpg = 0.00;//ɳĮ�����չ���������
		double xgrj = 0.00;//����С���յ���
		double xgrp = 0.00;//�չ�С���յ��� 
		while(ro.next()){
			Gd05_b3j b3j=(Gd05_b3j)ro.get(Gd05_b3j.class.getName());
			if(b3j!=null){
			list.add(b3j);
				if(b3j.getCk_bz()!=null){// ��ѯ����ϵ��
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder1.eq("lb", b3j.getCk_bz());
					queryBuilder1.ge("jzbh", b3j.getDebh());//������С�ڵ�����ֹ���
					queryBuilder1.le("qsbh", b3j.getDebh());//�����Ŵ��ڵ�����ʼ���
					ResultObject ro1 = queryService.search(queryBuilder1);
					if(ro1.next()){
						Ga09_kcxs ckxs = (Ga09_kcxs)ro1.get(Ga09_kcxs.class.getName());
						if(ckxs!=null){
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//��������ϵ��
						}
					}
				}
				if(b3j.getTzxs()!=null && b3j.getTzxs().doubleValue()!=0.0){
					tzxs=b3j.getTzxs().doubleValue();
				}
				jgsum=NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue), jgsum));
				pgsum=NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue), pgsum));			
			}
			tzxs =1.00;
			ckxsValue =1.00;//�����û�1
		}
		jhj=jgsum;
		phj =pgsum;
		if(ro.getLength()!=0){
			Gd05_b3j HJ = new Gd05_b3j();
			HJ.setDemc("�����������������������ϡ�����������");
			HJ.setJggr(new Double(jhj));
			HJ.setPggr(new Double(phj));
			list.add(HJ);
		}
		
		Gd05_b3j GY = new Gd05_b3j();
		Gd05_b3j SM = new Gd05_b3j();
		if(dxgc.getB3_sgtj_bz()!=null&&dxgc.getB3_sgtj_bz().intValue()==0){// �Ƿ���������
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id",dxgc_id);
			queryBuilder99.eq("fylb",new Integer(1));
			queryBuilder99.eq("bz",new Integer(1));//ȡ��ԭ��
			queryBuilder99.eq("flag", new Integer(1));
			ResultObject ro99 = queryService.search(queryBuilder99);
			Gd10_b3fl data99 = new Gd10_b3fl();
			if(ro99.next()){
				data99 = (Gd10_b3fl)ro99.get(Gd10_b3fl.class.getName());
			}
			if(data99!=null&&data99.getRgfl()!=null){
				gyjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(jhj,NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),1.00)));
				gypg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(phj,NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),1.00)));
				jgsum = NumberFormatUtil.mulToDouble(jgsum,data99.getRgfl().doubleValue());//���Ը�ԭ��ϵ��
				pgsum = NumberFormatUtil.mulToDouble(pgsum,data99.getRgfl().doubleValue());
				
				StringBuffer mc= new StringBuffer("");
				mc.append(data99.getMc());
				mc.append(" �������� "+NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),1.00),100)+"%");
				if(ro.getLength()!=0){
					GY.setDemc(new String(mc));
					GY.setJggr(new Double(gyjg));
					GY.setPggr(new Double(gypg));
					if(GY!=null){
						list.add(GY);
					}
				}
			}
	
			QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder100.eq("dxgc_id",dxgc_id);
			queryBuilder100.eq("fylb",new Integer(1));
			queryBuilder100.eq("bz",new Integer(2));//ȡɳĮɭ�ֵ�
			queryBuilder100.eq("flag", new Integer(1));
			ResultObject ro100 = queryService.search(queryBuilder100);

			Gd10_b3fl data100 = new Gd10_b3fl();
			if(ro100.next()){
				data100 = (Gd10_b3fl)ro100.get(Gd10_b3fl.class.getName());
			}
			if(data100!=null && data100.getRgfl()!=null){
				smjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(jhj,NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(),1.00)));
				smpg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(phj,NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(),1.00)));
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data100.getRgfl().doubleValue());//����ɳĮɭ�ֵ�ϵ��
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data100.getRgfl().doubleValue());
				StringBuffer mc= new StringBuffer("");
				mc.append(data100.getMc());
				mc.append("���������� "+NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(),1.00),100)+"%");
				if(ro.getLength()!=0){
					SM.setDemc(new String(mc));
					SM.setJggr(new Double(smjg));
					SM.setPggr(new Double(smpg));
					if(SM!=null){
						list.add(SM);
					}
				}
			}
		}
		
		Gd05_b3j XGR = new Gd05_b3j();
		zgrSum=NumberFormatUtil.addToDouble(jgsum, pgsum);
		if(dxgc.getZy_id().intValue()==1||dxgc.getZy_id().intValue()==2){//����ǹ��߹��̼���С���յ���
			if(dxgc.getXgr_bz()!=null&&dxgc.getXgr_bz().intValue()==0){//0��Ҫ����С���յ���
				if(100<zgrSum&&zgrSum<=250){
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder3 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder3.eq("dxgc_id", dxgc_id);
					queryBuilder3.eq("fylb", new Integer(3));
					queryBuilder3.eq("bz", new Integer(250));
					ResultObject ro3 = queryService.search(queryBuilder3);
					if(ro3.next()){
						xgr = (Gd10_b3fl)ro3.get(Gd10_b3fl.class.getName());
					}
					if(xgr!=null){
						zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
						jgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jgsum,  xgr.getRgfl().doubleValue()),jgsum));
						pgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl().doubleValue()),pgsum));
						StringBuffer mc= new StringBuffer("");
						mc.append("С���չ��̵��������Ϻϼơ�"+NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(),1.00),100)+"%��");
						
						xgrj = jgsum;
						xgrp = pgsum;
						if(ro.getLength()!=0){
							XGR.setDemc(new String(mc));
							XGR.setJggr(new Double(xgrj));
							XGR.setPggr(new Double(xgrp));
							if(XGR!=null){
								list.add(XGR);
							}
						}
					}
				}
				if(zgrSum<=100){
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder4.eq("dxgc_id", dxgc_id);
					queryBuilder4.eq("fylb", new Integer(3));
					queryBuilder4.eq("bz", new Integer(100));
					ResultObject ro4 = queryService.search(queryBuilder4);
					if(ro4.next()){
						xgr = (Gd10_b3fl)ro4.get(Gd10_b3fl.class.getName());
					}
					if(xgr!=null){
						zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
						jgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jgsum,  xgr.getRgfl().doubleValue()),jgsum));
						pgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl().doubleValue()),pgsum));
						StringBuffer mc= new StringBuffer("");
						mc.append("С���չ��̵��������Ϻϼơ�"+NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(),1.00),100)+"%��");
						xgrj = jgsum;
						xgrp = pgsum;
						if(ro.getLength()!=0){
							XGR.setDemc(new String(mc));
							XGR.setJggr(new Double(xgrj));
							XGR.setPggr(new Double(xgrp));
							if(XGR!=null){
								list.add(XGR);
							}
						}
					}
				}
			}
		}
		
		Gd05_b3j KJ = new Gd05_b3j();
		if(dxgc.getGcxz()!=null&&dxgc.getGcxz().intValue()==2){//ȫ���������̹��յ�������
			Gd10_b3fl data99 = new Gd10_b3fl();
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("fylb", new Integer(3));
			queryBuilder99.eq("mc", new String("ȫ���������̹��յ�������"));
			ResultObject ro99 = queryService.search(queryBuilder99);
			if(ro99.next()){
				data99 = (Gd10_b3fl)ro99.get(Gd10_b3fl.class.getName());
			}
			if(data99.getId()!=null&&data99.getRgfl()!=null){
				kjjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jhj, data99.getRgfl().doubleValue()),jhj));
				kjpg = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(phj, data99.getRgfl().doubleValue()),phj));
				StringBuffer mc= new StringBuffer("");
				mc.append("ȫ���������̹��յ������ʣ��ϼơ�"+NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),1.00),100)+"%��");
				
				if(ro.getLength()!=0){
					KJ.setDemc(new String(mc));
					KJ.setJggr(new Double(kjjg));
					KJ.setPggr(new Double(kjpg));
					if(KJ!=null){
						list.add(KJ);
					}
				}
			}
		}
		
		if(GY.getDemc()==null&&SM.getDemc()==null&&XGR.getDemc()==null&&KJ.getDemc()==null&&dxgc.getB3_jggr_tzxs().doubleValue()==1.0&&dxgc.getB3_pggr_tzxs().doubleValue()==1.0){
		}else{
			//�����ܼ�
			double zjjg=0.00;//�ܼƼ�������
			double zjpg=0.00;//�ܼ��չ�����
			StringBuffer zjmc=new StringBuffer("") ;
			if(dxgc.getB3_jggr_tzxs().doubleValue()!=1.0||dxgc.getB3_pggr_tzxs().doubleValue()!=1.0){
				zjmc= new StringBuffer("�ܡ���");
			}else{
				zjmc = new StringBuffer("�����������������������ܡ�����������");
			}
			
			if(dxgc.getB3_jggr_tzxs()!=null&&dxgc.getB3_jggr_tzxs().doubleValue()!=1.0){
				zjmc.append("���������� ");
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(jhj,gyjg),smjg),xgrj),kjjg)));
				zjmc.append("��"+NumberFormatUtil.roundToString(dxgc.getB3_jggr_tzxs()));	
				if(dxgc.getB3_pggr_tzxs().doubleValue()==1.0){
					zjmc.append("��");
				}else{
					zjmc.append("��");
				}
				zjjg =  NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(jhj,gyjg),smjg),xgrj),kjjg),dxgc.getB3_jggr_tzxs().doubleValue());
			}
			else{
				zjjg =  NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(jhj,gyjg),smjg),xgrj),kjjg);
			}
			if(dxgc.getB3_pggr_tzxs()!=null&&dxgc.getB3_pggr_tzxs().doubleValue()!=1.0){
				if(dxgc.getB3_jggr_tzxs().doubleValue()==1.0){
					zjmc.append("���չ����� ");
				}else{
					zjmc.append("�չ����� ");
				}
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(phj,gypg),smpg),xgrp),kjpg)));
				zjmc.append("��"+NumberFormatUtil.roundToString(dxgc.getB3_pggr_tzxs())+"��");
				zjpg =  NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(phj,gypg),smpg),xgrp),kjpg),dxgc.getB3_pggr_tzxs().doubleValue());
			}
			else{
				zjpg =  NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
					NumberFormatUtil.addToDouble(phj,gypg),smpg),xgrp),kjpg);
			}
			Gd05_b3j ZJ = new Gd05_b3j();
			ZJ.setDemc(new String(zjmc));
			ZJ.setJggr(new Double(zjjg));
			ZJ.setPggr(new Double(zjpg));
			if(ro.getLength()!=0){
				list.add(ZJ);//���ܼƼӵ��б���
			}
		}
		Gd05_b3j[] data =(Gd05_b3j[]) list.toArray(new Gd05_b3j[list.size()]);
		
		int pages = printService.getB3jpages(dxgc.getId()).intValue();
		for(int j = 0; j < pages; j++){	
		
%>
	<pages>
		<table width="257mm">
		  <tr height="20mm">
		   <td width="257mm"><p  font="Simhei" font-size="15pt" align="center">������װ������<%=jsjd%>��(��������</p></td>
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
				<td width="12mm" rowspan="2" border="1px solid black" border-top="2px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" align="center">���</p></td>
				<td width="20mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">������</p></td>
				<td width="97mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��Ŀ����</p></td>
				<td width="24mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��λ</p></td>
				<td width="24mm" rowspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">����</p></td>
				<td width="40mm" colspan="2" border="1px solid black" border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">��λ����ֵ�����գ�</p></td>
				<td width="40mm" colspan="2" border="1px solid black" border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">�ϼ�ֵ�����գ�</p></td>
			</tr>
			<tr height="7mm">
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">����</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">�չ�</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">����</p></td>
				<td width="20mm" border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">�չ�</p></td>
			</tr>
			<tr height="7mm">
				<td width="12mm" border="1px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" align="center">I</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">II</p></td>
				<td width="97mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">III</p></td>
				<td width="24mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">IV</p></td>
				<td width="24mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">V</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VI</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VII</p></td>
				<td width="20mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">VIII</p></td>
				<td width="20mm" border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">IX</p></td>
			</tr>
			
		<%
			int b = j * 18;
			int i = j * 18;
			for (; i < b + 18; i++) {
				if (i < list.size() && data[i] != null) {
				String jg = "" ;// ����������ϼ�
				String pg = "" ; //���������չ��ϼ�
				PrintB3jVO b3vo = new PrintB3jVO();
				if(data[i].getXh()!=null){// ��������Ų����ڿ�,���Ǻϼ�ʲô�Ĳ������ⲿ��
					b3vo.setXh(data[i].getXh());
					b3vo.setDebh(data[i].getDebh());

					if (data[i].getTzxs() != null) {
						jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
							data[i].getSl().doubleValue(),data[i].getJggr().doubleValue()),data[i].getTzxs().doubleValue()));
					} else {
						jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data[i].getSl().doubleValue(),
							 data[i].getJggr().doubleValue()));
					}
					if (data[i].getTzxs() != null) {
						pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
							data[i].getSl().doubleValue(),data[i].getPggr().doubleValue()),data[i].getTzxs().doubleValue()));
					} else {
						pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data[i].getSl().doubleValue(),
							 data[i].getPggr().doubleValue()));
					}
					StringBuffer mc = new StringBuffer(data[i].getDemc());
					if (data[i].getCk_bz() != null) {// ��ѯ����ϵ��
						QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Ga09_kcxs.class);
						queryBuilder4.eq("lb", data[i].getCk_bz());
						queryBuilder4.eq("sort",new Integer(1));//���1���˹��ģ�2�ǻ�е��
						queryBuilder4.ge("jzbh", data[i].getDebh());//������С�ڵ�����ֹ���
						queryBuilder4.le("qsbh", data[i].getDebh());//�����Ŵ��ڵ�����ʼ���
						ResultObject ro1 = queryService.search(queryBuilder4);
						Ga09_kcxs ckxs = new Ga09_kcxs();
						if (ro1.next()) {
							ckxs = (Ga09_kcxs) ro1.get(Ga09_kcxs.class.getName());
							if (ckxs != null) {
								if (data[i].getCk_bz().intValue() == 1) {
									mc.append("���½� ���ա�");
								} else if (data[i].getCk_bz().intValue() == 2) {
									mc.append("������ ���ա�");
								} else if (data[i].getCk_bz().intValue() == 3) {
									mc.append("����������� ���ա�");
								} else if (data[i].getCk_bz().intValue() == 4) {
									mc.append("������������� ���ա�");
								} else if (data[i].getCk_bz().intValue() == 5) {
									mc.append("������ ���ա�");
								}
								mc.append(NumberFormatUtil.roundToString(ckxs.getXs().doubleValue()));
								mc.append("%��");
								jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(jg,NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(),100))));//����������ϼ��ٳ���ϵ��
								pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(pg,NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(),100))));
							}
						}
					}
					if (data[i].getTzxs() != null&& data[i].getTzxs().doubleValue() != 1.00) {
						mc.append("�����յ��� ���ա�");
						mc.append(NumberFormatUtil.roundToString(data[i].getTzxs()));
						mc.append("��");
					}
					b3vo.setDemc(new String(mc));
					b3vo.setDw(data[i].getDw());
					b3vo.setSl(data[i].getSl());
					b3vo.setJggr(data[i].getJggr());
					b3vo.setPggr(data[i].getPggr());
					b3vo.setJghj(jg);
					b3vo.setPghj(pg);
				}else{
					b3vo.setDemc(data[i].getDemc());
					b3vo.setJghj(NumberFormatUtil.roundToString(data[i].getJggr()));
					b3vo.setPghj(NumberFormatUtil.roundToString(data[i].getPggr()));
				}
			
		%>
			<tr height="7mm">
				<td width="12mm" border="1px solid black" border-left="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="" font-size="9pt" align="center"><%if(b3vo.getXh()!=null){out.print(b3vo.getXh());}else{out.print("��");}%></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3vo.getDebh()!=null){out.print(b3vo.getDebh());}else{out.print("��");}%></p></td>
				<td width="97mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3vo.getDemc()!=null){out.print(b3vo.getDemc());}else{out.print("��");}%></p></td>
				<td width="24mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center"><%if(b3vo.getDw()!=null){out.print(b3vo.getDw());}else{out.print("��");}%></p></td>
				<td width="24mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3vo.getSl()!=null){out.print(NumberFormatUtil.roundToString(b3vo.getSl(),3));}else{out.print("��");}%></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3vo.getJggr()!=null&&b3vo.getJggr().doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString(b3vo.getJggr()));}else{out.print("��");}%></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3vo.getPggr()!=null&&b3vo.getPggr().doubleValue()!=0.0){out.print(NumberFormatUtil.roundToString(b3vo.getPggr()));}else{out.print("��");}%></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3vo.getJghj()!=null&&!b3vo.getJghj().equals("0.00")){out.print(b3vo.getJghj());}else{out.print("��");}%></p></td>
				<td width="20mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3vo.getPghj()!=null&&!b3vo.getPghj().equals("0.00")){out.print(b3vo.getPghj());}else{out.print("��");}%></p></td>
			</tr>
			<%} else {%>
			<tr height="7mm">
				<td width="12mm" border="1px solid black" border-left="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="97mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="24mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">��</p></td>
				<td width="24mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
				<td width="20mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">��</p></td>
			</tr>
			<%}}%>	
		</table>
		<table width="257mm">
		   <tr height="6mm">
			<td width="51mm"><p font="Simsun" font-size="9pt">��Ƹ����ˣ�<%=StringFormatUtil.format(dxgc.getSjfzr()) %></p></td>	
			<td width="51mm"><p font="Simsun" font-size="9pt">��ˣ�<%=StringFormatUtil.format(dxgc.getShr()) %></p></td>
			<td width="110mm"><p font="Simsun" font-size="9pt">���ƣ�<%=StringFormatUtil.format(dxgc.getBzr()) %></p></td>
			<td width="18mm"><p font="Simsun" font-size="9pt">�������ڣ�</p></td>
			<td width="27mm" align="left"><p font="Simsun" font-size="9pt"><%=DateFormatUtil.Format(dxgc.getBzrq(),"yyyy��MM��dd��") %></p></td>
		  </tr>
		</table>

	</pages>
	<%}}%>
