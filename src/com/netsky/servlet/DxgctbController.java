package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gd01_gcxm;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * 单项工程同步信息到工程项目中
 * @author CT
 * @create 2009-07-31
 */
public class DxgctbController implements Controller{

	/**
	 * 保存service
	 */
	private SaveService saveService;
	
	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}
	
	private QueryService queryService;

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		
		String gcxm_id = request.getParameter("gcxm_id");
		String dxgc_id = request.getParameter("dxgc_id");
		if(dxgc_id == null || "".equals(dxgc_id)){
			throw new Exception("单项工程id为空");
		}
		if ("".equals(gcxm_id) || gcxm_id == null) {
			throw new Exception("项目id为空");
		}
		Gd01_gcxm gd01 = (Gd01_gcxm) queryService.searchById(Gd01_gcxm.class, new Integer(gcxm_id));
		if (gd01 == null) {
			throw new Exception("未找到项目.id=" + gcxm_id);
		}
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, new Integer(dxgc_id));
		if(gd02 == null){
			throw new Exception("未找到单项工程.id=" + dxgc_id);
		}
		PropertyInject.copyProperty(gd02, gd01, new String[] { "id" });
		saveService.save(gd01);
		return new ModelAndView("redirect:" + "../dataManage/zhxx.jsp?gcxm_id="+gcxm_id+"&dxgc_id="+dxgc_id+"&gcfl_id="+gd01.getGcfl_id());
	}

}
