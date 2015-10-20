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
<%@ page import="com.netsky.dataObject.Gd06_b3y"%>
<%@ page import="com.netsky.dataObject.Gd10_b3fl"%>
<%@ page import="com.netsky.dataObject.Gd05_b3j"%>
<%@ page import="com.netsky.dataObject.Ga09_kcxs" %>
<%@ page import="com.netsky.viewObject.PrintB3ybVo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.netsky.baseFormatUtils.NumberFormatUtil"%>
<%@ page import="com.netsky.baseFormatUtils.DateFormatUtil" %>
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
			jsjd = "概算";
		}else if(dxgc.getJsjd().intValue() == 2){
			jsjd = "预算";
		}else if(dxgc.getJsjd().intValue() == 3){
			jsjd = "结算";
		}else if(dxgc.getJsjd().intValue() == 4){
			jsjd = "决算";
		}
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id",dxgc_id);
		queryBuilder1.eq("lb",new String("JX"));
		queryBuilder1.addOrderBy(Order.asc("xh"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		double ckxsValue = 1.00;//拆扩系数
		double tzxs = 1.00;//调整系数
		double jxsyf = 0.00; //机械使用费
		double gytz = 0.00;//高原调整
		double smtz = 0.00;//沙漠调整   
		double zj =0.00;//总计     
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
				//-----------------------------------------------------------------------
				if(b3j.getCk_bz()!=null){// 查询拆扩系数
					QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder99.eq("lb", b3j.getCk_bz());
					queryBuilder99.eq("sort", new Integer(2));//类别1是人工的，2是机械的
					queryBuilder99.ge("jzbh", b3j.getDebh());//定额编号小于等于终止编号
					queryBuilder99.le("qsbh", b3j.getDebh());//定额编号大于等于起始编号
					ResultObject ro99 = queryService.search(queryBuilder99);
					if(ro99.next()){
						Ga09_kcxs ckxs = (Ga09_kcxs)ro99.get(Ga09_kcxs.class.getName());
						if(ckxs!=null){
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//拆扩调整系数
						}
					}
				}
				//-----------------------------------------------------------------------
				jxsyf = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(sl, b3y.getGlsl().doubleValue()),b3y.getDj().doubleValue()),tzxs),ckxsValue),jxsyf);
			list.add(b3y);
			}
			tzxs=1.00;//重新置回１
		}
		if(jxsyf!=0.0){
			Gd06_b3y HJ = new Gd06_b3y();
			HJ.setMc(new String("　　　　　　　合　　　　　计"));
			HJ.setDj(new Double(jxsyf));
			list.add(HJ);//加上合计
		}
		
		
		Gd10_b3fl data12 = new Gd10_b3fl();
		Gd10_b3fl data13 = new Gd10_b3fl();
		if(dxgc.getB3_sgtj_bz()!=null&&dxgc.getB3_sgtj_bz().intValue()==0){// 是非正常地区
			QueryBuilder queryBuilder12 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder12.eq("dxgc_id",dxgc_id);
			queryBuilder12.eq("fylb",new Integer(1));
			queryBuilder12.eq("bz",new Integer(1));//取高原的
			queryBuilder12.eq("flag",new Integer(1));
			ResultObject ro12= queryService.search(queryBuilder12);
			
			if(ro12.next()){
				data12 = (Gd10_b3fl)ro12.get(Gd10_b3fl.class.getName());
			}
			if(data12.getDxgc_id()!=null){
				Gd06_b3y GY = new Gd06_b3y();
				StringBuffer mc = new StringBuffer(data12.getMc());
				mc.append("（合计×");
				mc.append(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(NumberFormatUtil.subToDouble(data12.getJxfl().doubleValue(),1.00),100)));
				mc.append("%）");
				GY.setMc(new String(mc));
				gytz =NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jxsyf,data12.getJxfl().doubleValue()),jxsyf);
				GY.setDj(new Double(gytz));
				if(ro1.getLength()!=0){
					list.add(GY);//加上高原的;
				}
			}
			
			QueryBuilder queryBuilder13 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder13.eq("dxgc_id",dxgc_id);
			queryBuilder13.eq("fylb",new Integer(1));
			queryBuilder13.eq("bz" ,new Integer(2));//取沙漠森林的
			queryBuilder13.eq("flag",new Integer(1));
			ResultObject ro13 = queryService.search(queryBuilder13);
			
			if(ro13.next()){
				data13 = (Gd10_b3fl)ro13.get(Gd10_b3fl.class.getName());
			}
			if(data13.getDxgc_id()!=null){
				Gd06_b3y SM = new Gd06_b3y();
				StringBuffer mc = new StringBuffer(data13.getMc());
				mc.append("（合计×");
				mc.append(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(NumberFormatUtil.subToDouble(data13.getJxfl().doubleValue(),1.00),100)));
				mc.append("%）");
				SM.setMc(new String(mc));
				smtz =NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jxsyf,data13.getJxfl().doubleValue()),jxsyf);
				SM.setDj(new Double(smtz));
				if(ro1.getLength()!=0){
					list.add(SM);//加上沙漠的
				}
			}
		}
		if(data12.getDxgc_id()==null&&data13.getDxgc_id()==null&&dxgc.getB3_jxf_tzxs().doubleValue()==1.0){
		}else{
			Gd06_b3y ZJ = new Gd06_b3y();
			StringBuffer zjmc=new StringBuffer("") ;
			if(dxgc.getB3_jxf_tzxs().doubleValue()!=1.0){
				zjmc= new StringBuffer("总　计");
			}else{
				zjmc = new StringBuffer("　　　　　　　总　　　　　计");
			}
			if(dxgc.getB3_jxf_tzxs()!=null&&dxgc.getB3_jxf_tzxs().doubleValue()!=1.0){//机械使用费合计调整系数
				zjmc.append("（以上合计");
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf,gytz),smtz)));
				zjmc.append("×机械调整系数 "+NumberFormatUtil.roundToString(dxgc.getB3_jxf_tzxs())+"）");
				zj = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf,gytz),smtz), dxgc.getB3_jxf_tzxs().doubleValue());
			}else{
				zj = NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf,gytz),smtz);
			}
			ZJ.setMc(new String(zjmc));
			ZJ.setDj(new Double(zj));
			if(ro1.getLength()!=0){
				list.add(ZJ);
			}
		}
		Gd06_b3y[] data = (Gd06_b3y[])list.toArray(new Gd06_b3y[list.size()]);
		int pages = printService.getB3ypages(dxgc.getId()).intValue();
		for(int j = 0; j < pages; j++){	
%>

<pages>
		<table width="257mm">
		  <tr height="20mm">
		   <td width="257mm"><p  font="Simhei" font-size="15pt" align="center">建筑安装工程机械使用费<%=jsjd%>表（表三）乙</p></td>
		  </tr>
		</table>
		<table width="257mm">
		  <tr height="5mm">
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">工程名称：</p></td>
			<td width="96mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(dxgc.getGcmc())%></p></td>
			<td width="25mm"><p font="Simsun" font-size="9pt" color="black" align="center">建设单位名称：</p></td>
			<td width="46mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=StringFormatUtil.format(dxgc.getJsdw())%></p></td>
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="center">表格编号：</p></td>
			<td width="20mm"><p font="Simsun" font-size="9pt" color="black" align="left"><%=dxgc.getBgbh()+"-"+bgbh%></p></td>
			<td width="30mm"><p font="Simsun" font-size="9pt" color="black" align="center">第<%=pageCount%>页　　总第<%=startPage+(pageCount++)%>页</p></td>
		  </tr>
		</table>

		<table width="257mm">
			<tr height="7mm">
				<td width="6mm" rowspan="2" border="1px solid black"  border-top="2px solid black" border-left="2px solid black"><p font="Simsun" font-size="9pt" align="center">序号</p></td>
				<td width="20mm" rowspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">定额编号</p></td>
				<td width="83mm" rowspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">项目名称</p></td>
				<td width="18mm" rowspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">单位</p></td>
				<td width="18mm" rowspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">数量</p></td>
				<td width="40mm" rowspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">机械名称</p></td>
				<td width="36mm" colspan="2" border="1px solid black"  border-top="2px solid black"><p font="Simsun" font-size="9pt" align="center">单位定额值</p></td>
				<td width="36mm" colspan="2" border="1px solid black"  border-top="2px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">合计值</p></td>
			</tr>
			<tr height="7mm">
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">　数　量　(台班)</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">单　价(元)</p></td>
				<td width="18mm" border="1px solid black"><p font="Simsun" font-size="9pt" align="center">　数　量　(台班)</p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black"><p font="Simsun" font-size="9pt" align="center">合　价(元)</p></td>
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
							if(data[i].getBh()!=null){//不是合计部分
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
					  			//----------------是有拆扩系数的-------------
					  			StringBuffer mc = new StringBuffer(data9.getDemc());
					  			double ckxsz =1.00;//拆扩系数
					  			if (data9.getCk_bz() != null) {// 查询拆扩系数
									QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Ga09_kcxs.class);
									queryBuilder4.eq("lb", data9.getCk_bz());
									queryBuilder4.eq("sort",new Integer(2));//类别：1是人工的；2是机械的
									queryBuilder4.ge("jzbh", data9.getDebh());//定额编号小于等于终止编号
									queryBuilder4.le("qsbh", data9.getDebh());//定额编号大于等于起始编号
									ResultObject ro4 = queryService.search(queryBuilder4);
									Ga09_kcxs ckxs = new Ga09_kcxs();
									if (ro4.next()) {
										ckxs = (Ga09_kcxs) ro4.get(Ga09_kcxs.class.getName());
										if (ckxs != null) {
											if (data9.getCk_bz().intValue() == 1) {
												mc.append("（新建 机械×");
											} else if (data9.getCk_bz().intValue() == 2) {
												mc.append("（扩建 机械×");
											} else if (data9.getCk_bz().intValue() == 3) {
												mc.append("（拆除再利用 机械×");
											} else if (data9.getCk_bz().intValue() == 4) {
												mc.append("（拆除不再利用 机械×");
											} else if (data9.getCk_bz().intValue() == 5) {
												mc.append("（更换 机械×");
											}
											mc.append(NumberFormatUtil.roundToString(ckxs.getXs().doubleValue()));
											mc.append("%）");
											ckxsz = NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);
										}
									}
								}
					  			b3ybVo.setDemc(new String(mc));
					  			b3ybVo.setDw(data9.getDw());
								b3ybVo.setSl(NumberFormatUtil.roundToString(data9.getSl()));
								b3ybVo.setJxmc(data[i].getMc());
								b3ybVo.setDwsl(NumberFormatUtil.roundToString(data[i].getGlsl()));
								b3ybVo.setDwdj(NumberFormatUtil.roundToString(data[i].getDj()));
								b3ybVo.setHjsl(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data9.getSl().doubleValue(),data[i].getGlsl().doubleValue())));
								b3ybVo.setHjjg(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
									data9.getSl().doubleValue(),data[i].getDj().doubleValue()),data[i].getGlsl().doubleValue()),data[i].getTzxs().doubleValue()),ckxsz)));
							}else{
								b3ybVo.setDemc(data[i].getMc());
								b3ybVo.setHjjg(NumberFormatUtil.roundToString(data[i].getDj()));
							}
			%>
			<tr height="7mm">
				<td width="6mm" border="1px solid black" border-left="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center"><%if(b3ybVo.getXh()!=null){out.print(b3ybVo.getXh());}else{out.print("　");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getDebh()!=null){out.print(b3ybVo.getDebh());}else{out.print("　");} %></p></td>
				<td width="79mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getDemc()!=null){out.print(b3ybVo.getDemc());}else{out.print("　");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center"><%if(b3ybVo.getDw()!=null){out.print(b3ybVo.getDw());}else{out.print("　");} %></p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getSl()!=null){out.print(NumberFormatUtil.roundToString(b3ybVo.getSl(),3));}else{out.print("　");} %></p></td>
				<td width="40mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left"><%if(b3ybVo.getJxmc()!=null){out.print(b3ybVo.getJxmc());}else{out.print("　");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getDwsl()!=null&&!b3ybVo.getDwsl().equals("0.00")){out.print(b3ybVo.getDwsl());}else{out.print("　");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getDwdj()!=null&&!b3ybVo.getDwdj().equals("0.00")){out.print(b3ybVo.getDwdj());}else{out.print("　");} %></p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getHjsl()!=null&&!b3ybVo.getHjsl().equals("0.00")){out.print(b3ybVo.getHjsl());}else{out.print("　");} %></p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right"><%if(b3ybVo.getHjjg()!=null&&!b3ybVo.getHjjg().equals("0.00")){out.print(b3ybVo.getHjjg());}else{out.print("　");} %>　</p></td>
			</tr>
			<%}else{%>
			<tr height="7mm">
				<td width="6mm" border="1px solid black" border-left="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="center">　</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">　</p></td>
				<td width="79mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">　</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="left">　</p></td>
				<td width="20mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
				<td width="40mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
				<td width="18mm" border="1px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
				<td width="18mm" border="1px solid black" border-right="2px solid black" <%if((i+1) % 18 ==0){out.print(" border-bottom=\"2px solid black\"");} %>><p font="Simsun" font-size="9pt" align="right">　</p></td>
			</tr>
			<%}}%>
		</table>
		<table width="257mm">
		   <tr height="6mm">
			<td width="51mm"><p font="Simsun" font-size="9pt">设计负责人：<%=StringFormatUtil.format(dxgc.getSjfzr()) %></p></td>	
			<td width="51mm"><p font="Simsun" font-size="9pt">审核：<%=StringFormatUtil.format(dxgc.getShr()) %></p></td>
			<td width="110mm"><p font="Simsun" font-size="9pt">编制：<%=StringFormatUtil.format(dxgc.getBzr()) %></p></td>
			<td width="18mm"><p font="Simsun" font-size="9pt">编制日期：</p></td>
			<td width="27mm" align="left"><p font="Simsun" font-size="9pt"><%=DateFormatUtil.Format(dxgc.getBzrq(),"yyyy年MM月dd日") %></p></td>
		  </tr>
		</table>
	</pages>
<%}}%>