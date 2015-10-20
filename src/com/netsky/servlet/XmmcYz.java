package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gd01_gcxm;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.QueryService;

public class XmmcYz implements Controller {
	
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

		String lb=request.getParameter("lb");
		if("xm".equals(lb))
		{
			String xmmc = new String(request.getParameter("xmmc").getBytes("iso8859-1"), "utf-8");
			String gcxm_id=request.getParameter("gcxm_id");
			String HSql="select gd01 from Gd01_gcxm gd01 where xmmc='"+xmmc+"'";
			if(gcxm_id!=null&&!"".equals(gcxm_id))
			{
				HSql=HSql+"and id<>"+gcxm_id;
			}
	        ResultObject ro = queryService.search(HSql);
	        String mcyz="0";
	        if(ro.next()){
	        	mcyz="1";
	        }
	        if(xmmc==null||"".equals(xmmc))
	        {
	        	mcyz="2";
	        }
	        out.print(mcyz);
		}
		if("gc".equals(lb))
        {
			String gcmc = new String(request.getParameter("gcmc").getBytes("iso8859-1"), "utf-8");
			String dxgc_id=request.getParameter("dxgc_id");
			String HSql="select gd02 from Gd02_dxgc gd02 where gcmc='"+gcmc+"'";
			if(dxgc_id!=null&&!"".equals(dxgc_id))
			{
				HSql=HSql+"and id<>"+dxgc_id;
			}
	        ResultObject ro = queryService.search(HSql);
	        String mcyz="0";
	        if(ro.next()){
	        	mcyz="1";
	        }
	        if(gcmc==null||"".equals(gcmc))
	        {
	        	mcyz="2";
	        }
	        out.print(mcyz);
		}
		
		
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
