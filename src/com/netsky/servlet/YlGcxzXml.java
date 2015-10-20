package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.QueryService;

public class YlGcxzXml implements Controller {
	
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

		String dxgc_id=request.getParameter("dxgc_id");
		String HSql3="select gd02 from Gd02_dxgc gd02 where gd02.id ="+dxgc_id;
	    ResultObject ro3 = queryService.search(HSql3);
	    Gd02_dxgc gd=null;
	    String bgxd=null;
	    if(ro3.next()){
	       gd=(Gd02_dxgc)ro3.get("gd02");
	       bgxd=gd.getBgxd();
	    }
	    String HSql4="select gb03 from Gb03_bgxx gb03 where id in ("+bgxd+")";
	    ResultObject ro4 = queryService.search(HSql4);
	    Gb03_bgxx gb03=null;
	    out.println("<response>");
	    while(ro4.next())
	    {
	       gb03=(Gb03_bgxx)ro4.get("gb03");
	       out.println("<bg>");
	       out.println("<bg_mc>"+gb03.getMc()+"</bg_mc>");
	       out.println("<bg_id>"+gb03.getId()+"</bg_id>");
	       out.println("</bg>");
	    }   
	    out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}

}
