package com.netsky.servlet;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
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
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Ga06_zy;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.service.QueryService;
import com.netsky.baseFormatUtils.DateFormatUtil;

public class ShowDxgcXml implements Controller {

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
		
		String gcxm_id = request.getParameter("gcxm_id");
		String HSql="select gd02,ga06,gd03_b1hj,gd03_zgr from Gd02_dxgc gd02,Ga06_zy ga06,Gd03_gcfysz gd03_b1hj,Gd03_gcfysz gd03_zgr where ga06.id=gd02.zy_id and gd02.id=gd03_b1hj.dxgc_id and gd03_b1hj.fymc='工程总费用' and gd02.id=gd03_zgr.dxgc_id and gd03_zgr.fymc='总工日' and gd02.gcxm_id='"+gcxm_id+"'";
		//String HSql="select gd02,ga06,gd08_b1hj,gd08_zgr from Gd02_dxgc gd02,Ga06_zy ga06,(select * from Gd08_hjz where fybh='B1HJ') gd08_b1hj,(select * from Gd08_hjz where fybh='ZGR') gd08_zgr where ga06.id=gd02.zy_id and gd02.id=gd08_b1hj.dxgc_id(+)  and gd02.id=gd08_zgr.dxgc_id(+) and gd02.gcxm_id='"+gcxm_id+"'";
		//String HSql="select tb,gd08_zgr from (select gd02,ga06,gd08_b1hj from Ga06_zy ga06,Gd02_dxgc gd02 left join (select * from Gd08_hjz gd08_b1hj where gd08_b1hj.fybh='B1HJ') gd08_b1hj on gd02.id=gd08_b1hj.dxgc_id where ga06.id=gd02.zy_id and gd02.gcxm_id=1) tb left join (select * from Gd08_hjz gd08_zgr where gd08_zgr.fybh='ZGR') gd08_zgr on tb.id=gd08_zgr.dxgc_id";
		ResultObject ro = queryService.search(HSql);
		out.println("<response>");
		while (ro.next()) {
			Gd02_dxgc gd02=(Gd02_dxgc)ro.get("gd02");
			Ga06_zy ga06=(Ga06_zy)ro.get("ga06");
			Gd03_gcfysz gd03_b1hj=(Gd03_gcfysz)ro.get("gd03_b1hj");
			Gd03_gcfysz gd03_zgr=(Gd03_gcfysz)ro.get("gd03_zgr");
			if (gd02 != null) {
				out.println("<dxgc>");
				out.println("<dxgc_name>"+gd02.getGcmc()+"</dxgc_name>");
				out.println("<dxgc_Gcxz>"+gd02.getGcxz()+"</dxgc_Gcxz>");
				out.println("<dxgc_ZY>"+ga06.getMc()+"</dxgc_ZY>");
				out.println("<dxgc_b1hj>"+gd03_b1hj.getFyz()+"</dxgc_b1hj>");
				out.println("<dxgc_zgr>"+gd03_zgr.getFyz()+"</dxgc_zgr>");
				if(gd02.getCjsj()!=null)
				{
					out.println("<dxgc_Cjsj>"+DateFormatUtil.Format(gd02.getCjsj(),"yyyy-MM-dd")+"</dxgc_Cjsj>");
				}else{
					out.println("<dxgc_Cjsj>"+gd02.getCjsj()+"</dxgc_Cjsj>");
				}	
				out.println("<dxgc_Jsjd>"+gd02.getJsjd()+"</dxgc_Jsjd>");
				out.println("<dxgc_id>"+gd02.getId()+"</dxgc_id>");
				out.println("<dxgc_Gcxm_id>"+gd02.getGcxm_id()+"</dxgc_Gcxm_id>");
				out.println("</dxgc>");
			}
		}
		out.println("</response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
