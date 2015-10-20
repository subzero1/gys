package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

public class ClsbOp implements Controller {

	private QueryService queryService;

	private SaveService saveService;
	
	private CalculateService calculateService;
	
	public CalculateService getCalculateService() {
		return calculateService;
	}

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public SaveService getSaveService() {
		return saveService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		System.out.println(request.getParameter("gcxm_id"));
		Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		Integer bgxx_id = new Integer(request.getParameter("bgxx_id"));
		String flag = request.getParameter("flag");
		
		Gb03_bgxx bgbhInfo = null;
		ResultObject bgxxRs = queryService.search("select gb03 from Gb03_bgxx gb03 where id="+bgxx_id);
		bgxxRs.next();
		bgbhInfo = (Gb03_bgxx)bgxxRs.get("gb03");
		
		if(flag.equals("1")){//由定额生成材料
			if(bgbhInfo.getBgbh().equals("B4JZC"))
				calculateService.DeAssociated(dxgc_id, gcxm_id, new Integer(1), new Integer(0),new Integer(0),new Integer(0));
			else
				calculateService.DeAssociated(dxgc_id, gcxm_id, new Integer(0), new Integer(1),new Integer(0),new Integer(0));
			calculateService.B4Calculate(gcxm_id, dxgc_id, bgxx_id);
			return new ModelAndView("redirect:../dataManage/b4j.jsp?bgxx_id="+bgxx_id+"&dxgc_id="+dxgc_id+"&gcxm_id="+gcxm_id);
		}else{//合并材料
			calculateService.B4Merger(gcxm_id, dxgc_id, bgxx_id, request.getParameter("fields").split(","));
			calculateService.B4Calculate(gcxm_id, dxgc_id, bgxx_id);
			return new ModelAndView("redirect:../dataManage/selectMergerField.jsp?close=true");
		}
		
		
	}

}
