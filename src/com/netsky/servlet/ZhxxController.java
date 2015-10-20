package com.netsky.servlet;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd01_gcxm;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.service.CalculateService;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * �ۺ���Ϣ����Controller
 * 
 * @author Chiang 2009-04-30
 */
public class ZhxxController implements Controller {

	private SaveService saveService;

	private QueryService queryService;

	private ExpenseService expenseService;

	private CalculateService calculateService;

	/**
	 * @return the saveService
	 */
	public SaveService getSaveService() {
		return saveService;
	}

	/**
	 * @param saveService
	 *            the saveService to set
	 */
	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	/**
	 * @return the queryService
	 */
	public QueryService getQueryService() {
		return queryService;
	}

	/**
	 * @param queryService
	 *            the queryService to set
	 */
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	/**
	 * @return the expenseService
	 */
	public ExpenseService getExpenseService() {
		return expenseService;
	}

	/**
	 * @param expenseService
	 *            the expenseService to set
	 */
	public void setExpenseService(ExpenseService expenseService) {
		this.expenseService = expenseService;
	}

	/**
	 * @return the calculateService
	 */
	public CalculateService getCalculateService() {
		return calculateService;
	}

	/**
	 * @param calculateService
	 *            the calculateService to set
	 */
	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		/**
		 * �������ͱ�ʶ,insert&update
		 */
		String saveFlag = "";
		boolean rebuildFlk = false;
		boolean rebuildZy = false;
		Gd02_dxgc gd02 = new Gd02_dxgc();
		if (request.getParameter("Gd02_dxgc.ID") == null || request.getParameter("Gd02_dxgc.ID").length() == 0) {
			saveFlag = "insert";
			/**
			 * ����
			 */
			gd02.setCjsj(new Date());
			gd02.setB1_tzxs(new Double(1));
			gd02.setB2_tzxs(new Double(1));
			gd02.setB3_jggr_tzxs(new Double(1));
			gd02.setB3_pggr_tzxs(new Double(1));
			gd02.setB3_jxf_tzxs(new Double(1));
			gd02.setB3_ybf_tzxs(new Double(1));
			gd02.setB2_sgdqf_wfbz(new Integer(2));
			gd02.setB2_jxdqf_wfbz(new Integer(2));
			gd02.setXgr_bz(new Integer(0));
			gd02.setB1_qzbz(new Integer(1));
			gd02.setB1_ybf_bz(new Integer(1));
			gd02.setSj_bgbbl(new Integer(0));
			gd02.setB2_bgbbl(new Integer(0));
			gd02.setB3_jxjg("BDJ");
			gd02.setB3_ybjg("BDJ");
			gd02.setB4_sbjg("BDJ");
			gd02.setB4_zcjg("BDJ");
		} else {
			saveFlag = "update";
			/**
			 * ����
			 */
			gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, Integer.valueOf(request.getParameter("Gd02_dxgc.ID")));

