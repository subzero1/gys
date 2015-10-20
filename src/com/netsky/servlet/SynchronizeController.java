package com.netsky.servlet;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SynchronizeInfomation;

/**
 * @author Chiang 2009-10-25
 * 
 * 同步项目设置信息
 */
public class SynchronizeController implements Controller {

	private SynchronizeInfomation synchronizeInfomation;

	private CalculateService calculateService;

	private QueryService queryService;

	public SynchronizeInfomation getSynchronizeInfomation() {
		return synchronizeInfomation;
	}

	public void setSynchronizeInfomation(SynchronizeInfomation synchronizeInfomation) {
		this.synchronizeInfomation = synchronizeInfomation;
	}

	public CalculateService getCalculateService() {
		return calculateService;
	}

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

	public QueryService getQuerService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("GBK");
		PrintWriter out = response.getWriter();
		String act = request.getParameter("act");
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		String bgbh = request.getParameter("bgbh");
		String bgxx_id = request.getParameter("bgxx_id");
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (act.equals("all")) {
			synchronizeInfomation.SynchronizeB1(dxgc_id);
			synchronizeInfomation.SynchronizeB2(dxgc_id);
			synchronizeInfomation.SynchronizeB3j(dxgc_id);
			synchronizeInfomation.SynchronizeB3yb(dxgc_id);
			synchronizeInfomation.SynchronizeB5(dxgc_id);
			String HSql = "select gb03 from Gb03_bgxx gb03 where gb03.bgbh like 'B4J%' and id in (" + gd02.getBgxd() + ")";
			ResultObject ro = queryService.search(HSql);
			while (ro.next()) {
				Gb03_bgxx gb03 = (Gb03_bgxx) ro.get(Gb03_bgxx.class.getName());
				synchronizeInfomation.SynchronizeB4(dxgc_id, gb03.getBgbh());
			}
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
		} else if (act.equals("b1")) {
			synchronizeInfomation.SynchronizeB1(dxgc_id);
			/**
			 * 计算表1,表2,表5
			 */
			calculateService.Calculate(gd02.getId());
            out.print("b1");
		} else if (act.equals("b2")) {
			synchronizeInfomation.SynchronizeB2(dxgc_id);
			/**
			 * 计算表1,表2,表5
			 */
			calculateService.Calculate(gd02.getId());
			out.print("b2");
		} else if (act.equals("b3j")) {
			synchronizeInfomation.SynchronizeB3j(dxgc_id);
			/**
			 * 计算表3
			 */
			calculateService.B3Calculate(gd02.getId(), gd02.getGcxm_id());
			calculateService.Calculate(gd02.getId());
			out.print("b3j");
		} else if (act.equals("b3yb")) {
			synchronizeInfomation.SynchronizeB3yb(dxgc_id);
			/**
			 * 计算表3乙
			 */
			calculateService.B3yCalculate(gd02.getId(), gd02.getGcxm_id());
			/**
			 * 计算表3丙
			 */
			calculateService.B3bCalculate(gd02.getId(), gd02.getGcxm_id());
			calculateService.Calculate(gd02.getId());
			out.print("b3yb");
		} else if (act.equals("b4")) {
			synchronizeInfomation.SynchronizeB4(dxgc_id, bgbh);
			/**
			 * 计算表4
			 */
			calculateService.B4Calculate(gd02.getGcxm_id(), dxgc_id, new Integer(bgxx_id));
			calculateService.Calculate(gd02.getId());
			out.print("b4");
		} else if (act.equals("b5")) {
			synchronizeInfomation.SynchronizeB5(dxgc_id);
			/**
			 * 计算表1,表2,表5
			 */
			calculateService.Calculate(gd02.getId());
			out.print("b5");
		}
		out.flush();
		out.close();
		return null;
	}

}
