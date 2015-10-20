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
import com.netsky.dataObject.Ga06_zy;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.service.QueryService;

public class GsjsXml implements Controller {

	private QueryService queryService;

	private HashMap map = new HashMap();

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		//response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		//request.setCharacterEncoding("utf-8");

		String jsgs = new String(request.getParameter("jsgs").getBytes(
				"iso8859-1"), "utf-8");
		String dxgc_id = request.getParameter("dxgc_id");

		// 取出map需要的初始值-------------
		Gd03_gcfysz gd03;
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);// 取出表里所有数据
		queryBuilder.eq("dxgc_id", Integer.valueOf(dxgc_id));
		queryBuilder.addOrderBy(Order.asc("sxh"));
		ResultObject ro = queryService.search(queryBuilder);

		Gd02_dxgc gd02 = new Gd02_dxgc();
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);
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
		try{
			d = new Double(NumberFormatUtil.roundToDouble(Calculator
					.exec(jsgs, map)));
			out.println(d);
		}catch(Exception e){
			out.println(e);
		}
		out.flush();
		out.close();

		return new ModelAndView("" + "");
	}
}
