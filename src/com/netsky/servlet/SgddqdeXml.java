package com.netsky.servlet;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseFormatUtils.NumberFormatUtil;
import com.netsky.baseObject.Calculator;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga07_qfqj;
import com.netsky.dataObject.Ga08_flmx;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;

public class SgddqdeXml implements Controller {

	private QueryService queryService;
	private ExpenseService expenseService;
	private HashMap map = new HashMap();

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setExpenseService(ExpenseService expenseService) {
		this.expenseService = expenseService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");

		String bz = request.getParameter("bz");

		if ("1".equals(bz)) {
			String b2_yj = request.getParameter("b2_yj");
			if (b2_yj == null || "".equals(b2_yj)) {
				b2_yj = "0";
			}
            double yj = Double.parseDouble(b2_yj);
        	out.println("<response>");
        	out.println("<gg>");
			if (yj >= 0 && yj <= 4400) {
				String HSql = "select ga08 from Ga08_flmx ga08 where qj_id = (select id from Ga07_qfqj ga07 where "
						+ b2_yj
						+ ">ga07.xx and "
						+ b2_yj
						+ " <=ga07.sx and ga07.qjlb='B2DQLC')";
				ResultObject ro = queryService.search(HSql);
				Ga08_flmx ga08 = null;
				if (ro.next()) {
					ga08 = (Ga08_flmx) ro.get("ga08");
				}
				//out.println(ga08.getFlz());
				out.println("<g1>" + ga08.getFlz() + "</g1>");
			}else{
				int yf=1095;				
				while((yj-4400)>=200)
				{
					yf=yf+73;
					yj=yj-200;
				}		
				//out.println(yf);
				out.println("<g1>" + yf + "</g1>");
			}
		
			//查出临时设施费
			String jl= request.getParameter("b2_yj");
			String dxgc_id = request.getParameter("dxgc_id");
			QueryBuilder queryBuilder= new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("id", new Integer(dxgc_id));
			ResultObject ro9 = queryService.search(queryBuilder);
			Gd02_dxgc dxgc = new Gd02_dxgc();
			if(ro9.next()){
				dxgc = (Gd02_dxgc)ro9.get(Gd02_dxgc.class.getName());
			}
			Integer qj_id=null;
			String hql1 = "select ga07 from Ga07_qfqj ga07 where "
				+jl+">ga07.xx and " +jl+"<=ga07.sx and ga07.qjlb='QYGDJL'";
			ResultObject ro100 = queryService.search(hql1);
			Ga07_qfqj qfqj= new Ga07_qfqj();
			if(ro100.next()){
				qfqj = (Ga07_qfqj)ro100.get("ga07");
			}
			if(qfqj.getId()!=null){
				qj_id = qfqj.getId();
			}else{
				String hql2 = "select ga07 from Ga07_qfqj ga07 where  ga07.sx is null  and ga07.qjlb='QYGDJL'";
				ResultObject ro101 = queryService.search(hql2);
				Ga07_qfqj qf= new Ga07_qfqj();
				if(ro101.next()){
					qf = (Ga07_qfqj)ro101.get("ga07");
					qj_id = qf.getId();
				}
			}
			String hql = "select ga08 from Ga08_flmx ga08 where qj_id ="+qj_id+" and flk_id="+dxgc.getFlk_id()+" and zy_id="
				+dxgc.getZy_id();
			ResultObject ro99 = queryService.search(hql);
			Ga08_flmx data99 = new Ga08_flmx();
			if(ro99.next()){
				data99 = (Ga08_flmx)ro99.get("ga08");
			}
			
			out.println("<g2>" + data99.getFlz() + "</g2>");
			out.println("</gg>");
			out.println("</response>");
			
		} else {
			///System.out.println("ddddddddddd");
			// 取出税率值
			String HSql = "select ga08 from Ga08_flmx ga08 where ga08.id=550";
			ResultObject ro2 = queryService.search(HSql);
			Ga08_flmx ga08 = null;
			if (ro2.next()) {
				ga08 = (Ga08_flmx) ro2.get("ga08");
			}

			String jsgs = new String(request.getParameter("jsgs").getBytes(
					"iso8859-1"), "utf-8");
			//jsgs = jsgs + "*" + ga08.getFlz()+"%";
			jsgs = jsgs.replaceAll("\\[税率]",ga08.getFlz()+"%");
			String dxgc_id = request.getParameter("dxgc_id");

			// 取出map需要的初始值-------------
			Gd03_gcfysz gd03;
			QueryBuilder queryBuilder = new HibernateQueryBuilder(
					Gd03_gcfysz.class);// 取出表里所有数据
			queryBuilder.eq("dxgc_id", Integer.valueOf(dxgc_id));
			queryBuilder.addOrderBy(Order.asc("sxh"));
			ResultObject ro = queryService.search(queryBuilder);

			Gd02_dxgc gd02 = new Gd02_dxgc();
			QueryBuilder queryBuilder1 = new HibernateQueryBuilder(
					Gd02_dxgc.class);
			queryBuilder1.eq("id", Integer.valueOf(dxgc_id));
			ResultObject ro1 = queryService.search(queryBuilder1);

			if (ro1.next()) {
				gd02 = (Gd02_dxgc) ro1.get(Gd02_dxgc.class.getName());
			}
			if (gd02.getB2_jxdqdw() != null) {
				map.put("[总吨位]", gd02.getB2_jxdqdw());
			}
			if (gd02.getB5_sczbf_sjdy() != null) {
				map.put("[设计定员]", gd02.getB5_sczbf_sjdy());
			}

			while (ro.next()) {
				gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
				
				if("直接费".equals(gd03.getFymc())&&request.getParameter("zjf")!=null)
				{
					map.put("[" + gd03.getFymc() + "]", request.getParameter("zjf"));
				}
				else if("间接费".equals(gd03.getFymc())&&request.getParameter("jjf")!=null)
				{
					map.put("[" + gd03.getFymc() + "]", request.getParameter("jjf"));
				}
				else if("利润".equals(gd03.getFymc())&&request.getParameter("lr")!=null)
				{
					map.put("[" + gd03.getFymc() + "]", request.getParameter("lr"));
				}
				else if("材料费".equals(gd03.getFymc())&&request.getParameter("clf")!=null)
				{
					map.put("[" + gd03.getFymc() + "]", request.getParameter("clf"));
				}
				else if(gd03.getFyz()==null)
				{
					map.put("[" + gd03.getFymc() + "]", new Integer(0));
				}else{
					map.put("[" + gd03.getFymc() + "]", gd03.getFyz());
				}
			}
			Double d = new Double(0);
			d = new Double(NumberFormatUtil.roundToDouble(Calculator.exec(jsgs,
					map)));
			out.println("<response>");
			out.println("<b2>");
			out.println("<sl>" + ga08.getFlz() + "</sl>");
			out.println("<jg>" + d + "</jg>");
			out.println("<jsgs>" + jsgs + "</jsgs>");
			out.println("</b2>");
			out.println("</response>");
		}
		out.flush();
		out.close();

		return new ModelAndView("" + "");
	}
}
