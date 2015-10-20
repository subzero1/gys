package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga02_clsb;
import com.netsky.service.QueryService;
import com.netsky.baseFormatUtils.StringFormatUtil;

public class getCLSB implements Controller{
	private QueryService queryService;

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		
		String bh=request.getParameter("bh");
		String lb=request.getParameter("lb");
	
		Ga02_clsb data=new Ga02_clsb();
		String qbh = "null",qmc = "null",qxhgg="null",qdw="null",qbdj="null",qbsj="null",qqgj="null",qysj="null",qzclb="null",qgg="null";
		QueryBuilder queryBuilder= new HibernateQueryBuilder(Ga02_clsb.class);
		queryBuilder.eq("bh", bh.toUpperCase());
		queryBuilder.eq("lb", lb);
		ResultObject ro = queryService.search(queryBuilder);
		if(ro.next()){
			data=(Ga02_clsb)ro.get(Ga02_clsb.class.getName());
			qbh = StringFormatUtil.format(data.getBh(),"null");
			qmc = StringFormatUtil.format(data.getMc(),"null");
			qxhgg = StringFormatUtil.format(data.getXhgg(),"null");
			qdw = StringFormatUtil.format(data.getDw(),"null");
			qbdj = StringFormatUtil.format(data.getBdj(),"null");
			qbsj = StringFormatUtil.format(data.getBsj(),"null");
			qqgj = StringFormatUtil.format(data.getQgj(),"null");
			qysj = StringFormatUtil.format(data.getYsj(),"null");
			qzclb = StringFormatUtil.format(data.getZclb(),"null");
			qgg = StringFormatUtil.format(data.getGg(),"null");
		}
		out.println("<response>");
		out.println("<clsb>");
		out.println("<bh>"+qbh+"</bh>");
		out.println("<mc>"+qmc+"</mc>");
		out.println("<xhgg>"+qxhgg+"</xhgg>");
		out.println("<dw>"+qdw+"</dw>");
		out.println("<bdj>"+qbdj+"</bdj>");
		out.println("<bsj>"+qbsj+"</bsj>");
		out.println("<qgj>"+qqgj+"</qgj>");
		out.println("<ysj>"+qysj+"</ysj>");
		out.println("<zclb>"+qzclb+"</zclb>");
		out.println("<gg>"+qgg+"</gg>");
		out.println("</clsb>");
		out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
