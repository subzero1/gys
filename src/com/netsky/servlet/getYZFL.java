package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga08_flmx;
import com.netsky.dataObject.Ga07_qfqj;
import com.netsky.service.QueryService;
import com.netsky.baseFormatUtils.StringFormatUtil;
import com.netsky.baseFormatUtils.NumberFormatUtil;

public class getYZFL  implements Controller {
	
	private QueryService queryService;
	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("GBK");
		
		String yjStr = StringFormatUtil.format(request.getParameter("yj"),"0");
		String zclbStr = StringFormatUtil.format(request.getParameter("zclb"),"");
		String flkStr = StringFormatUtil.format(request.getParameter("flk_id"),"-1");
		String fyStr = StringFormatUtil.format(request.getParameter("fy_id"),"-1");
		if(yjStr.equals(""))
			yjStr = "0";
		double yj = Double.parseDouble(yjStr);
		String flz = "";
		
		if(yj<=0){
			ResultObject ro = queryService.search("select ga08 from Ga08_flmx ga08 where ga08.zclb='"+zclbStr+"' and ga08.flk_id="+flkStr+" and ga08.fy_id="+fyStr+" and ga08.gcflbz=1");
			if (ro.next()) {
				Ga08_flmx ga08 = (Ga08_flmx)ro.get("ga08");
				flz = ga08.getFlz().toString();
			}
		}else{
			ResultObject ro = queryService.search("select ga07,ga08 from Ga07_qfqj ga07,Ga08_flmx ga08 where ga08.qj_id=ga07.id and ga08.fy_id="+fyStr+" and ga07.sx is null and ga08.flk_id="+flkStr+" and ga08.zclb='"+zclbStr+"'");
			if (ro.next()) {
				Ga07_qfqj ga07 = (Ga07_qfqj)ro.get("ga07");
				Ga08_flmx ga08_2 = (Ga08_flmx)ro.get("ga08");
				if (yj <= ga07.getXx().doubleValue()) {
					ResultObject ro2 = queryService.search("select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id="+fyStr+") and "+yj+">xx and "+yj+"<=sx) and ga08.zclb = '"+zclbStr+"' and ga08.flk_id="+flkStr);
					if (ro2.next()) {
						Ga08_flmx ga08 = (Ga08_flmx)ro2.get("ga08");
						flz = ga08.getFlz().toString();
					}
				}else{
					Integer xx = ga07.getXx();
					Integer mzj = ga07.getMzj();
					String zjs = NumberFormatUtil.mulToString(NumberFormatUtil.subScal(NumberFormatUtil.divToString(NumberFormatUtil
							.subToString(Double.toString(yj), xx.toString()), mzj.toString())), ga08_2.getFlz().toString());
					ResultObject ro2 = queryService.search("select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "+fyStr+") and sx = "+xx+") and ga08.zclb = '"+zclbStr+"' and ga08.flk_id="+flkStr);
					if (ro2.next()) {
						Ga08_flmx ga08 = (Ga08_flmx)ro2.get("ga08");
						flz = NumberFormatUtil.addToString(zjs,ga08.getFlz().toString());
					}
				}
			}
		}
		out.println("<response><flz>"+flz+"</flz></response>");
		out.flush();
		out.close();
		
	    return new ModelAndView("" + "");
	}
}
