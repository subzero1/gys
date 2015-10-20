package com.netsky.servlet;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.criterion.Order;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga12_dez;
import com.netsky.dataObject.Ga13_dej;
import com.netsky.service.QueryService;

/**
 * 得到侧章节
 * @author CT
 * @create 2009-04-28
 */
public class ShowQuotaXml implements Controller {
	private QueryService queryService;

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		
		Ga12_dez data=null;
		Integer lb =new Integer(request.getParameter("lb"));
		QueryBuilder queryBuilder=new HibernateQueryBuilder(Ga12_dez.class);
		queryBuilder.eq("c_id", lb);
        ResultObject ro = queryService.search(queryBuilder);
        
        Ga13_dej data1=null;
        Integer zlb=null;
        if(lb.intValue()==1){//如果册选择了第一册这一册开始的章是第一章
        	zlb=new Integer(1);
        }else if(lb.intValue()==2){//如果册选择了第二册这一册开始的章是第7章....
        	zlb=new Integer(7);
        }else if(lb.intValue()==3){
        	zlb=new Integer(11);
        }else if(lb.intValue()==4){
        	zlb=new Integer(15);
        }else if(lb.intValue()==5){
        	zlb=new Integer(22);
        }
        QueryBuilder queryBulider1 = new HibernateQueryBuilder(Ga13_dej.class);
        queryBulider1.eq("c_id", lb);
        queryBulider1.eq("z_id", zlb);
        queryBulider1.addOrderBy(Order.asc("id"));
        ResultObject ro1=queryService.search(queryBulider1);
		out.println("<response>");
		while (ro.next()) {
			data=(Ga12_dez)ro.get(Ga12_dez.class.getName());
			if (data != null) {
				out.println("<lb>");
				out.println("<lb_mc>"+data.getMc()+"</lb_mc>");
				out.println("<lb_id>"+data.getId()+"</lb_id>");
				out.println("</lb>");
			}
		}
		while(ro1.next()){
			data1=(Ga13_dej)ro1.get(Ga13_dej.class.getName());
			if(data1 != null){
				out.println("<lb1>");
				out.println("<lb1_mc>"+data1.getMc()+"</lb1_mc>");
				out.println("<lb1_id>"+ data1.getId()+"</lb1_id>");
				out.println("</lb1>");
			}
		}
		out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
	
}
