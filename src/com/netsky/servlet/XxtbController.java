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
import com.netsky.service.CalculateService;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

public class XxtbController implements Controller {

	private QueryService queryService;

	private SaveService saveService;

	private ExpenseService expenseService;

	private CalculateService calculateService;

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public CalculateService getCalculateService() {
		return calculateService;
	}

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

	public ExpenseService getExpenseService() {
		return expenseService;
	}

	public void setExpenseService(ExpenseService expenseService) {
		this.expenseService = expenseService;
	}

	public SaveService getSaveService() {
		return saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		boolean rebuildFlk = false;
		boolean rebuildZy = false;
		String gcxm_id = request.getParameter("gcxm_id");
		String dxgc_id = request.getParameter("dxgc_id");
		if(dxgc_id == null)
			dxgc_id = "";
		if ("".equals(gcxm_id) || gcxm_id == null) {
			throw new Exception("项目id为空");
		}
		Gd01_gcxm gd01 = (Gd01_gcxm) queryService.searchById(Gd01_gcxm.class, new Integer(gcxm_id));
		if (gd01 == null) {
			throw new Exception("未找到项目.id=" + gcxm_id);
		}
		Gd02_dxgc gd02;
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("gcxm_id", new Integer(gcxm_id));
		ResultObject ro = queryService.search(queryBuilder);
		while (ro.next()) {
			gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
			if (gd01.getFlk_id().intValue() != gd02.getFlk_id().intValue()) {
				rebuildFlk = true;
			}
			if (gd01.getZy_id().intValue() != gd02.getZy_id().intValue()) {
				rebuildZy = true;
			}
			PropertyInject.copyProperty(gd01, gd02, new String[] { "id" });
			saveService.save(gd02);
			/**
			 * 重取费率
			 */
			if (rebuildFlk) {
				expenseService.reBuildFy(gd02, "B1", request);
				expenseService.reBuildFy(gd02, "B2", request);
				expenseService.reBuildFy(gd02, "B3", request);
				expenseService.reBuildFy(gd02, "B4", request);
				expenseService.reBuildFy(gd02, "B5", request);
			} else if (rebuildZy) {
				expenseService.rebuildZyfl(gd02);
			}
			if (rebuildFlk || rebuildZy) {
				/**
				 * 计算表3
				 */
				calculateService.B3Calculate(gd02.getId(), gd02.getGcxm_id());

				/**
				 * 计算表3乙
				 */
				calculateService.B3yCalculate(gd02.getId(), gd02.getGcxm_id());

				/**
				 * 计算表3丙
				 */
				calculateService.B3bCalculate(gd02.getId(), gd02.getGcxm_id());

				/**
				 * 计算表4
				 */
				calculateService.B4CalculateAll(gd02.getGcxm_id(), gd02.getId());

				/**
				 * 计算表1,表2,表5
				 */
				calculateService.Calculate(gd02.getId());
			}
		}

		if (gcxm_id == null) {
			gcxm_id = "";
		}
		return new ModelAndView("redirect:" + "../dataManage/xmxx.jsp?gcxm_id=" + gcxm_id + "&dxgc_id=" + dxgc_id);
	}
}
