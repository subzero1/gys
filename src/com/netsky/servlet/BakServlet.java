package com.netsky.servlet;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.service.ExportService;
import com.netsky.viewObject.BakVo;
import com.netsky.dataObject.Gb01_yhb;

public class BakServlet implements Controller {

	private ExportService exportService;
	
	public ExportService getExportService() {
		return exportService;
	}

	public void setExportService(ExportService exportService) {
		this.exportService = exportService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		
		String flag = formatStr(request.getParameter("flag"),"exp");
		if(flag.equals("exp")){
			response.setContentType("application/octet-stream");
			ArrayList dataList = new ArrayList();
			String[] prjids = request.getParameterValues("prj_id");
			for(int i=0;i<prjids.length;i++){
				String[] spids = request.getParameterValues("spid_"+prjids[i]);
				BakVo bak = exportService.expBak(prjids[i],spids);
				dataList.add(bak);
			}
			OutputStream o = response.getOutputStream();
			ObjectOutputStream outS = new ObjectOutputStream(o);
			outS.writeObject(dataList);
			outS.flush();
			return new ModelAndView("");
		}else if(flag.equals("imp")){
			Gb01_yhb yh=(Gb01_yhb)request.getSession().getAttribute("yhb");
			ArrayList bakobj = (ArrayList)request.getSession().getAttribute("bakobj");
			String gcfl = request.getParameter("gcfl");
			String op = formatStr(request.getParameter("op"),"0");
			String[] prjids = request.getParameterValues("prj_id");
			for(int i=0;i<prjids.length;i++){
				String[] spids = request.getParameterValues("spid_"+prjids[i]);
				exportService.impBak(prjids[i], spids, bakobj, gcfl, op, yh.getId().toString(), yh.getName());
			}
			return new ModelAndView("redirect:../dataManage/import.jsp");
		}else{
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			boolean exist = false;
			Gb01_yhb yh=(Gb01_yhb)request.getSession().getAttribute("yhb");
			ArrayList bakobj = (ArrayList)request.getSession().getAttribute("bakobj");
			String[] prjids = request.getParameterValues("prj_id");
			for(int i=0;i<prjids.length;i++){
				String[] spids = request.getParameterValues("spid_"+prjids[i]);
				exist = exportService.impValid(prjids[i], spids, bakobj, yh.getId().toString());
				if(exist)
					break;
			}
			out.println("<response><exist>"+exist+"</exist></response>");
			out.flush();
			out.close();
			return new ModelAndView("");
		}
		
	}
	
	public String formatStr(String str1,String str2){
		if(str1==null||str1.equals(""))
			return str2;
		return str1;
	}
}
