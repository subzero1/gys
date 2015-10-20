package com.netsky.servlet;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.service.ExpenseService;
import com.netsky.service.SaveService;

public class GcxmDelController implements Controller{
	
	private SaveService saveService;

	public SaveService getSaveService() {
		return saveService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		
		String dxgc_id=request.getParameter("dxgc_id");
		String xmxx=request.getParameter("xmxx");
		String pageRowSize=request.getParameter("pageRowSize");
		if(dxgc_id==null)
		{
		  
		  if("1".equals(xmxx))
		  {
			  String gcdel_id=request.getParameter("gcdel_id");
			  del_xm("Gd01_gcxm","id",gcdel_id);
			  del_xm("Gd02_dxgc","gcxm_id",gcdel_id);
			  del_xm("Gd03_gcfysz","gcxm_id",gcdel_id);
			  del_xm("Gd04_clfysz","gcxm_id",gcdel_id);
			  del_xm("Gd05_b3j","gcxm_id",gcdel_id);
			  del_xm("Gd06_b3y","gcxm_id",gcdel_id);
			  del_xm("Gd07_b4","gcxm_id",gcdel_id);
			  del_xm("Gd09_degl","gcxm_id",gcdel_id);
			  del_xm("Gd10_b3fl","gcxm_id",gcdel_id);
			  response.sendRedirect("../dataManage/projectMain.jsp?gcfl_id="+request.getParameter("gcfl_id"));
		  }else{
			  int i;
			  String[] gcdel_id=request.getParameterValues("gcdel_id");
			  if(gcdel_id!=null)
			  {
			    for(i=0;i<gcdel_id.length;i++)
			    {
			   	  del_xm("Gd01_gcxm","id",gcdel_id[i]);
				  del_xm("Gd02_dxgc","gcxm_id",gcdel_id[i]);
				  del_xm("Gd03_gcfysz","gcxm_id",gcdel_id[i]);
				  del_xm("Gd04_clfysz","gcxm_id",gcdel_id[i]);
				  del_xm("Gd05_b3j","gcxm_id",gcdel_id[i]);
				  del_xm("Gd06_b3y","gcxm_id",gcdel_id[i]);
				  del_xm("Gd07_b4","gcxm_id",gcdel_id[i]);
				  del_xm("Gd09_degl","gcxm_id",gcdel_id[i]);
				  del_xm("Gd10_b3fl","gcxm_id",gcdel_id[i]);
			    }
			  }
			  response.sendRedirect("../dataManage/projectList.jsp?gcfl_id="+request.getParameter("gcfl_id")+"&pageRowSize="+pageRowSize);
		  }
		  
		}
		
		if(dxgc_id!=null)
		{
			del_gc("Gd02_dxgc","id",dxgc_id);
			del_gc("Gd03_gcfysz","dxgc_id",dxgc_id);
			del_gc("Gd04_clfysz","dxgc_id",dxgc_id);
			del_gc("Gd05_b3j","dxgc_id",dxgc_id);
			del_gc("Gd06_b3y","dxgc_id",dxgc_id);
			del_gc("Gd07_b4","dxgc_id",dxgc_id);
			del_gc("Gd09_degl","dxgc_id",dxgc_id);
			del_gc("Gd10_b3fl","dxgc_id",dxgc_id);
			response.sendRedirect("../dataManage/projectMain.jsp?gcxm_id="+request.getParameter("gcxm_id"));
		}
		
		return null;
	}
	
	//删除项目
	public void del_xm(String tab_name,String zd,String gcxm_id)
	{
		String HSql="delete from "+tab_name+" where "+zd+"="+gcxm_id;
		saveService.updateByHSql(HSql);
	}
	//删除单项工程
	public void del_gc(String tab_name,String zd,String dxgc_id)
	{
		String HSql="delete from "+tab_name+" where "+zd+"="+dxgc_id;
		saveService.updateByHSql(HSql);
	}

}
