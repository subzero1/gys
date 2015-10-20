package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import com.netsky.service.CalculateService;

public class JgfszXml implements Controller {
	
	private CalculateService calculateService;

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}


	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");

		Integer dxgc_id=new Integer(request.getParameter("dxgc_id"));
		String zgs=request.getParameter("zgs");
		String jgf=calculateService.JSDWGLFCalculate(dxgc_id,zgs);
		//out.println("<response>");
		//out.println("<jgf>"+jgf+"</jgf>");
		//out.println("</response>");
		out.println(jgf);
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
