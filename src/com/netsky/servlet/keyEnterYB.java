package com.netsky.servlet;

import java.io.PrintWriter;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga02_clsb;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.service.QueryService;
/**
 * B3乙丙界面定额按回车键带出相应的定额
 * @author CT
 * @create 2009-05-20
 */
public class keyEnterYB implements Controller {
	/**
	 * 查询Service
	 */
	private QueryService queryService;

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		String fl = new String(request.getParameter("fl"));
		Integer dxgc_id= new Integer(request.getParameter("dxgc_id"));
		Integer gcxm_id= new Integer(request.getParameter("gcxm_id"));
		
		if(fl.equals("1")){//是取材料的
			Gd02_dxgc dxgc= new Gd02_dxgc();
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder99.eq("id", dxgc_id);
			queryBuilder99.eq("gcxm_id", gcxm_id);
			ResultObject ro99 = queryService.search(queryBuilder99);
			if(ro99.next()){
				dxgc = (Gd02_dxgc)ro99.get(Gd02_dxgc.class.getName());
			}
			String clbh="";
			if(request.getParameter("clbh")!=null){
				clbh=request.getParameter("clbh").toUpperCase();
			}
			String lb = "";
			if(request.getParameter("lb")!=null){
				lb = request.getParameter("lb");
			}
			Ga02_clsb clsb = new Ga02_clsb();
			QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Ga02_clsb.class);
			queryBuilder9.eq("bh", clbh);
			queryBuilder9.eq("lb", lb);
			ResultObject ro9 = queryService.search(queryBuilder9);
			out.println("<response>");
			out.println("<clsb>");
			if(ro9.next()){
				clsb = (Ga02_clsb)ro9.get(Ga02_clsb.class.getName());
			}
			String jxbh = "";
			String jxmc = null;
			String jxdw = "";
			String xhgg = null;
			String dj= "";
			if(clsb.getId()!=null){
				jxbh = clsb.getBh();
				jxmc = clsb.getMc();
				jxdw = clsb.getDw();
				if(clsb.getXhgg()!=null){
					xhgg = clsb.getXhgg();
				}
				if(lb.equals("JX")){
					if(dxgc.getB3_jxjg().equals("BDJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getBdj());
					}else if(dxgc.getB3_jxjg().equals("BSJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getBsj());
					}else if(dxgc.getB3_jxjg().equals("QGJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getQgj());
					}else if(dxgc.getB3_jxjg().equals("YSJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getYsj());
					}
				}else{
					if(dxgc.getB3_ybjg().equals("BDJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getBdj());
					}else if(dxgc.getB3_ybjg().equals("BSJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getBsj());
					}else if(dxgc.getB3_ybjg().equals("QGJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getQgj());
					}else if(dxgc.getB3_ybjg().equals("YSJ")){
						dj = new DecimalFormat("##0.00").format(clsb.getYsj());
					}				
				}
			}	
			out.println("<clsb_jxbh>"+jxbh+"</clsb_jxbh>");
			out.println("<clsb_jxmc>"+jxmc+"</clsb_jxmc>");
			out.println("<clsb_jxdw>"+jxdw+"</clsb_jxdw>");
			out.println("<clsb_xhgg>"+xhgg+"</clsb_xhgg>");
			out.println("<clsb_dj>"+dj+"</clsb_dj>");
			out.println("</clsb>");
		}else{//是取定额的
			String bh="";
			if(request.getParameter("bh")!=null){
				bh=request.getParameter("bh").toUpperCase();
			}
	
			Gd05_b3j b3j = new Gd05_b3j();
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
			queryBuilder.eq("debh", bh);
			queryBuilder.eq("dxgc_id", dxgc_id);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			
			out.println("<response>");
			out.println("<de>");
			if(ro.next()){
				b3j=(Gd05_b3j)ro.get(Gd05_b3j.class.getName());	
			}
			String mc = "";
			String dw = "";
			String sl = null;
			Integer id = null;
			if (b3j.getId()!= null) {
				mc = b3j.getDemc();
				dw = b3j.getDw();
				sl = new DecimalFormat("##0.000").format(b3j.getSl());
				id = b3j.getId();
			}
			out.println("<de_bh>"+bh+"</de_bh>");
			out.println("<de_mc>"+mc+"</de_mc>");
			out.println("<de_dw>"+dw+"</de_dw>");
			out.println("<de_sl>"+sl+"</de_sl>");
			out.println("<de_b3jid>"+id+"</de_b3jid>");
			out.println("</de>");
		}
		out.println("</response>");
		out.flush();
		out.close();
	    return new ModelAndView("" + "");
		
	}

}
