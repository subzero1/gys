package com.netsky.servlet;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga12_dez;
import com.netsky.dataObject.Ga13_dej;
import com.netsky.service.QueryService;

/**
 * µÃµ½²àÕÂ½Ú
 * @author CT
 * @create 2009-04-28
 */
public class ShowQuotaZXml implements Controller {
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
		
        Ga13_dej data1=null;
        Integer lb1;
        if(request.getParameter("lb1")!=null&&!"".equals(request.getParameter("lb1"))){
            lb1= new Integer(request.getParameter("lb1"));
        }else{
        	lb1= new Integer(-1);
        }
        QueryBuilder queryBulider1 = new HibernateQueryBuilder(Ga13_dej.class);
        queryBulider1.eq("z_id", lb1);
        ResultObject ro1=queryService.search(queryBulider1);
		out.println("<response>");
		while(ro1.next()){
			data1=(Ga13_dej)ro1.get(Ga13_dej.class.getName());
			if(data1 != null){
				out.print("<lb1>");
				out.print("<lb1_mc>"+data1.getMc()+"</lb1_mc>");
				out.print("<lb1_id>"+ data1.getId()+"</lb1_id>");
				out.print("</lb1>");
			}
		}
		out.println("</response>");
		out.flush();
		out.close();	
	    return new ModelAndView("" + "");
	}
	
}