			if (gd02.getFlk_id().intValue() != Integer.parseInt(request.getParameter("Gd02_dxgc.FLK_ID"))) {
				/**
				 * ����ʹ�÷��ʿ�,��ȡ���з���
				 */
				rebuildFlk = true;
			} else if (gd02.getZy_id().intValue() != Integer.parseInt(request.getParameter("Gd02_dxgc.ZY_ID"))) {
				/**
				 * ������רҵ���޸�,��ȡ����רҵ��ط���
				 */
				rebuildZy = true;
			}
		}
		PropertyInject.inject(request, gd02, 0);
		if (gd02.getGcxm_id() == null) {
			/**
			 * �½���Ŀ
			 */
			Gd01_gcxm gd01 = new Gd01_gcxm();
			PropertyInject.copyProperty(gd02, gd01, new String[] { "id" });
			if (request.getParameter("GCFL_ID") != null && !request.getParameter("GCFL_ID").equals(""))
				gd01.setGcfl_id(Integer.valueOf(request.getParameter("GCFL_ID")));
			gd01.setXmmc(gd02.getGcmc());
			gd01.setXmbh(gd02.getGcbh());
			gd01.setXmsm(gd02.getGcsm());
			saveService.save(gd01);
			gd02.setGcxm_id(gd01.getId());
		}
		saveService.save(gd02);
		if (saveFlag.equals("insert")) {
			/**
			 * �����ۺ���Ϣ��Ĵ���. д��gd03,��1��2��5����
			 */
			expenseService.insertGd03(gd02);
			/**
			 * д��gd10,��3����
			 */
			expenseService.insertGd10(gd02, request);
			/**
			 * д���4����
			 */
			expenseService.insertGd04(gd02);
		} else {
			/**
			 * ���º�Ĵ��� �������������
			 */

			expenseService.updateGd10(gd02, request);
			/**
			 * ���º����ѡ�б������
			 */
			String HSql = "from Gb03_bgxx where id not in (" + gd02.getBgxd() + ")";
			ResultObject ro = queryService.search(HSql);
			while (ro.next()) {
				/**
				 * ɾ��δѡ�б������,��3�ұ�,��4
				 */
				Gb03_bgxx gb03 = (Gb03_bgxx) ro.get("Gb03_bgxx");
				if (gb03.getBgbh().equals("B3Y")) {
					/**
					 * ��3��
					 */
					HSql = "delete Gd06_b3y where dxgc_id = " + gd02.getId() + " and lb = 'JX'";
				} else if (gb03.getBgbh().equals("B3B")) {
					/**
					 * ��3��
					 */
					HSql = "delete Gd06_b3y where dxgc_id = " + gd02.getId() + " and lb = 'YB'";
				} else {
					/**
					 * ��4
					 */
					HSql = "delete Gd07_b4 where dxgc_id = " + gd02.getId() + " and bgbh = '" + gb03.getBgbh() + "'";
				}
				saveService.updateByHSql(HSql);
			}

			/**
			 * ��ȡ����
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

			/**
			 * ������ѡ���,���������ط���
			 */
			String bgxd_new[] = request.getParameter("Gd02_dxgc.BGXD").split(",");
			String bgxd_old[] = gd02.getBgxd().split(",");
			/**
			 * �������ӵı��
			 */
			for (int i = 0; i < bgxd_new.length; i++) {
				boolean if_add = true;
				for (int j = 0; j < bgxd_old.length; j++) {
					if (bgxd_new[i].equals(bgxd_old[j])) {
						if_add = false;
						break;
					}
				}
				if (if_add) {
					expenseService.updateJsgc(gd02, Integer.valueOf(bgxd_new[i]), "add");
				}
			}

			/**
			 * ����ɾ���ı��
			 */
			for (int i = 0; i < bgxd_old.length; i++) {
				boolean if_del = true;
				for (int j = 0; j < bgxd_new.length; j++) {
					if (bgxd_old[j].equals(bgxd_new[i])) {
						if_del = false;
						break;
					}
				}
				if (if_del) {
					expenseService.updateJsgc(gd02, Integer.valueOf(bgxd_old[i]), "delete");
				}
			}

			/**
			 * ���º����¼���������
			 */

			/**
			 * �����3
			 */
			calculateService.B3Calculate(gd02.getId(), gd02.getGcxm_id());

			/**
			 * �����3��
			 */
			calculateService.B3yCalculate(gd02.getId(), gd02.getGcxm_id());

			/**
			 * �����3��
			 */
			calculateService.B3bCalculate(gd02.getId(), gd02.getGcxm_id());

			/**
			 * �����4
			 */
			calculateService.B4CalculateAll(gd02.getGcxm_id(), gd02.getId());

			/**
			 * �����1,��2,��5
			 */
			calculateService.Calculate(gd02.getId());
		}
		return new ModelAndView("redirect:/dataManage/zhxx.jsp?dxgc_id=" + gd02.getId() + "&gcxm_id=" + gd02.getGcxm_id() + "&flag=save" + "&D2="
				+ request.getParameter("D2"));
	}
}
