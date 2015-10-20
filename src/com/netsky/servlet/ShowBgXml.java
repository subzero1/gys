package com.netsky.servlet;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;

import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.QueryService;

public class ShowBgXml implements Controller {

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

		String dxgc_id=request.getParameter("gd02_id");
		String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ='"+Integer.parseInt(dxgc_id)+"'";
        ResultObject ro3 = queryService.search(HSql3);
        Gd02_dxgc gd02=null;
        if(ro3.next()){
           gd02=(Gd02_dxgc)ro3.get("gd02");
        }else{
        	gd02=new Gd02_dxgc();
        }
        String bgxd=gd02.getBgxd();
        String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
        ResultObject ro4 = queryService.search(HSql4);
		out.println("<response>");
        while(ro4.next())
        {
             Gb03_bgxx gb03=null;
             gb03=(Gb03_bgxx)ro4.get("gb03");
             String mc=gb03.getFbt();
             if(mc==null||"".equals(mc))
             {
            	mc=gb03.getMc();
             }
			if (gb03 != null) {
				out.println("<bgxx>");
				out.println("<bgxx_mc>"+mc+"</bgxx_mc>");
				out.println("<bgxx_url>"+gb03.getBdwj()+"</bgxx_url>");
				out.println("</bgxx>");
			}
		}
		out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
