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
import com.netsky.dataObject.Ga01_de;
import com.netsky.service.QueryService;
/**
 * 这个servlet用于表三的定额录入,点击键盘Enter键时带出相关定额信息
 * @author CT
 * @create 2009-05-12
 */
public class keyEnter implements Controller {
	/**
	 * 查询Service
	 */
	private QueryService queryService;

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	public static String convertString(String str){
       String upStr = str.toUpperCase();   
       String lowStr = str.toLowerCase();   
       StringBuffer buf = new StringBuffer(str.length());   
       for(int i=0;i<str.length();i++){   
          if(str.charAt(i)==lowStr.charAt(i)){   
              buf.append(upStr.charAt(i));   
          }else{
        	  buf.append(str.charAt(i));
          }
        }   
        return   buf.toString();   
	} 

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		String bh="";
		if(request.getParameter("bh")!=null){
			bh=convertString(request.getParameter("bh"));
		}
		
		
		Ga01_de data=new Ga01_de();
		QueryBuilder queryBuilder= new HibernateQueryBuilder(Ga01_de.class);
		queryBuilder.eq("bh", bh);
		ResultObject ro = queryService.search(queryBuilder);
	
		out.println("<response>");
		out.println("<de>");
		if(ro.next()){
			data=(Ga01_de)ro.get(Ga01_de.class.getName());
		}
		String mc = "";
		String dw = "";
		Double jggr = null;
		Double pggr = null;
		String sl = null;
		if(data!=null){
			mc=data.getMc();
			dw = data.getDw();
			jggr = data.getJggr();
			pggr = data.getPggr();
			sl = new DecimalFormat("##0.000").format(new Double(1.000));
		}
		out.println("<de_bh>"+bh+"</de_bh>");
		out.println("<de_mc>"+mc+"</de_mc>");
		out.println("<de_dw>"+dw+"</de_dw>");
		out.println("<de_jggr>"+jggr+"</de_jggr>");
		out.println("<de_pggr>"+pggr+"</de_pggr>");
		out.println("<de_sl>"+sl+"</de_sl>");
		
		out.println("</de>");
		out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}

}
