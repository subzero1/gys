package com.netsky.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WriteException;

import com.netsky.baseFormatUtils.DateFormatUtil;
import com.netsky.baseFormatUtils.NumberFormatUtil;
import com.netsky.baseFormatUtils.StringFormatUtil;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga00_zclb;
import com.netsky.dataObject.Ga09_kcxs;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd01_gcxm;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.dataObject.Gd06_b3y;
import com.netsky.dataObject.Gd07_b4;
import com.netsky.dataObject.Gd09_degl;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.ExportService;
import com.netsky.service.PrintService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
import com.netsky.viewObject.B4_printVo;
import com.netsky.viewObject.BakVo;
import com.netsky.viewObject.PrintB3jVO;
import com.netsky.viewObject.PrintB3ybVo;

/**
 * 数据导出服务
 * 
 * @author Chiang 2009-06-22
 */
public class ExportServiceImpl implements ExportService {

	private QueryService queryService;

	private PrintService printService;

	private SaveService saveService;

	public SaveService getSaveService() {
		return saveService;
	}

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
	 * @return the printService
	 */
	public PrintService getPrintService() {
		return printService;
	}

	/**
	 * @param printService
	 *            the printService to set
	 */
	public void setPrintService(PrintService printService) {
		this.printService = printService;
	}

	/**
	 * 输出汇总表信息到指定WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_ids
	 *            单项工程ids,需要输出的单项工程id字符串,逗号分隔
	 * @param startPage
	 *            起始页
	 * @param totalPage
	 *            总页数
	 * @throws Exception
	 */
	public void exportHzbtoExcel(WritableSheet ws, Integer gcxm_id, String dxgc_ids, int startPage, String bgbh) throws Exception {
		// TODO Auto-generated method stub
		this.formatWritableSheet(ws);
		/**
		 * 写入工作薄
		 */
		Label label;
		/**
		 * 设置列宽
		 */
		ws.setColumnView(0, 5);
		ws.setColumnView(1, 12);
		ws.setColumnView(2, 29);
		ws.setColumnView(3, 10);
		ws.setColumnView(4, 10);
		ws.setColumnView(5, 12);
		ws.setColumnView(6, 10);
		ws.setColumnView(7, 10);
		ws.setColumnView(8, 10);
		ws.setColumnView(9, 11);
		ws.setColumnView(10, 11);
		ws.setColumnView(11, 9);

		/**
		 * 获取项目数据
		 */
		Gd02_dxgc gd02;
		Gd01_gcxm gd01;
		Gd03_gcfysz gd03;
		ResultObject ro, ro2;
		QueryBuilder queryBuilder;
		int Hzb_onePagesRows = printService.getHzb_onePagesRows();
		gd01 = (Gd01_gcxm) queryService.searchById(Gd01_gcxm.class, gcxm_id);
		if (gd01 == null) {
			throw new RuntimeException("项目未找到!");
		}

		int listCount = 0;

		String jsjd = "预算";
		if (gd01.getJsjd() != null) {
			if (gd01.getJsjd().intValue() == 1) {
				jsjd = "概算";
			} else if (gd01.getJsjd().intValue() == 2) {
				jsjd = "预算";
			} else if (gd01.getJsjd().intValue() == 3) {
				jsjd = "结算";
			} else if (gd01.getJsjd().intValue() == 4) {
				jsjd = "决算";
			}
		}
		int pages = 0;
		if (dxgc_ids != null)
			pages = printService.getHzbTotalpages(gcxm_id, dxgc_ids).intValue();
		else
			pages = printService.getHzbTotalpages(gcxm_id, null).intValue();
		queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("gcxm_id", gcxm_id);
		if (dxgc_ids != null) {
			Integer dxgc_id[] = new Integer[(dxgc_ids.split(",")).length];
			for (int i = 0; i < dxgc_id.length; i++) {
				dxgc_id[i] = Integer.valueOf(dxgc_ids.split(",")[i]);
			}
			queryBuilder.in("id", dxgc_id);
		}
		ro = queryService.search(queryBuilder);
		int excelPageRowSize = Hzb_onePagesRows;
		for (int i = 0; i < pages; i++) {
			/**
			 * 设置标题
			 */
			label = new Label(0, 0, "建设项目总" + jsjd + "表（汇总表）", this.getTitleCellFormat());
			ws.addCell(label);
			/**
			 * 合并第一行0-11单元格
			 */
			ws.mergeCells(0, 0 + excelPageRowSize * i, 11, 0 + excelPageRowSize * i);
			/**
			 * 合并工程信息行单元格
			 */
			ws.mergeCells(0, 1 + excelPageRowSize * i, 3, 1 + excelPageRowSize * i);
			ws.mergeCells(4, 1 + excelPageRowSize * i, 7, 1 + excelPageRowSize * i);
			ws.mergeCells(8, 1 + excelPageRowSize * i, 9, 1 + excelPageRowSize * i);
			ws.mergeCells(10, 1 + excelPageRowSize * i, 11, 1 + excelPageRowSize * i);
			/**
			 * 设置第一行行高
			 */
			ws.setRowView(0 + excelPageRowSize * i, 1000);

			/**
			 * 设置工程信息行
			 */
			label = new Label(0, 1, "工程名称：" + StringFormatUtil.format(gd01.getXmmc()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(4, 1, "建设单位名称：" + StringFormatUtil.format(gd01.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(8, 1, "表格编号：" + StringFormatUtil.format(gd01.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(10, 1, "第" + (i + 1) + "页 总第" + (startPage + 1) + "页", this.getInfoCellAlignRightFormat());
			ws.addCell(label);
			/**
			 * 设置行高
			 */
			ws.setRowView(1 + excelPageRowSize * i, 375);

			/**
			 * 设置标题行
			 */
			label = new Label(0, 2 + excelPageRowSize * i, "序号", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(0, 2 + excelPageRowSize * i, 0, 4 + excelPageRowSize * i);

			label = new Label(1, 2 + excelPageRowSize * i, "表格编号", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(1, 2 + excelPageRowSize * i, 1, 4 + excelPageRowSize * i);

			label = new Label(2, 2 + excelPageRowSize * i, "工程名称", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(2, 2 + excelPageRowSize * i, 2, 4 + excelPageRowSize * i);

			label = new Label(3, 4 + excelPageRowSize * i, "（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(3, 4 + excelPageRowSize * i, 8, 4 + excelPageRowSize * i);

			WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
			WritableCellFormat no_bottom = new WritableCellFormat(wf);
			no_bottom.setAlignment(Alignment.CENTRE);
			no_bottom.setVerticalAlignment(VerticalAlignment.CENTRE);
			no_bottom.setBorder(Border.TOP, BorderLineStyle.THIN);
			no_bottom.setBorder(Border.LEFT, BorderLineStyle.THIN);
			no_bottom.setBorder(Border.RIGHT, BorderLineStyle.THIN);
			WritableCellFormat no_top = new WritableCellFormat(wf);
			no_top.setAlignment(Alignment.CENTRE);
			no_top.setVerticalAlignment(VerticalAlignment.CENTRE);
			no_top.setBorder(Border.BOTTOM, BorderLineStyle.THIN);
			no_top.setBorder(Border.LEFT, BorderLineStyle.THIN);
			no_top.setBorder(Border.RIGHT, BorderLineStyle.THIN);
			label = new Label(3, 2 + excelPageRowSize * i, "小型建筑", no_bottom);
			ws.addCell(label);

			label = new Label(3, 3 + excelPageRowSize * i, "工程费", no_top);
			ws.addCell(label);

			label = new Label(4, 2 + excelPageRowSize * i, "需要安装", no_bottom);
			ws.addCell(label);

			label = new Label(4, 3 + excelPageRowSize * i, "的设备费", no_top);
			ws.addCell(label);

			label = new Label(5, 2 + excelPageRowSize * i, "不需要安装的", no_bottom);
			ws.addCell(label);

			label = new Label(5, 3 + excelPageRowSize * i, "设备、工器具费", no_top);
			ws.addCell(label);

			label = new Label(6, 2 + excelPageRowSize * i, "建筑安装", no_bottom);
			ws.addCell(label);

			label = new Label(6, 3 + excelPageRowSize * i, "工程费", no_top);
			ws.addCell(label);

			label = new Label(7, 2 + excelPageRowSize * i, "其他费用", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(7, 2 + excelPageRowSize * i, 7, 3 + excelPageRowSize * i);

			label = new Label(8, 2 + excelPageRowSize * i, "预备费", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(8, 2 + excelPageRowSize * i, 8, 3 + excelPageRowSize * i);

			label = new Label(9, 2 + excelPageRowSize * i, "总价值", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.mergeCells(9, 2 + excelPageRowSize * i, 10, 3 + excelPageRowSize * i);

			label = new Label(9, 4 + excelPageRowSize * i, "人民币（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(10, 4 + excelPageRowSize * i, "其中外币（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);

			label = new Label(11, 2 + excelPageRowSize * i, "生产准备", no_bottom);
			ws.addCell(label);

			label = new Label(11, 3 + excelPageRowSize * i, "及开办费", no_top);
			ws.addCell(label);
			label = new Label(11, 4 + excelPageRowSize * i, "（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(2 + excelPageRowSize * i, 300);
			ws.setRowView(3 + excelPageRowSize * i, 300);
			ws.setRowView(4 + excelPageRowSize * i, 375);

			label = new Label(0, 5 + excelPageRowSize * i, "I", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(1, 5 + excelPageRowSize * i, "II", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(2, 5 + excelPageRowSize * i, "III", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(3, 5 + excelPageRowSize * i, "IV", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(4, 5 + excelPageRowSize * i, "V", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(5, 5 + excelPageRowSize * i, "VI", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(6, 5 + excelPageRowSize * i, "VII", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(7, 5 + excelPageRowSize * i, "VIII", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(8, 5 + excelPageRowSize * i, "IX", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(9, 5 + excelPageRowSize * i, "X", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(10, 5 + excelPageRowSize * i, "XI", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(11, 5 + excelPageRowSize * i, "XII", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(5 + excelPageRowSize * i, 375);

			/**
			 * 数据行
			 */
			for (int j = 0; j < Hzb_onePagesRows; j++) {
				ws.setRowView(6 + j + excelPageRowSize * i, 375);
				if (ro.next()) {
					gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
					String hj = "0.00";
					label = new Label(0, 6 + j + excelPageRowSize * i, (++listCount) + "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 6 + j + excelPageRowSize * i, gd02.getBgbh(), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 6 + j + excelPageRowSize * i, gd02.getGcmc(), this.getTextCellAlignLeftFormat());
					ws.addCell(label);

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "建筑工程费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(3, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "需安设备费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(4, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "不需安设备费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(5, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "建筑安装工程费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(6, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "表5合计其他费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(7, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "预备费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						hj = NumberFormatUtil.addToString(hj, NumberFormatUtil.roundToString(gd03.getFyz()));
						label = new Label(8, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}

					label = new Label(9, 6 + j + excelPageRowSize * i, hj, this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(10, 6 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
					ws.addCell(label);

					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fymc", "生产准备及开办费");
					queryBuilder.eq("dxgc_id", gd02.getId());
					ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						label = new Label(11, 6 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this
								.getTextCellAlignRightFormat());
						ws.addCell(label);
					}
				} else {
					for (int k = 0; k < 12; k++) {
						label = new Label(k, 6 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
						ws.addCell(label);
					}
				}
			}
			/**
			 * 处理审核信息行
			 */
			label = new Label(0, 6 + Hzb_onePagesRows + excelPageRowSize * i, "设计负责人：" + StringFormatUtil.format(gd01.getSjfzr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(3, 6 + Hzb_onePagesRows + excelPageRowSize * i, "审核：" + StringFormatUtil.format(gd01.getShr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(6, 6 + Hzb_onePagesRows + excelPageRowSize * i, "编制：" + StringFormatUtil.format(gd01.getBzr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(9, 6 + Hzb_onePagesRows + excelPageRowSize * i, "编制日期：" + DateFormatUtil.Format(gd01.getBzrq(), "yyyy年MM月dd日"), this
					.getInfoCellAlignRightFormat());
			ws.addCell(label);
			/**
			 * 设置行高
			 */
			ws.setRowView(6 + Hzb_onePagesRows + excelPageRowSize * i, 375);
			/**
			 * 合并审核信息行单元格
			 */
			ws.mergeCells(0, 6 + Hzb_onePagesRows + excelPageRowSize * i, 2, 6 + Hzb_onePagesRows + excelPageRowSize * i);
			ws.mergeCells(3, 6 + Hzb_onePagesRows + excelPageRowSize * i, 5, 6 + Hzb_onePagesRows + excelPageRowSize * i);
			ws.mergeCells(6, 6 + Hzb_onePagesRows + excelPageRowSize * i, 8, 6 + Hzb_onePagesRows + excelPageRowSize * i);
			ws.mergeCells(9, 6 + Hzb_onePagesRows + excelPageRowSize * i, 11, 6 + Hzb_onePagesRows + excelPageRowSize * i);

			/**
			 * 强制分页
			 */
			ws.addRowPageBreak(25);
		}
	}

	/**
	 * 输出表2信息到指定WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程id
	 * @param startPage
	 *            起始页
	 * @param bgbh
	 *            打印表格编号
	 * @throws Exception
	 */
	public void exportB2toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		this.formatWritableSheet(ws);
		Gd02_dxgc gd02;
		/**
		 * 获取单项工程信息
		 */
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}
		/**
		 * 获取表2费用
		 */
		Gd03_gcfysz gd03;
		ResultObject ro;
		QueryBuilder queryBuilder;
		queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder.eq("dxgc_id", gd02.getId());
		queryBuilder.addCriterion(Restrictions.or(Restrictions.eq("bgbh", "B2"), Restrictions.like("bgbh", "B3", MatchMode.ANYWHERE)));
		ro = queryService.search(queryBuilder);
		Map map = new HashMap();
		int pageCount = 1;
		while (ro.next()) {
			Gd03_gcfysz object = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
			map.put(object.getFymc(), object);
		}

		/**
		 * 写入工作薄
		 */
		Label label;
		/**
		 * 设置列宽
		 */
		ws.setColumnView(0, 6);
		ws.setColumnView(1, 20);
		ws.setColumnView(2, 33);
		ws.setColumnView(3, 10);
		ws.setColumnView(4, 1);
		ws.setColumnView(5, 6);
		ws.setColumnView(6, 20);
		ws.setColumnView(7, 33);
		ws.setColumnView(8, 10);
		/**
		 * 设置标题
		 */
		label = new Label(0, 0, "建筑安装工程费用" + jsjd + "表（表二）", this.getTitleCellFormat());
		ws.addCell(label);
		/**
		 * 合并第一行0-9单元格
		 */
		ws.mergeCells(0, 0, 8, 0);
		/**
		 * 合并工程信息行单元格
		 */
		ws.mergeCells(0, 1, 2, 1);
		ws.mergeCells(3, 1, 6, 1);
		/**
		 * 设置第一行行高
		 */
		ws.setRowView(0, 1000);

		/**
		 * 设置工程信息行
		 */
		label = new Label(0, 1, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 1, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 1, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 1, "第"+pageCount+"页 总第" + (startPage+(pageCount++)) + "页", this.getInfoCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(1, 375);

		/**
		 * 设置标题行
		 */
		label = new Label(0, 2, "序号", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 2, "费用名称", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(2, 2, "依据和计算方法", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(3, 2, "合计（元）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.TOP, BorderLineStyle.THIN);
		label = new Label(4, 2, "", nullCell);
		ws.addCell(label);

		label = new Label(5, 2, "序号", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 2, "费用名称", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(7, 2, "依据和计算方法", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(8, 2, "合计（元）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(2, 375);

		/**
		 * 设置序号行,第四行
		 */
		label = new Label(0, 3, "I", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 3, "II", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(2, 3, "III", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(3, 3, "IV", this.getTextCellAlignCenterFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 3, "", nullCell);
		ws.addCell(label);

		label = new Label(5, 3, "I", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 3, "II", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(7, 3, "III", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(8, 3, "IV", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(3, 375);

		/**
		 * 数据第一行，总第五行
		 */
		gd03 = (Gd03_gcfysz) map.get("建筑安装工程费");

		label = new Label(0, 4, "", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 4, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 4, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 4, NumberFormatUtil.roundToString(gd03.getFyz()), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 4, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("夜间施工增加费");

		label = new Label(5, 4, "8", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 4, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 4, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 4, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(4, 375);

		/**
		 * 数据第二行，总第六行
		 */
		gd03 = (Gd03_gcfysz) map.get("直接费");

		label = new Label(0, 5, "一", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 5, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 5, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 5, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 5, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("冬雨季施工增加费");

		label = new Label(5, 5, "9", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 5, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 5, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 5, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(5, 375);

		/**
		 * 数据第三行，总第七行
		 */
		gd03 = (Gd03_gcfysz) map.get("直接工程费");

		label = new Label(0, 6, "（一）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 6, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 6, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 6, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 6, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("生产工具用具使用费");

		label = new Label(5, 6, "10", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 6, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 6, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 6, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(6, 375);

		/**
		 * 数据第四行，总第八行
		 */
		gd03 = (Gd03_gcfysz) map.get("人工费");

		label = new Label(0, 7, "1", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 7, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 7, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 7, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 7, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("施工用水电蒸汽费");

		label = new Label(5, 7, "11", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 7, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 7, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 7, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(7, 375);

		/**
		 * 数据第5行，总第9行
		 */
		gd03 = (Gd03_gcfysz) map.get("技工费");

		label = new Label(0, 8, "（1）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 8, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 8, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 8, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 8, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("特殊地区施工增加费");

		label = new Label(5, 8, "12", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 8, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 8, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 8, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(8, 375);

		/**
		 * 数据第6行，总第10行
		 */
		gd03 = (Gd03_gcfysz) map.get("普工费");

		label = new Label(0, 9, "（2）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 9, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 9, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 9, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 9, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("已完工程及设备保护费");

		label = new Label(5, 9, "13", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 9, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 9, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 9, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(9, 375);

		/**
		 * 数据第7行，总第11行
		 */
		gd03 = (Gd03_gcfysz) map.get("材料费");

		label = new Label(0, 10, "2", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 10, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 10, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 10, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 10, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("运土费");

		label = new Label(5, 10, "14", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 10, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 10, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 10, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(10, 375);

		/**
		 * 数据第8行，总第12行
		 */
		gd03 = (Gd03_gcfysz) map.get("主要材料费");

		label = new Label(0, 11, "（1）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 11, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 11, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 11, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 11, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("施工队伍调遣费");

		label = new Label(5, 11, "15", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 11, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 11, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 11, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(11, 375);

		/**
		 * 数据第9行，总第13行
		 */
		gd03 = (Gd03_gcfysz) map.get("辅助材料费");

		label = new Label(0, 12, "（2）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 12, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 12, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 12, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 12, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("大型施工机械调遣费");

		label = new Label(5, 12, "16", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 12, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 12, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 12, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(12, 375);

		/**
		 * 数据第10行，总第14行
		 */
		gd03 = (Gd03_gcfysz) map.get("机械使用费");

		label = new Label(0, 13, "3", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 13, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 13, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 13, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 13, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("间接费");

		label = new Label(5, 13, "二", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 13, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 13, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 13, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(13, 375);

		/**
		 * 数据第11行，总第15行
		 */
		gd03 = (Gd03_gcfysz) map.get("仪器仪表使用费");

		label = new Label(0, 14, "4", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 14, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 14, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 14, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 14, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("规费");

		label = new Label(5, 14, "（一）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 14, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 14, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 14, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(14, 375);

		/**
		 * 数据第12行，总第16行
		 */
		gd03 = (Gd03_gcfysz) map.get("措施费");

		label = new Label(0, 15, "（二）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 15, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 15, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 15, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 15, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("工程排污费");

		label = new Label(5, 15, "1", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 15, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 15, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 15, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(15, 375);

		/**
		 * 数据第13行，总第17行
		 */
		gd03 = (Gd03_gcfysz) map.get("环境保护费");

		label = new Label(0, 16, "1", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 16, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 16, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 16, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 16, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("社会保障费");

		label = new Label(5, 16, "2", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 16, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 16, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 16, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(16, 375);

		/**
		 * 数据第14行，总第18行
		 */
		gd03 = (Gd03_gcfysz) map.get("文明施工费");

		label = new Label(0, 17, "2", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 17, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 17, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 17, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 17, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("住房公积金");

		label = new Label(5, 17, "3", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 17, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 17, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 17, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(17, 375);

		/**
		 * 数据第15行，总第19行
		 */
		gd03 = (Gd03_gcfysz) map.get("工地器材搬运费");

		label = new Label(0, 18, "3", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 18, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 18, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 18, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 18, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("危险作业意外伤害保险费");

		label = new Label(5, 18, "4", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 18, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 18, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 18, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(18, 375);

		/**
		 * 数据第16行，总第20行
		 */
		gd03 = (Gd03_gcfysz) map.get("工程干扰费");

		label = new Label(0, 19, "4", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 19, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 19, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 19, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 19, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("企业管理费");

		label = new Label(5, 19, "（二）", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 19, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 19, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 19, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(19, 375);

		/**
		 * 数据第17行，总第21行
		 */
		gd03 = (Gd03_gcfysz) map.get("工程点交、场地清理费");

		label = new Label(0, 20, "5", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 20, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 20, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 20, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 20, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("利润");

		label = new Label(5, 20, "三", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 20, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 20, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 20, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(20, 375);

		/**
		 * 数据第18行，总第22行
		 */
		gd03 = (Gd03_gcfysz) map.get("临时设施费用");

		label = new Label(0, 21, "6", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 21, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 21, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 21, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		label = new Label(4, 21, "", nullCell);
		ws.addCell(label);

		gd03 = (Gd03_gcfysz) map.get("税金");

		label = new Label(5, 21, "四", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 21, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 21, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 21, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(21, 375);

		/**
		 * 数据第19行，总第23行
		 */
		gd03 = (Gd03_gcfysz) map.get("工程车辆使用费");

		label = new Label(0, 22, "7", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(1, 22, gd03.getFymc(), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 22, StringFormatUtil.format(gd03.getGsbds(), "　"), this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 22, NumberFormatUtil.roundToString(gd03.getFyz(), ""), this.getTextCellAlignRightFormat());
		ws.addCell(label);

		/**
		 * 间隔列
		 */
		wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		nullCell = new WritableCellFormat(wf);
		nullCell.setAlignment(Alignment.CENTRE);
		nullCell.setVerticalAlignment(VerticalAlignment.CENTRE);
		nullCell.setBorder(Border.LEFT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		nullCell.setBorder(Border.BOTTOM, BorderLineStyle.THIN);
		label = new Label(4, 22, "", nullCell);
		ws.addCell(label);

		label = new Label(5, 22, "", this.getTextCellAlignCenterFormat());
		ws.addCell(label);
		label = new Label(6, 22, "", this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 22, "", this.getTextCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 22, "", this.getTextCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(22, 375);

		/**
		 * 处理审核信息行
		 */
		label = new Label(0, 23, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(2, 23, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(4, 23, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(7, 23, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this.getInfoCellAlignRightFormat());
		ws.addCell(label);
		/**
		 * 设置行高
		 */
		ws.setRowView(23, 375);
		/**
		 * 合并审核信息行单元格
		 */
		ws.mergeCells(0, 23, 1, 23);
		ws.mergeCells(2, 23, 3, 23);
		ws.mergeCells(4, 23, 6, 23);
		ws.mergeCells(7, 23, 8, 23);

		/**
		 * 强制分页
		 */
		ws.addRowPageBreak(25);
	}

	/**
	 * 输出表3甲信息到指WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程Id
	 * @throws Exception
	 */
	public void exportB3JtoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		// TODO Auto-generated method stub
		this.formatWritableSheet(ws);
		Gd02_dxgc gd02;
		// 获取单项工程信息
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}
		// 表格信息
		List list = new ArrayList();
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
		queryBuilder.eq("dxgc_id", dxgc_id);
		queryBuilder.addOrderBy(Order.asc("xh"));
		ResultObject ro = queryService.search(queryBuilder);
		double ckxsValue = 1.00;// 拆扩系数
		double tzxs = 1.00;// 调整系数
		double jgsum = 0.00;// 技工工日合计
		double jhj = 0.00;// 合计
		double phj = 0.00;// 合计
		double pgsum = 0.00;// 普工工日合计
		double zgrSum = 0.00;// 总工日
		double kjjg = 0.00;// 全部扩建技工工日
		double kjpg = 0.00;// 全部扩建普工工日
		double gyjg = 0.00;// 高原地区技工调整工日
		double gypg = 0.00;// 高原地区普工调整工日
		double smjg = 0.00;// 沙漠地区技工调整工日
		double smpg = 0.00;// 沙漠地区普工调整工日
		double xgrj = 0.00;// 技工小工日调增
		double xgrp = 0.00;// 普工小工日调增
		while (ro.next()) {
			Gd05_b3j b3j = (Gd05_b3j) ro.get(Gd05_b3j.class.getName());
			if (b3j != null) {
				list.add(b3j);
				if (b3j.getCk_bz() != null) {// 查询拆扩系数
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder1.eq("lb", b3j.getCk_bz());
					queryBuilder1.ge("jzbh", b3j.getDebh());// 定额编号小于等于终止编号
					queryBuilder1.le("qsbh", b3j.getDebh());// 定额编号大于等于起始编号
					ResultObject ro1 = queryService.search(queryBuilder1);
					if (ro1.next()) {
						Ga09_kcxs ckxs = (Ga09_kcxs) ro1.get(Ga09_kcxs.class.getName());
						if (ckxs != null) {
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//拆扩调整系数
						}
					}
				}
				if (b3j.getTzxs() != null && b3j.getTzxs().doubleValue() != 0.0) {
					tzxs = b3j.getTzxs().doubleValue();
				}
				jgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()), tzxs), ckxsValue), jgsum));
				pgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()), tzxs), ckxsValue), pgsum));
			}
			tzxs = 1.00;
			ckxsValue = 1.00;// 重新置回1
		}
		jhj = jgsum;
		phj = pgsum;
		if(ro.getLength()!=0){
			Gd05_b3j HJ = new Gd05_b3j();
			HJ.setDemc("　　　　　　　　　合　　　　　计");
			HJ.setJggr(new Double(jhj));
			HJ.setPggr(new Double(phj));
			list.add(HJ);
		}
		
		Gd05_b3j GY = new Gd05_b3j();
		Gd05_b3j SM = new Gd05_b3j();
		if (gd02.getB3_sgtj_bz() != null && gd02.getB3_sgtj_bz().intValue() == 0) {// 是非正常地区
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("fylb", new Integer(1));
			queryBuilder99.eq("bz", new Integer(1));// 取高原的
			queryBuilder99.eq("flag", new Integer(1));
			ResultObject ro99 = queryService.search(queryBuilder99);
			Gd10_b3fl data99 = new Gd10_b3fl();
			if (ro99.next()) {
				data99 = (Gd10_b3fl) ro99.get(Gd10_b3fl.class.getName());
			}
			if (data99 != null && data99.getRgfl() != null) {
				gyjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(jhj, NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),
						1.00)));
				gypg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(phj, NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(),
						1.00)));
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data99.getRgfl().doubleValue());// 乘以高原的系数
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data99.getRgfl().doubleValue());

				StringBuffer mc = new StringBuffer("");
				mc.append(data99.getMc());
				mc.append(" 工日增加 " + NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(), 1.00), 100) + "%");

				GY.setDemc(new String(mc));
				GY.setJggr(new Double(gyjg));
				GY.setPggr(new Double(gypg));
				if (GY != null) {
					list.add(GY);
				}
			}

			QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder100.eq("dxgc_id", dxgc_id);
			queryBuilder100.eq("fylb", new Integer(1));
			queryBuilder100.eq("bz", new Integer(2));// 取沙漠森林的
			queryBuilder100.eq("flag", new Integer(1));
			ResultObject ro100 = queryService.search(queryBuilder100);

			Gd10_b3fl data100 = new Gd10_b3fl();
			if (ro100.next()) {
				data100 = (Gd10_b3fl) ro100.get(Gd10_b3fl.class.getName());
			}
			if (data100 != null && data100.getRgfl() != null) {
				smjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(jhj, NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(),
						1.00)));
				smpg = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(phj, NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(),
						1.00)));
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data100.getRgfl().doubleValue());// 乘以沙漠森林的系数
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data100.getRgfl().doubleValue());
				StringBuffer mc = new StringBuffer("");
				mc.append(data100.getMc());
				mc.append("　工日增加 " + NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data100.getRgfl().doubleValue(), 1.00), 100) + "%");

				SM.setDemc(new String(mc));
				SM.setJggr(new Double(smjg));
				SM.setPggr(new Double(smpg));
				if (SM != null) {
					list.add(SM);
				}
			}
		}

		zgrSum = NumberFormatUtil.addToDouble(jgsum, pgsum);
		Gd05_b3j XGR = new Gd05_b3j();
		if (gd02.getZy_id().intValue() == 1 || gd02.getZy_id().intValue() == 2) {// 如果是管线工程计算小工日调增
			if (gd02.getXgr_bz() != null && gd02.getXgr_bz().intValue() == 0) {// 0需要计算小工日调增
				if (100 < zgrSum && zgrSum <= 250) {
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder3 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder3.eq("dxgc_id", dxgc_id);
					queryBuilder3.eq("fylb", new Integer(3));
					queryBuilder3.eq("bz", new Integer(250));
					ResultObject ro3 = queryService.search(queryBuilder3);
					if (ro3.next()) {
						xgr = (Gd10_b3fl) ro3.get(Gd10_b3fl.class.getName());
					}
					if (xgr != null) {
						zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
						jgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jgsum, xgr.getRgfl()
								.doubleValue()), jgsum));
						pgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl()
								.doubleValue()), pgsum));
						StringBuffer mc = new StringBuffer("");
						mc.append("小工日工程调增（以上合计×"
								+ NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(), 1.00), 100) + "%）");

						xgrj = jgsum;
						xgrp = pgsum;
						if(ro.getLength()!=0){
							XGR.setDemc(new String(mc));
							XGR.setJggr(new Double(xgrj));
							XGR.setPggr(new Double(xgrp));
							if (XGR != null) {
								list.add(XGR);
							}
						}
					}
				}
				if (zgrSum <= 100) {
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder4.eq("dxgc_id", dxgc_id);
					queryBuilder4.eq("fylb", new Integer(3));
					queryBuilder4.eq("bz", new Integer(100));
					ResultObject ro4 = queryService.search(queryBuilder4);
					if (ro4.next()) {
						xgr = (Gd10_b3fl) ro4.get(Gd10_b3fl.class.getName());
					}
					if (xgr != null) {
						zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
						jgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jgsum, xgr.getRgfl()
								.doubleValue()), jgsum));
						pgsum = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl()
								.doubleValue()), pgsum));
						StringBuffer mc = new StringBuffer("");
						mc.append("小工日工程调增（以上合计×"
								+ NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(), 1.00), 100) + "%）");
						xgrj = jgsum;
						xgrp = pgsum;
						if(ro.getLength()!=0){
							XGR.setDemc(new String(mc));
							XGR.setJggr(new Double(xgrj));
							XGR.setPggr(new Double(xgrp));
							if (XGR != null) {
								list.add(XGR);
							}
						}
					}
				}
			}
		}

		Gd05_b3j KJ = new Gd05_b3j();
		if (gd02.getGcxz() != null && gd02.getGcxz().intValue() == 2) {// 全部扩建工程工日调整费率
			Gd10_b3fl data99 = new Gd10_b3fl();
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("fylb", new Integer(3));
			queryBuilder99.eq("mc", new String("全部扩建工程工日调整费率"));
			ResultObject ro99 = queryService.search(queryBuilder99);
			if (ro99.next()) {
				data99 = (Gd10_b3fl) ro99.get(Gd10_b3fl.class.getName());
			}
			if (data99.getId() != null && data99.getRgfl() != null) {
				kjjg = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jhj, data99.getRgfl().doubleValue()),
						jhj));
				kjpg = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(phj, data99.getRgfl().doubleValue()),
						phj));
				StringBuffer mc = new StringBuffer("");
				mc.append("全部扩建工程工日调整费率（合计×" + NumberFormatUtil.mulToDouble(NumberFormatUtil.subToDouble(data99.getRgfl().doubleValue(), 1.00), 100)
						+ "%）");

				KJ.setDemc(new String(mc));
				KJ.setJggr(new Double(kjjg));
				KJ.setPggr(new Double(kjpg));
				if (KJ != null) {
					list.add(KJ);
				}
			}
		}
		if (GY.getDemc() == null && SM.getDemc() == null && XGR.getDemc() == null && KJ.getDemc() == null
				&& gd02.getB3_jggr_tzxs().doubleValue() == 1.0 && gd02.getB3_pggr_tzxs().doubleValue() == 1.0) {
		} else {
			// 计算总计
			double zjjg = 0.00;// 总计技工工日
			double zjpg = 0.00;// 总计普工工日
			StringBuffer zjmc = new StringBuffer("");
			if (gd02.getB3_jggr_tzxs().doubleValue() != 1.0 || gd02.getB3_pggr_tzxs().doubleValue() != 1.0) {
				zjmc = new StringBuffer("总　计");
			} else {
				zjmc = new StringBuffer("　　　　　　　　　总　　　　　计");
			}

			if (gd02.getB3_jggr_tzxs() != null && gd02.getB3_jggr_tzxs().doubleValue() != 1.0) {
				zjmc.append("(技工调整 ");
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(jhj, gyjg), smjg), xgrj), kjjg)));
				zjmc.append("×" + NumberFormatUtil.roundToString(gd02.getB3_jggr_tzxs()));
				if (gd02.getB3_pggr_tzxs().doubleValue() == 1.0) {
					zjmc.append(")");
				} else {
					zjmc.append("，");
				}
				zjjg = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(jhj, gyjg), smjg), xgrj), kjjg), gd02.getB3_jggr_tzxs().doubleValue());
			} else {
				zjjg = NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(jhj, gyjg), smjg), xgrj), kjjg);
			}
			if (gd02.getB3_pggr_tzxs() != null && gd02.getB3_pggr_tzxs().doubleValue() != 1.0) {
				if (gd02.getB3_jggr_tzxs().doubleValue() == 1.0) {
					zjmc.append("(普工调整 ");
				} else {
					zjmc.append("普工调整 ");
				}
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(phj, gypg), smpg), xgrp), kjpg)));
				zjmc.append("×" + NumberFormatUtil.roundToString(gd02.getB3_pggr_tzxs()) + ")");
				zjpg = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(phj, gypg), smpg), xgrp), kjpg), gd02.getB3_pggr_tzxs().doubleValue());
			} else {
				zjpg = NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
						NumberFormatUtil.addToDouble(phj, gypg), smpg), xgrp), kjpg);
			}
			Gd05_b3j ZJ = new Gd05_b3j();
			ZJ.setDemc(new String(zjmc));
			ZJ.setJggr(new Double(zjjg));
			ZJ.setPggr(new Double(zjpg));
			list.add(ZJ);// 将总计加到列表中
		}
		Gd05_b3j[] data = (Gd05_b3j[]) list.toArray(new Gd05_b3j[list.size()]);

		int pageCount = 1;
		int B3j_onePageRows = printService.getB3j_onePageRows();
		int excelPageRowSize = B3j_onePageRows + 6;
		int pages = printService.getB3jpages(gd02.getId()).intValue();
		for (int j = 0; j < pages; j++) {
			/**
			 * 写入工作薄
			 */
			Label label;
			// 设置列宽
			ws.setColumnView(0 + excelPageRowSize * j, 5);
			ws.setColumnView(1 + excelPageRowSize * j, 16);
			ws.setColumnView(2 + excelPageRowSize * j, 44);
			ws.setColumnView(3 + excelPageRowSize * j, 15);
			ws.setColumnView(4 + excelPageRowSize * j, 15);
			ws.setColumnView(5 + excelPageRowSize * j, 11);
			ws.setColumnView(6 + excelPageRowSize * j, 11);
			ws.setColumnView(7 + excelPageRowSize * j, 11);
			ws.setColumnView(8 + excelPageRowSize * j, 11);

			ws.setRowView(1 + excelPageRowSize * j, 375);
			// 设置标题
			label = new Label(0, 0 + excelPageRowSize * j, "建筑安装工程量" + jsjd + "表（表三）甲", this.getTitleCellFormat());
			ws.addCell(label);
			// 合并第一行0-9单元格
			ws.mergeCells(0, 0 + excelPageRowSize * j, 8, 0 + excelPageRowSize * j);
			// 合并工程信息行单元格
			ws.mergeCells(0, 1 + excelPageRowSize * j, 2, 1 + excelPageRowSize * j);
			ws.mergeCells(3, 1 + excelPageRowSize * j, 5, 1 + excelPageRowSize * j);
			ws.mergeCells(6, 1 + excelPageRowSize * j, 7, 1 + excelPageRowSize * j);
			// 设置第一行行高
			ws.setRowView(0 + excelPageRowSize * j, 1000);

			// 设置工程信息行
			label = new Label(0, 1 + excelPageRowSize * j, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(3, 1 + excelPageRowSize * j, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(6, 1 + excelPageRowSize * j, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(8, 1 + excelPageRowSize * j, "第" + pageCount + "页 总第" + (startPage + (pageCount++)) + "页", this
					.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			// 表头信息
			ws.mergeCells(0, 2 + excelPageRowSize * j, 0, 3 + excelPageRowSize * j);
			ws.mergeCells(1, 2 + excelPageRowSize * j, 1, 3 + excelPageRowSize * j);
			ws.mergeCells(2, 2 + excelPageRowSize * j, 2, 3 + excelPageRowSize * j);
			ws.mergeCells(3, 2 + excelPageRowSize * j, 3, 3 + excelPageRowSize * j);
			ws.mergeCells(4, 2 + excelPageRowSize * j, 4, 3 + excelPageRowSize * j);
			ws.mergeCells(5, 2 + excelPageRowSize * j, 6, 2 + excelPageRowSize * j);
			ws.mergeCells(7, 2 + excelPageRowSize * j, 8, 2 + excelPageRowSize * j);

			ws.setRowView(2 + excelPageRowSize * j, 375);
			ws.addCell(new Label(0, 2 + excelPageRowSize * j, "序号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 2 + excelPageRowSize * j, "定额编号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 2 + excelPageRowSize * j, "项目名称", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 2 + excelPageRowSize * j, "单位", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 2 + excelPageRowSize * j, "数量", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 2 + excelPageRowSize * j, "单位定额值（工日）", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 2 + excelPageRowSize * j, "合计值（工日）", this.getTextCellAlignCenterFormat()));

			ws.setRowView(3 + excelPageRowSize * j, 375);
			ws.addCell(new Label(5, 3 + excelPageRowSize * j, "技工", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 3 + excelPageRowSize * j, "普工", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 3 + excelPageRowSize * j, "技工", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 3 + excelPageRowSize * j, "普工", this.getTextCellAlignCenterFormat()));

			ws.setRowView(4 + excelPageRowSize * j, 375);
			ws.addCell(new Label(0, 4 + excelPageRowSize * j, "I", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 4 + excelPageRowSize * j, "II", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 4 + excelPageRowSize * j, "III", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 4 + excelPageRowSize * j, "IV", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 4 + excelPageRowSize * j, "V", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 4 + excelPageRowSize * j, "VI", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 4 + excelPageRowSize * j, "VII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 4 + excelPageRowSize * j, "VIII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 4 + excelPageRowSize * j, "IX", this.getTextCellAlignCenterFormat()));

			int b = j * 18;
			int i = j * 18;
			int lines = 5 + excelPageRowSize * j;
			for (; i < b + 18; i++) {
				if (i < list.size() && data[i] != null) {
					String jg = "";// 单个定额技工合计
					String pg = ""; // 单个定额普工合计
					PrintB3jVO b3vo = new PrintB3jVO();
					if (data[i].getXh() != null) {// 如果定额编号不等于空,就是合计什么的不计算这部分
						b3vo.setXh(data[i].getXh());
						b3vo.setDebh(data[i].getDebh());

						if (data[i].getTzxs() != null) {
							jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(data[i].getSl()
									.doubleValue(), data[i].getJggr().doubleValue()), data[i].getTzxs().doubleValue()));
						} else {
							jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data[i].getSl().doubleValue(), data[i].getJggr()
									.doubleValue()));
						}
						if (data[i].getTzxs() != null) {
							pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(data[i].getSl()
									.doubleValue(), data[i].getPggr().doubleValue()), data[i].getTzxs().doubleValue()));
						} else {
							pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data[i].getSl().doubleValue(), data[i].getPggr()
									.doubleValue()));
						}
						StringBuffer mc = new StringBuffer(data[i].getDemc());
						if (data[i].getCk_bz() != null) {// 查询拆扩系数
							QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Ga09_kcxs.class);
							queryBuilder4.eq("lb", data[i].getCk_bz());
							queryBuilder4.eq("sort", new Integer(1));//类别：1是人工的；2是机械的
							queryBuilder4.ge("jzbh", data[i].getDebh());// 定额编号小于等于终止编号
							queryBuilder4.le("qsbh", data[i].getDebh());// 定额编号大于等于起始编号
							ResultObject ro1 = queryService.search(queryBuilder4);
							Ga09_kcxs ckxs = new Ga09_kcxs();
							if (ro1.next()) {
								ckxs = (Ga09_kcxs) ro1.get(Ga09_kcxs.class.getName());
								if (ckxs != null) {
									if (data[i].getCk_bz().intValue() == 1) {
										mc.append("(新建 工日×");
									} else if (data[i].getCk_bz().intValue() == 2) {
										mc.append("(扩建 工日×");
									} else if (data[i].getCk_bz().intValue() == 3) {
										mc.append("(拆除再利用 工日×");
									} else if (data[i].getCk_bz().intValue() == 4) {
										mc.append("(拆除不再利用 工日×");
									} else if (data[i].getCk_bz().intValue() == 5) {
										mc.append("(更换 工日×");
									}
									mc.append(NumberFormatUtil.roundToString(ckxs.getXs()));
									mc.append("%)");
									jg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(jg, NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(),100))));// 单个定额技工合计再乘以系数
									pg = NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(pg, NumberFormatUtil.roundToString(NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(),100))));
								}
							}
						}
						if (data[i].getTzxs() != null && data[i].getTzxs().doubleValue() != 1.00) {
							mc.append("(工日调整 工日×");
							mc.append(NumberFormatUtil.roundToString(data[i].getTzxs()));
							mc.append(")");
						}
						b3vo.setDemc(new String(mc));
						b3vo.setDw(data[i].getDw());
						b3vo.setSl(data[i].getSl());
						b3vo.setJggr(data[i].getJggr());
						b3vo.setPggr(data[i].getPggr());
						b3vo.setJghj(jg);
						b3vo.setPghj(pg);
					} else {
						b3vo.setDemc(data[i].getDemc());
						b3vo.setJghj(NumberFormatUtil.roundToString(data[i].getJggr()));
						b3vo.setPghj(NumberFormatUtil.roundToString(data[i].getPggr()));
					}

					String xuhao = "";
					if (b3vo.getXh() != null) {
						xuhao = String.valueOf(b3vo.getXh());
					}
					String debh = "";
					if (b3vo.getDebh() != null) {
						debh = b3vo.getDebh();
					}
					String demc = "";
					if (b3vo.getDemc() != null) {
						demc = b3vo.getDemc();
					}
					String dw = "";
					if (b3vo.getDw() != null) {
						dw = b3vo.getDw();
					}
					String sl = "";
					if (b3vo.getSl() != null) {
						sl = NumberFormatUtil.roundToString(b3vo.getSl(), 3);
					}
					String jggr = "";
					if (b3vo.getJggr() != null && b3vo.getJggr().doubleValue() != 0.0) {
						jggr = NumberFormatUtil.roundToString(b3vo.getJggr());
					}
					String pggr = "";
					if (b3vo.getPggr() != null && b3vo.getPggr().doubleValue() != 0.0) {
						pggr = NumberFormatUtil.roundToString(b3vo.getPggr());
					}
					String jghj = "";
					if (b3vo.getJghj() != null && !b3vo.getJghj().equals("0.00")) {
						jghj = b3vo.getJghj();
					}
					String pghj = "";
					if (b3vo.getPghj() != null && !b3vo.getPghj().equals("0.00")) {
						pghj = b3vo.getPghj();
					}
					// 填充表格
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, xuhao, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, debh, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, demc, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, dw, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(4, lines, sl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, jggr, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(6, lines, pggr, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, jghj, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, pghj, this.getTextCellAlignRightFormat()));

				} else {
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, "", this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(4, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(6, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, "", this.getTextCellAlignRightFormat()));
				}
				lines++;
			}
			/**
			 * 处理审核信息行
			 */
			ws.setRowView(lines, 375);
			ws.mergeCells(0, lines, 1, lines);
			ws.mergeCells(2, lines, 3, lines);
			ws.mergeCells(4, lines, 6, lines);
			ws.mergeCells(7, lines, 8, lines);
			ws.addCell(new Label(0, lines, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(2, lines, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(4, lines, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(7, lines, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this.getInfoCellAlignRightFormat()));

			ws.addRowPageBreak(B3j_onePageRows + excelPageRowSize * j + 6);
		}
	}

	/**
	 * 输出表3乙信息到指定的WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程ID
	 * @throws Exception
	 */
	public void exportB3ytoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		// TODO Auto-generated method stub
		this.formatWritableSheet(ws);

		Gd02_dxgc gd02;
		// 获取单项工程信息
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}
		List list = new ArrayList();

		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id", dxgc_id);
		queryBuilder1.eq("lb", new String("JX"));
		queryBuilder1.addOrderBy(Order.asc("xh"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		double ckxsValue = 1.00;//拆扩系数
		double tzxs = 1.00;// 调整系数
		double jxsyf = 0.00; // 机械使用费
		double gytz = 0.00;// 高原调整
		double smtz = 0.00;// 沙漠调整
		double zj = 0.00;// 总计
		while (ro1.next()) {
			Gd06_b3y b3y = (Gd06_b3y) ro1.get(Gd06_b3y.class.getName());

			if (b3y != null) {
				QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd05_b3j.class);
				queryBuilder2.eq("dxgc_id", dxgc_id);
				queryBuilder2.eq("id", b3y.getB3j_id());
				ResultObject ro2 = queryService.search(queryBuilder2);
				Gd05_b3j b3j = new Gd05_b3j();
				if (ro2.next()) {
					b3j = (Gd05_b3j) ro2.get(Gd05_b3j.class.getName());
				}
				if (b3y.getTzxs() != null && b3y.getTzxs().doubleValue() != 0.0) {
					tzxs = b3y.getTzxs().doubleValue();
				}
				double sl = 0.0;
				if (b3j.getSl() != null) {
					sl = b3j.getSl().doubleValue();
				}
				//-----------------------------------------------------------------------
				if(b3j.getCk_bz()!=null){// 查询拆扩系数
					QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder99.eq("lb", b3j.getCk_bz());
					queryBuilder99.eq("sort", new Integer(2));//类别1是人工的，2是机械的
					queryBuilder99.ge("jzbh", b3j.getDebh());//定额编号小于等于终止编号
					queryBuilder99.le("qsbh", b3j.getDebh());//定额编号大于等于起始编号
					ResultObject ro99 = queryService.search(queryBuilder99);
					if(ro99.next()){
						Ga09_kcxs ckxs = (Ga09_kcxs)ro99.get(Ga09_kcxs.class.getName());
						if(ckxs!=null){
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//拆扩调整系数
						}
					}
				}
				//-----------------------------------------------------------------------
				jxsyf = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(sl, b3y
						.getGlsl().doubleValue()), b3y.getDj().doubleValue()), tzxs),ckxsValue), jxsyf);
				list.add(b3y);
			}
			tzxs = 1.00;// 重新置回１
		}
		if(ro1.getLength()!=0){
			Gd06_b3y HJ = new Gd06_b3y();
			HJ.setMc(new String("　　　　　　　合　　　　　计"));
			HJ.setDj(new Double(jxsyf));
			list.add(HJ);// 加上合计
		}

		Gd10_b3fl data12 = new Gd10_b3fl();
		Gd10_b3fl data13 = new Gd10_b3fl();
		if (gd02.getB3_sgtj_bz() != null && gd02.getB3_sgtj_bz().intValue() == 0) {// 是非正常地区
			QueryBuilder queryBuilder12 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder12.eq("dxgc_id", dxgc_id);
			queryBuilder12.eq("fylb", new Integer(1));
			queryBuilder12.eq("bz", new Integer(1));// 取高原的
			queryBuilder12.eq("flag", new Integer(1));
			ResultObject ro12 = queryService.search(queryBuilder12);

			if (ro12.next()) {
				data12 = (Gd10_b3fl) ro12.get(Gd10_b3fl.class.getName());
			}
			if (data12.getDxgc_id() != null) {
				Gd06_b3y GY = new Gd06_b3y();
				StringBuffer mc = new StringBuffer(data12.getMc());
				mc.append("(合计×");
				mc.append(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(NumberFormatUtil.subToDouble(data12.getJxfl().doubleValue(),
						1.00), 100)));
				mc.append("%)");
				GY.setMc(new String(mc));
				gytz = NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jxsyf, data12.getJxfl().doubleValue()), jxsyf);
				GY.setDj(new Double(gytz));
				if(ro1.getLength()!=0){
					list.add(GY);// 加上高原的;
				}
			}

			QueryBuilder queryBuilder13 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder13.eq("dxgc_id", dxgc_id);
			queryBuilder13.eq("fylb", new Integer(1));
			queryBuilder13.eq("bz", new Integer(2));// 取沙漠森林的
			queryBuilder13.eq("flag", new Integer(1));
			ResultObject ro13 = queryService.search(queryBuilder13);

			if (ro13.next()) {
				data13 = (Gd10_b3fl) ro13.get(Gd10_b3fl.class.getName());
			}
			if (data13.getDxgc_id() != null) {
				Gd06_b3y SM = new Gd06_b3y();
				StringBuffer mc = new StringBuffer(data13.getMc());
				mc.append("(合计×");
				mc.append(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(NumberFormatUtil.subToDouble(data13.getJxfl().doubleValue(),
						1.00), 100)));
				mc.append("%)");
				SM.setMc(new String(mc));
				smtz = NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jxsyf, data13.getJxfl().doubleValue()), jxsyf);
				SM.setDj(new Double(smtz));
				if(ro1.getLength()!=0){
					list.add(SM);// 加上沙漠的
				}
			}
		}
		if (data12.getDxgc_id() == null && data13.getDxgc_id() == null && gd02.getB3_jxf_tzxs().doubleValue() == 1.0) {
		} else {
			Gd06_b3y ZJ = new Gd06_b3y();
			StringBuffer zjmc = new StringBuffer("");
			if (gd02.getB3_jxf_tzxs().doubleValue() != 1.0) {
				zjmc = new StringBuffer("总　计");
			} else {
				zjmc = new StringBuffer("　　　　　　　总　　　　　计");
			}
			if (gd02.getB3_jxf_tzxs() != null && gd02.getB3_jxf_tzxs().doubleValue() != 1.0) {// 机械使用费合计调整系数
				zjmc.append("(以上合计");
				zjmc.append(NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf, gytz), smtz)));
				zjmc.append("×机械调整系数 " + NumberFormatUtil.roundToString(gd02.getB3_jxf_tzxs()) + ")");
				zj = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf, gytz), smtz), gd02
						.getB3_jxf_tzxs().doubleValue());
			} else {
				zj = NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jxsyf, gytz), smtz);
			}
			ZJ.setMc(new String(zjmc));
			ZJ.setDj(new Double(zj));
			if(ro1.getLength()!=0){
				list.add(ZJ);
			}
		}
		Gd06_b3y[] data = (Gd06_b3y[]) list.toArray(new Gd06_b3y[list.size()]);

		int pageCount = 1;
		int B3y_onePageRows = printService.getB3y_onePageRows();
		int excelPageRowSize = B3y_onePageRows + 6;
		int pages = printService.getB3ypages(gd02.getId()).intValue();
		for (int j = 0; j < pages; j++) {
			// 写入工作薄
			Label label;
			// 设置列宽
			ws.setColumnView(0 + excelPageRowSize * j, 5);
			ws.setColumnView(1 + excelPageRowSize * j, 14);
			ws.setColumnView(2 + excelPageRowSize * j, 33);
			ws.setColumnView(3 + excelPageRowSize * j, 9);
			ws.setColumnView(4 + excelPageRowSize * j, 11);
			ws.setColumnView(5 + excelPageRowSize * j, 23);
			ws.setColumnView(6 + excelPageRowSize * j, 11);
			ws.setColumnView(7 + excelPageRowSize * j, 11);
			ws.setColumnView(8 + excelPageRowSize * j, 11);
			ws.setColumnView(9 + excelPageRowSize * j, 11);

			ws.setRowView(1 + excelPageRowSize * j, 375);
			// 设置标题
			label = new Label(0, 0 + excelPageRowSize * j, "建筑安装工程机械使用费" + jsjd + "表（表三）乙", this.getTitleCellFormat());
			ws.addCell(label);
			// 合并第一行0-9单元格
			ws.mergeCells(0, 0 + excelPageRowSize * j, 9, 0 + excelPageRowSize * j);
			// 合并工程信息行单元格
			ws.mergeCells(0, 1 + excelPageRowSize * j, 2, 1 + excelPageRowSize * j);
			ws.mergeCells(3, 1 + excelPageRowSize * j, 5, 1 + excelPageRowSize * j);
			ws.mergeCells(6, 1 + excelPageRowSize * j, 7, 1 + excelPageRowSize * j);
			// 设置第一行行高
			ws.setRowView(0 + excelPageRowSize * j, 1000);

			// 设置工程信息行
			label = new Label(0, 1 + excelPageRowSize * j, "工程名称：" + gd02.getGcmc(), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(3, 1 + excelPageRowSize * j, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(6, 1 + excelPageRowSize * j, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(9, 1 + excelPageRowSize * j, "第" + pageCount + "页 总第" + (startPage + (pageCount++)) + "页", this
					.getInfoCellAlignLeftFormat());
			ws.addCell(label);

			ws.mergeCells(6, 2 + excelPageRowSize * j, 7, 2 + excelPageRowSize * j);
			ws.mergeCells(8, 2 + excelPageRowSize * j, 9, 2 + excelPageRowSize * j);
			ws.mergeCells(0, 2 + excelPageRowSize * j, 0, 3 + excelPageRowSize * j);
			ws.mergeCells(1, 2 + excelPageRowSize * j, 1, 3 + excelPageRowSize * j);
			ws.mergeCells(2, 2 + excelPageRowSize * j, 2, 3 + excelPageRowSize * j);
			ws.mergeCells(3, 2 + excelPageRowSize * j, 3, 3 + excelPageRowSize * j);
			ws.mergeCells(4, 2 + excelPageRowSize * j, 4, 3 + excelPageRowSize * j);
			ws.mergeCells(5, 2 + excelPageRowSize * j, 5, 3 + excelPageRowSize * j);
			ws.addCell(new Label(0, 2 + excelPageRowSize * j, "序号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 2 + excelPageRowSize * j, "定额编号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 2 + excelPageRowSize * j, "项目名称", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 2 + excelPageRowSize * j, "单位", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 2 + excelPageRowSize * j, "数量", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 2 + excelPageRowSize * j, "机械名称", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 2 + excelPageRowSize * j, "单位定额值", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 2 + excelPageRowSize * j, "合计值", this.getTextCellAlignCenterFormat()));

			ws.addCell(new Label(6, 3 + excelPageRowSize * j, "数量(台班)", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 3 + excelPageRowSize * j, "单价（元）", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 3 + excelPageRowSize * j, "数量（台班）", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, 3 + excelPageRowSize * j, "单价（元）", this.getTextCellAlignCenterFormat()));
			ws.setRowView(2 + excelPageRowSize * j, 375);
			ws.setRowView(3 + excelPageRowSize * j, 375);
			ws.setRowView(4 + excelPageRowSize * j, 375);
			ws.addCell(new Label(0, 4 + excelPageRowSize * j, "I", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 4 + excelPageRowSize * j, "II", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 4 + excelPageRowSize * j, "III", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 4 + excelPageRowSize * j, "IV", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 4 + excelPageRowSize * j, "V", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 4 + excelPageRowSize * j, "VI", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 4 + excelPageRowSize * j, "VII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 4 + excelPageRowSize * j, "VIII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 4 + excelPageRowSize * j, "IX", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, 4 + excelPageRowSize * j, "X", this.getTextCellAlignCenterFormat()));

			int b = j * 18;
			int i = j * 18;
			int lines = 5 + excelPageRowSize * j;
			for (; i < b + 18; i++) {
				if (i < list.size() && data[i] != null) {
					PrintB3ybVo b3ybVo = new PrintB3ybVo();
					if (data[i].getBh() != null) {// 不是合计部分
						QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd05_b3j.class);
						queryBuilder9.eq("id", data[i].getB3j_id());
						ResultObject ro9 = queryService.search(queryBuilder9);
						Gd05_b3j data9 = new Gd05_b3j();
						if (ro9.next()) {
							data9 = (Gd05_b3j) ro9.get(Gd05_b3j.class.getName());
						}
						if (data[i].getXh() != null) {
							b3ybVo.setXh(data[i].getXh().toString());
						} else {
							b3ybVo.setXh(String.valueOf(i + 1));
						}
						b3ybVo.setDebh(data9.getDebh());
						//----------------是有拆扩系数的-------------
			  			StringBuffer mc = new StringBuffer(data9.getDemc());
			  			double ckxsz =1.00;//拆扩系数
			  			if (data9.getCk_bz() != null) {// 查询拆扩系数
							QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Ga09_kcxs.class);
							queryBuilder4.eq("lb", data9.getCk_bz());
							queryBuilder4.eq("sort",new Integer(2));//类别：1是人工的；2是机械的
							queryBuilder4.ge("jzbh", data9.getDebh());//定额编号小于等于终止编号
							queryBuilder4.le("qsbh", data9.getDebh());//定额编号大于等于起始编号
							ResultObject ro4 = queryService.search(queryBuilder4);
							Ga09_kcxs ckxs = new Ga09_kcxs();
							if (ro4.next()) {
								ckxs = (Ga09_kcxs) ro4.get(Ga09_kcxs.class.getName());
								if (ckxs != null) {
									if (data9.getCk_bz().intValue() == 1) {
										mc.append("（新建 机械×");
									} else if (data9.getCk_bz().intValue() == 2) {
										mc.append("（扩建 机械×");
									} else if (data9.getCk_bz().intValue() == 3) {
										mc.append("（拆除再利用 机械×");
									} else if (data9.getCk_bz().intValue() == 4) {
										mc.append("（拆除不再利用 机械×");
									} else if (data9.getCk_bz().intValue() == 5) {
										mc.append("（更换 机械×");
									}
									mc.append(NumberFormatUtil.roundToString(ckxs.getXs().doubleValue()));
									mc.append("%）");
									ckxsz = NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);
								}
								
							}
						}
			  			b3ybVo.setDemc(new String(mc));
						b3ybVo.setDw(data9.getDw());
						b3ybVo.setSl(NumberFormatUtil.roundToString(data9.getSl()));
						b3ybVo.setJxmc(data[i].getMc());
						b3ybVo.setDwsl(NumberFormatUtil.roundToString(data[i].getGlsl()));
						b3ybVo.setDwdj(NumberFormatUtil.roundToString(data[i].getDj()));
						b3ybVo.setHjsl(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data9.getSl().doubleValue(), data[i].getGlsl()
								.doubleValue())));
						b3ybVo.setHjjg(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil
								.mulToDouble(data9.getSl().doubleValue(), data[i].getDj().doubleValue()), data[i].getGlsl().doubleValue()), data[i]
								.getTzxs().doubleValue()),ckxsz)));
					} else {
						b3ybVo.setDemc(data[i].getMc());
						b3ybVo.setHjjg(NumberFormatUtil.roundToString(data[i].getDj()));
					}
					String xh = "";
					if (b3ybVo.getXh() != null) {
						xh = b3ybVo.getXh();
					}
					String debh = "";
					if (b3ybVo.getDebh() != null) {
						debh = b3ybVo.getDebh();
					}
					String demc = "";
					if (b3ybVo.getDemc() != null) {
						demc = b3ybVo.getDemc();
					}
					String bh = "";
					if (b3ybVo.getDw() != null) {
						bh = b3ybVo.getDw();
					}
					String sl = "";
					if (b3ybVo.getSl() != null) {
						sl = NumberFormatUtil.roundToString(b3ybVo.getSl(), 3);
					}
					String jxmc = "";
					if (b3ybVo.getJxmc() != null) {
						jxmc = b3ybVo.getJxmc();
					}
					String dwsl = "";
					if (b3ybVo.getDwsl() != null && !b3ybVo.getDwsl().equals("0.00")) {
						dwsl = b3ybVo.getDwsl();
					}
					String dwdj = "";
					if (b3ybVo.getDwdj() != null && !b3ybVo.getDwdj().equals("0.00")) {
						dwdj = b3ybVo.getDwdj();
					}
					String hjsl = "";
					if (b3ybVo.getHjsl() != null && !b3ybVo.getHjsl().equals("0.00")) {
						hjsl = b3ybVo.getHjsl();
					}
					String hjjg = "";
					if (b3ybVo.getHjjg() != null && !b3ybVo.getHjjg().equals("0.00")) {
						hjjg = b3ybVo.getHjjg();
					}
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, xh, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, debh, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, demc, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, bh, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(4, lines, sl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, jxmc, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(6, lines, dwsl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, dwdj, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, hjsl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(9, lines, hjjg, this.getTextCellAlignRightFormat()));
				} else {
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, "", this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(4, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(6, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(9, lines, "", this.getTextCellAlignRightFormat()));
				}
				lines++;
			}
			/**
			 * 处理审核信息行
			 */
			ws.setRowView(lines, 375);
			ws.mergeCells(0, lines, 1, lines);
			ws.mergeCells(2, lines, 3, lines);
			ws.mergeCells(4, lines, 6, lines);
			ws.mergeCells(7, lines, 9, lines);
			ws.addCell(new Label(0, lines, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(2, lines, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(4, lines, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(7, lines, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this.getInfoCellAlignRightFormat()));
			ws.addRowPageBreak(B3y_onePageRows + excelPageRowSize * j + 6);
		}
	}

	/**
	 * 输出表3丙信息Excel
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB3btoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		// TODO Auto-generated method stub
		this.formatWritableSheet(ws);
		Gd02_dxgc gd02;
		// 获取单项工程信息
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}
		List list = new ArrayList();
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id", dxgc_id);
		queryBuilder1.eq("lb", new String("YB"));
		queryBuilder1.addOrderBy(Order.asc("xh"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		double tzxs = 1.00;// 调整系数
		double ybhjtzxs = 1.00;// 仪表合计调整系数
		double zj = 0.00;// 总计
		double hj = 0.00;// 合计
		double ybsyf = 0.00;// 仪表使用费
		while (ro1.next()) {
			Gd06_b3y b3y = (Gd06_b3y) ro1.get(Gd06_b3y.class.getName());
			if (b3y != null) {
				QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd05_b3j.class);
				queryBuilder2.eq("dxgc_id", dxgc_id);
				queryBuilder2.eq("id", b3y.getB3j_id());
				ResultObject ro2 = queryService.search(queryBuilder2);
				Gd05_b3j b3j = new Gd05_b3j();
				if (ro2.next()) {
					b3j = (Gd05_b3j) ro2.get(Gd05_b3j.class.getName());
				}
				if (b3y.getTzxs() != null && b3y.getTzxs().doubleValue() != 0.0) {
					tzxs = b3y.getTzxs().doubleValue();
				}
				double sl = 0.0;
				if (b3j.getSl() != null) {
					sl = b3j.getSl().doubleValue();
				}
				ybsyf = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(sl, b3y
						.getGlsl().doubleValue()), b3y.getDj().doubleValue()), tzxs), ybsyf);
				list.add(b3y);
			}
			tzxs = 1.00;// 重新置回１
		}
		hj = ybsyf;
		if (gd02.getB3_ybf_tzxs() != null) {
			ybhjtzxs = gd02.getB3_ybf_tzxs().doubleValue();
			zj = NumberFormatUtil.mulToDouble(ybsyf, ybhjtzxs);
		}
		if(ro1.getLength()!=0){
			Gd06_b3y HJ = new Gd06_b3y();
			HJ.setMc(new String("　　　　　　　合　　　　　计"));
			HJ.setDj(new Double(hj));
			list.add(HJ);
		}

		if (gd02.getB3_ybf_tzxs() != null && gd02.getB3_ybf_tzxs().doubleValue() != 1.0) {
			Gd06_b3y ZJ = new Gd06_b3y();
			StringBuffer zjmc = new StringBuffer("");
			if (gd02.getB3_jxf_tzxs().doubleValue() != 1.0) {
				zjmc = new StringBuffer("总　计");
			} else {
				zjmc = new StringBuffer("　　　　　　　总　　　　　计");
			}
			if (gd02.getB3_ybf_tzxs() != null && gd02.getB3_ybf_tzxs().doubleValue() != 1.0) {
				zjmc.append("(以上合计 ");
				zjmc.append(NumberFormatUtil.roundToString(hj));
				zjmc.append("×仪表调整系数 " + NumberFormatUtil.roundToString(ybhjtzxs));
				zjmc.append(")");
			}
			// else{
			// zjmc.append(NumberFormatUtil.roundToString(hj));
			// }
			ZJ.setMc(new String(zjmc));
			ZJ.setDj(new Double(zj));
			if(ro1.getLength()!=0){
				list.add(ZJ);
			}
		}
		Gd06_b3y[] data = (Gd06_b3y[]) list.toArray(new Gd06_b3y[list.size()]);

		int pageCount = 1;
		int B3y_onePageRows = printService.getB3y_onePageRows();
		int excelPageRowSize = B3y_onePageRows + 6;
		int pages = printService.getB3bpages(gd02.getId()).intValue();
		for (int j = 0; j < pages; j++) {
			// 写入工作薄
			Label label;
			// 设置列宽
			ws.setColumnView(0 + excelPageRowSize * j, 5);
			ws.setColumnView(1 + excelPageRowSize * j, 14);
			ws.setColumnView(2 + excelPageRowSize * j, 33);
			ws.setColumnView(3 + excelPageRowSize * j, 9);
			ws.setColumnView(4 + excelPageRowSize * j, 11);
			ws.setColumnView(5 + excelPageRowSize * j, 23);
			ws.setColumnView(6 + excelPageRowSize * j, 11);
			ws.setColumnView(7 + excelPageRowSize * j, 11);
			ws.setColumnView(8 + excelPageRowSize * j, 11);
			ws.setColumnView(9 + excelPageRowSize * j, 11);

			ws.setRowView(1 + excelPageRowSize * j, 375);
			// 设置标题
			label = new Label(0, 0 + excelPageRowSize * j, "建筑安装工程仪器仪表使用费" + jsjd + "表（表三）丙", this.getTitleCellFormat());
			ws.addCell(label);
			// 合并第一行0-9单元格
			ws.mergeCells(0, 0 + excelPageRowSize * j, 9, 0 + excelPageRowSize * j);
			// 合并工程信息行单元格
			ws.mergeCells(0, 1 + excelPageRowSize * j, 2, 1 + excelPageRowSize * j);
			ws.mergeCells(3, 1 + excelPageRowSize * j, 5, 1 + excelPageRowSize * j);
			ws.mergeCells(6, 1 + excelPageRowSize * j, 7, 1 + excelPageRowSize * j);
			// 设置第一行行高
			ws.setRowView(0 + excelPageRowSize * j, 1000);

			// 设置工程信息行
			label = new Label(0, 1 + excelPageRowSize * j, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(3, 1 + excelPageRowSize * j, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(6, 1 + excelPageRowSize * j, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(9, 1 + excelPageRowSize * j, "第" + pageCount + "页 总第" + (startPage + (pageCount++)) + "页", this
					.getInfoCellAlignLeftFormat());
			ws.addCell(label);

			ws.mergeCells(6, 2 + excelPageRowSize * j, 7, 2 + excelPageRowSize * j);
			ws.mergeCells(8, 2 + excelPageRowSize * j, 9, 2 + excelPageRowSize * j);
			ws.mergeCells(0, 2 + excelPageRowSize * j, 0, 3 + excelPageRowSize * j);
			ws.mergeCells(1, 2 + excelPageRowSize * j, 1, 3 + excelPageRowSize * j);
			ws.mergeCells(2, 2 + excelPageRowSize * j, 2, 3 + excelPageRowSize * j);
			ws.mergeCells(3, 2 + excelPageRowSize * j, 3, 3 + excelPageRowSize * j);
			ws.mergeCells(4, 2 + excelPageRowSize * j, 4, 3 + excelPageRowSize * j);
			ws.mergeCells(5, 2 + excelPageRowSize * j, 5, 3 + excelPageRowSize * j);
			ws.addCell(new Label(0, 2 + excelPageRowSize * j, "序号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 2 + excelPageRowSize * j, "定额编号", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 2 + excelPageRowSize * j, "项目名称", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 2 + excelPageRowSize * j, "单位", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 2 + excelPageRowSize * j, "数量", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 2 + excelPageRowSize * j, "仪表名称", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 2 + excelPageRowSize * j, "单位定额值", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 2 + excelPageRowSize * j, "合计值", this.getTextCellAlignCenterFormat()));

			ws.addCell(new Label(6, 3 + excelPageRowSize * j, "数量(台班)", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 3 + excelPageRowSize * j, "单价（元）", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 3 + excelPageRowSize * j, "数量（台班）", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, 3 + excelPageRowSize * j, "单价（元）", this.getTextCellAlignCenterFormat()));
			ws.setRowView(2 + excelPageRowSize * j, 375);
			ws.setRowView(3 + excelPageRowSize * j, 375);
			ws.setRowView(4 + excelPageRowSize * j, 375);
			ws.addCell(new Label(0, 4 + excelPageRowSize * j, "I", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, 4 + excelPageRowSize * j, "II", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, 4 + excelPageRowSize * j, "III", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(3, 4 + excelPageRowSize * j, "IV", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, 4 + excelPageRowSize * j, "V", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, 4 + excelPageRowSize * j, "VI", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, 4 + excelPageRowSize * j, "VII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, 4 + excelPageRowSize * j, "VIII", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, 4 + excelPageRowSize * j, "IX", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, 4 + excelPageRowSize * j, "X", this.getTextCellAlignCenterFormat()));

			int b = j * 18;
			int i = j * 18;
			int lines = 5 + excelPageRowSize * j;
			for (; i < b + 18; i++) {
				if (i < list.size() && data[i] != null) {
					PrintB3ybVo b3ybVo = new PrintB3ybVo();
					if (data[i].getBh() != null) {// 不是合计部分
						QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd05_b3j.class);
						queryBuilder9.eq("id", data[i].getB3j_id());
						ResultObject ro9 = queryService.search(queryBuilder9);
						Gd05_b3j data9 = new Gd05_b3j();
						if (ro9.next()) {
							data9 = (Gd05_b3j) ro9.get(Gd05_b3j.class.getName());
						}
						if (data[i].getXh() != null) {
							b3ybVo.setXh(data[i].getXh().toString());
						} else {
							b3ybVo.setXh(String.valueOf(i + 1));
						}
						b3ybVo.setDebh(data9.getDebh());
						b3ybVo.setDemc(data9.getDemc());
						b3ybVo.setDw(data9.getDw());
						b3ybVo.setSl(NumberFormatUtil.roundToString(data9.getSl()));
						b3ybVo.setYbmc(data[i].getMc());
						b3ybVo.setDwsl(NumberFormatUtil.roundToString(data[i].getGlsl()));
						b3ybVo.setDwdj(NumberFormatUtil.roundToString(data[i].getDj()));
						b3ybVo.setHjsl(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(data9.getSl().doubleValue(), data[i].getGlsl()
								.doubleValue())));
						b3ybVo.setHjjg(NumberFormatUtil.roundToString(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil
								.mulToDouble(data9.getSl().doubleValue(), data[i].getDj().doubleValue()), data[i].getGlsl().doubleValue()), data[i]
								.getTzxs().doubleValue())));
					} else {
						b3ybVo.setDemc(data[i].getMc());
						b3ybVo.setHjjg(NumberFormatUtil.roundToString(data[i].getDj()));
					}
					String xh = "";
					if (b3ybVo.getXh() != null) {
						xh = b3ybVo.getXh();
					}
					String debh = "";
					if (b3ybVo.getDebh() != null) {
						debh = b3ybVo.getDebh();
					}
					String demc = "";
					if (b3ybVo.getDemc() != null) {
						demc = b3ybVo.getDemc();
					}
					String dw = "";
					if (b3ybVo.getDw() != null) {
						dw = b3ybVo.getDw();
					}
					String sl = "";
					if (b3ybVo.getSl() != null) {
						sl = NumberFormatUtil.roundToString(b3ybVo.getSl(), 3);
					}
					String ybmc = "";
					if (b3ybVo.getYbmc() != null) {
						ybmc = b3ybVo.getYbmc();
					}
					String dwsl = "";
					if (b3ybVo.getDwsl() != null && !b3ybVo.getDwsl().equals("0.00")) {
						dwsl = b3ybVo.getDwsl();
					}
					String dwdj = "";
					if (b3ybVo.getDwdj() != null && !b3ybVo.getDwdj().equals("0.00")) {
						dwdj = b3ybVo.getDwdj();
					}
					String hjsl = "";
					if (b3ybVo.getHjsl() != null && !b3ybVo.getHjsl().equals("0.00")) {
						hjsl = b3ybVo.getHjsl();
					}
					String hjjg = "";
					if (b3ybVo.getHjjg() != null && !b3ybVo.getHjjg().equals("0.00")) {
						hjjg = b3ybVo.getHjjg();
					}
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, xh, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, debh, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, demc, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, dw, this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(4, lines, sl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, ybmc, this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(6, lines, dwsl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, dwdj, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, hjsl, this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(9, lines, hjjg, this.getTextCellAlignRightFormat()));
				} else {
					ws.setRowView(lines, 375);
					ws.addCell(new Label(0, lines, "", this.getTextCellAlignCenterFormat()));
					ws.addCell(new Label(1, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(2, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(3, lines, "", this.getTextCellAlignLeftFormat()));
					ws.addCell(new Label(4, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(5, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(6, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(7, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(8, lines, "", this.getTextCellAlignRightFormat()));
					ws.addCell(new Label(9, lines, "", this.getTextCellAlignRightFormat()));
				}
				lines++;
			}
			/**
			 * 处理审核信息行
			 */
			ws.setRowView(lines, 375);
			ws.mergeCells(0, lines, 1, lines);
			ws.mergeCells(2, lines, 3, lines);
			ws.mergeCells(4, lines, 6, lines);
			ws.mergeCells(7, lines, 9, lines);
			ws.addCell(new Label(0, lines, "设计负责人：" + gd02.getSjfzr(), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(2, lines, "审核：" + gd02.getShr(), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(4, lines, "编制：" + gd02.getBzr(), this.getInfoCellAlignLeftFormat()));
			ws.addCell(new Label(7, lines, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this.getInfoCellAlignRightFormat()));

			ws.addRowPageBreak(B3y_onePageRows + excelPageRowSize * j + 6);
		}
	}

	/**
	 * 表1Excel输出
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB1toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		// TODO Auto-generated method stub
		this.formatWritableSheet(ws);

		Gd02_dxgc gd02;
		// 获取单项工程信息
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);

		Gd01_gcxm gd01 = new Gd01_gcxm();
		QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd01_gcxm.class);
		queryBuilder9.eq("id", gd02.getGcxm_id());
		ResultObject ro9 = queryService.search(queryBuilder9);
		if (ro9.next()) {
			gd01 = (Gd01_gcxm) ro9.get(Gd01_gcxm.class.getName());
		}
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}
		// 写入工作薄
		Label label;
		// 设置列宽
		ws.setColumnView(0, 5);
		ws.setColumnView(1, 13);
		ws.setColumnView(2, 30);
		ws.setColumnView(3, 11);
		ws.setColumnView(4, 11);
		ws.setColumnView(5, 12);
		ws.setColumnView(6, 11);
		ws.setColumnView(7, 12);
		ws.setColumnView(8, 12);
		ws.setColumnView(9, 11);
		ws.setColumnView(10, 11);

		// 设置第一行行高
		ws.setRowView(0, 625);

		ws.setRowView(1, 375);
		// 设置标题
		label = new Label(0, 0, "工程" + jsjd + "总表（表一）", this.getTitleCellFormat());
		ws.addCell(label);
		// 合并第一行0-9单元格
		ws.mergeCells(0, 0, 10, 0);

		ws.mergeCells(0, 1, 10, 1);

		label = new Label(0, 1, "建设项目名称：" + gd01.getXmmc(), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		// 合并工程信息行单元格
		ws.mergeCells(0, 2, 2, 2);
		ws.mergeCells(3, 2, 5, 2);
		ws.mergeCells(6, 2, 7, 2);

		// 设置工程信息行
		ws.setRowView(2, 375);
		label = new Label(0, 2, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(3, 2, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(8, 2, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
		ws.addCell(label);
		label = new Label(10, 2, "第" + 1 + "页 总第" + (startPage + 1) + "页", this.getInfoCellAlignLeftFormat());
		ws.addCell(label);

		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder1.eq("dxgc_id", gd02.getId());
		ResultObject ro1 = queryService.search(queryBuilder1);
		Gd03_gcfysz gd03 = new Gd03_gcfysz();
		HashMap bg = new HashMap();
		HashMap gs = new HashMap();
		HashMap jsgs = new HashMap();
		while (ro1.next()) {
			gd03 = (Gd03_gcfysz) ro1.get(Gd03_gcfysz.class.getName());
			if (gd03 != null) {
				bg.put(gd03.getFymc(), gd03.getFyz());
				gs.put(gd03.getFymc(), gd03.getGsbds());
				jsgs.put(gd03.getFymc(), gd03.getJsgs());
			}
		}

		ws.mergeCells(0, 3, 0, 5);
		ws.mergeCells(1, 3, 1, 5);
		ws.mergeCells(2, 3, 2, 5);
		ws.mergeCells(3, 5, 8, 5);
		ws.mergeCells(7, 3, 7, 4);
		ws.mergeCells(8, 3, 8, 4);
		ws.mergeCells(9, 3, 10, 4);
		ws.setRowView(3, 300);
		ws.setRowView(4, 300);
		ws.setRowView(5, 375);
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat no_bottom = new WritableCellFormat(wf);
		no_bottom.setAlignment(Alignment.CENTRE);
		no_bottom.setVerticalAlignment(VerticalAlignment.CENTRE);
		no_bottom.setBorder(Border.TOP, BorderLineStyle.THIN);
		no_bottom.setBorder(Border.LEFT, BorderLineStyle.THIN);
		no_bottom.setBorder(Border.RIGHT, BorderLineStyle.THIN);
		ws.addCell(new Label(0, 3, "序号", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(1, 3, "表格编号", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(2, 3, "费用名称", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(3, 3, "小型建筑", no_bottom));
		ws.addCell(new Label(4, 3, "需要安装", no_bottom));
		ws.addCell(new Label(5, 3, "不需要安装的", no_bottom));
		ws.addCell(new Label(6, 3, "建筑安装", no_bottom));
		ws.addCell(new Label(7, 3, "其他费用", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(8, 3, "预备费", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(9, 3, "总价值", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(3, 5, "（元）", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(9, 5, "人民币（元）", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(10, 5, "其中外币（）", this.getTextCellAlignCenterFormat()));

		WritableCellFormat no_top = new WritableCellFormat(wf);
		no_top.setAlignment(Alignment.CENTRE);
		no_top.setVerticalAlignment(VerticalAlignment.CENTRE);
		no_top.setBorder(Border.BOTTOM, BorderLineStyle.THIN);
		no_top.setBorder(Border.LEFT, BorderLineStyle.THIN);
		no_top.setBorder(Border.RIGHT, BorderLineStyle.THIN);

		ws.addCell(new Label(3, 4, "工程费", no_top));
		ws.addCell(new Label(4, 4, "的设备费", no_top));
		ws.addCell(new Label(5, 4, "设备、工器具费", no_top));
		ws.addCell(new Label(6, 4, "工程费", no_top));

		ws.setRowView(6, 375);
		ws.addCell(new Label(0, 6, "I", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(1, 6, "II", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(2, 6, "III", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(3, 6, "IV", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(4, 6, "V", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(5, 6, "VI", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(6, 6, "VII", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(7, 6, "VIII", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(8, 6, "IX", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(9, 6, "X", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(10, 6, "XI", this.getTextCellAlignCenterFormat()));

		int j = 0;
		int m = 6;
		if (NumberFormatUtil.roundToString((Double) bg.get("建筑安装工程费")) != "" &&(Double) bg.get("建筑安装工程费")!=null && NumberFormatUtil.roundToString((Double) bg.get("建筑安装工程费")) != "0.00") {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m,StringFormatUtil.format(gd02.getBgbh()) + "-B2", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "建筑安装工程费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignLeftFormat()));
			String jaf = "";
			if (bg.get("建筑安装工程费") != null && ((Double) bg.get("建筑安装工程费")).doubleValue() != 0.0) {
				jaf = NumberFormatUtil.roundToString((Double) bg.get("建筑安装工程费"));
			}
			ws.addCell(new Label(6, m, jaf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(9, m, jaf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignLeftFormat()));
		}

		if (NumberFormatUtil.roundToString((Double) bg.get("光电缆设备费")) != ""
				&& !"0.00".equals(NumberFormatUtil.roundToString((Double) bg.get("光电缆设备费")))) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B4J[GDLSBF]", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "光电缆设备费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignLeftFormat()));
			String gdl = "";
			if (bg.get("光电缆设备费") != null && ((Double) bg.get("光电缆设备费")).doubleValue() != 0.0) {
				gdl = NumberFormatUtil.roundToString((Double) bg.get("光电缆设备费"));
			}
			ws.addCell(new Label(6, m, gdl, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(9, m, gdl, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignLeftFormat()));
		}
		if (NumberFormatUtil.roundToString((Double) bg.get("需安设备费")) != ""
				&& !"0.00".equals(NumberFormatUtil.roundToString((Double) bg.get("需安设备费")))) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B4J[XASBF]", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "国内需安设备费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignLeftFormat()));
			String xasb = "";
			if (bg.get("需安设备费") != null && ((Double) bg.get("需安设备费")).doubleValue() != 0.0) {
				xasb = NumberFormatUtil.roundToString((Double) bg.get("需安设备费"));
			}
			ws.addCell(new Label(4, m, xasb, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(9, m, xasb, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignRightFormat()));
		}
		if (NumberFormatUtil.roundToString((Double) bg.get("不需安设备费")) != ""
				&& !"0.00".equals(NumberFormatUtil.roundToString((Double) bg.get("不需安设备费")))) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B4J[BXASBF]", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "国内不需安设备费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignLeftFormat()));
			String xasb = "";
			if (bg.get("不需安设备费") != null && ((Double) bg.get("不需安设备费")).doubleValue() != 0.0) {
				xasb = NumberFormatUtil.roundToString((Double) bg.get("不需安设备费"));
			}
			ws.addCell(new Label(5, m, xasb, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(8, m, xasb, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(9, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignLeftFormat()));
		}
		if (NumberFormatUtil.roundToString((Double) bg.get("备品备件")) != "" && !"0.00".equals(NumberFormatUtil.roundToString((Double) bg.get("备品备件")))) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B4[BPBJF]", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "国内备品备件费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			String bpbj = "";
			if (bg.get("备品备件") != null && ((Double) bg.get("备品备件")).doubleValue() != 0.0) {
				bpbj = NumberFormatUtil.roundToString((Double) bg.get("备品备件"));
			}
			ws.addCell(new Label(5, m, bpbj, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, bpbj, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}

		if (NumberFormatUtil.roundToString((Double) bg.get("表5合计其他费")) != ""
				&& !"0.00".equals(NumberFormatUtil.roundToString((Double) bg.get("表5合计其他费")))) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, String.valueOf(j), this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B5J", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "工程建设其他费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignLeftFormat()));
			String b5hjqtf = "";
			if (bg.get("表5合计其他费") != null && ((Double) bg.get("表5合计其他费")).doubleValue() != 0.0) {
				b5hjqtf = NumberFormatUtil.roundToString((Double) bg.get("表5合计其他费"));
			}
			ws.addCell(new Label(7, m, b5hjqtf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(9, m, b5hjqtf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignLeftFormat()));
		}
		
		String zhj=NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil
				.roundToDouble((Double) bg.get("需安设备费")), NumberFormatUtil.roundToDouble((Double) bg.get("不需安设备费"))), NumberFormatUtil.addToString(
						NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double) bg.get("建筑安装工程费")), NumberFormatUtil.roundToDouble((Double) bg
								.get("光电缆设备费"))), NumberFormatUtil.roundToString((Double) bg.get("表5合计其他费")))), NumberFormatUtil.roundToString((Double) bg
						.get("备品备件")));
		if(zhj.equals("0.00")){
			zhj="";
		}
		if(!zhj.equals("")){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "　　　　　合　　　　　计", this.getTextCellAlignCenterFormat()));
			String xasbf = "";
			if (bg.get("需安设备费") != null && ((Double) bg.get("需安设备费")).doubleValue() != 0.0) {
				xasbf = NumberFormatUtil.roundToString((Double) bg.get("需安设备费"));
			}
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, xasbf, this.getTextCellAlignRightFormat()));
			String bxasbf ="";
			if(!(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")))).equals("0.00") ){
				bxasbf=NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")));
			}
			ws.addCell(new Label(5, m, bxasbf, this.getTextCellAlignRightFormat()));
			String jzazf=NumberFormatUtil.roundToString((Double) bg.get("建筑安装工程费"));
			if(jzazf.equals("0.00")){
				jzazf ="";
			}
			ws.addCell(new Label(6, m, jzazf, this.getTextCellAlignRightFormat()));
			String b5hjqf=NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double) bg
					.get("光电缆设备费")), NumberFormatUtil.roundToDouble((Double) bg.get("表5合计其他费"))));
			if(b5hjqf.equals("0.00")){
				b5hjqf ="";
			}
			ws.addCell(new Label(7, m, b5hjqf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			
			ws.addCell(new Label(9, m, zhj, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("预备费") != null &&(Double) bg.get("预备费")!=null && ((Double) bg.get("预备费")).doubleValue() != 0.0){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "1", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "预备费（工程费+其他费）× 4.0%", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			String ybf = "";
			if (bg.get("预备费") != null && ((Double) bg.get("预备费")).doubleValue() != 0.0) {
				ybf = NumberFormatUtil.roundToString((Double) bg.get("预备费"));
			}
			ws.addCell(new Label(8, m, ybf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(9, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}

		if (bg.get("建设期利息") != null &&(Double) bg.get("建设期利息")!=null && ((Double) bg.get("建设期利息")).doubleValue() != 0.0){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "2", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "建设期利息", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			String jsqlx = "";
			if (bg.get("建设期利息") != null && ((Double) bg.get("建设期利息")).doubleValue() != 0.0) {
				jsqlx = NumberFormatUtil.roundToString((Double) bg.get("建设期利息"));
			}
			ws.addCell(new Label(7, m, jsqlx, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("建筑工程费") != null &&(Double) bg.get("建筑工程费")!=null && ((Double) bg.get("建筑工程费")).doubleValue() != 0.0){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "3", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "建筑工程费", this.getTextCellAlignLeftFormat()));
			String jzgcf = "";
			if (bg.get("建筑工程费") != null && ((Double) bg.get("建筑工程费")).doubleValue() != 0.0) {
				jzgcf = NumberFormatUtil.roundToString((Double) bg.get("建筑工程费"));
			}
			ws.addCell(new Label(3, m, jzgcf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		String zhj2=NumberFormatUtil.addToString(NumberFormatUtil.roundToString(NumberFormatUtil.addToString(NumberFormatUtil
				.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double) bg.get("需安设备费")), NumberFormatUtil
						.roundToDouble((Double) bg.get("不需安设备费"))), NumberFormatUtil.addToString(NumberFormatUtil
						.addToString(NumberFormatUtil.roundToDouble((Double) bg.get("建筑安装工程费")), NumberFormatUtil.roundToDouble((Double) bg
								.get("光电缆设备费"))), NumberFormatUtil.roundToString((Double) bg.get("表5合计其他费")))), NumberFormatUtil
				.roundToString(NumberFormatUtil.roundToString((Double)bg.get("预备费"))))), NumberFormatUtil.roundToString((Double) bg.get("建筑工程费")));
		if(zhj2.equals("0.00")){
			zhj2="";
		}
		if(!zhj2.equals("")){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "　　　　 总　　　　　计", this.getTextCellAlignCenterFormat()));
			String jzgcf1 = "";
			if (bg.get("建筑工程费") != null && ((Double) bg.get("建筑工程费")).doubleValue() != 0.0) {
				jzgcf1 = NumberFormatUtil.roundToString((Double) bg.get("建筑工程费"));
			}
			ws.addCell(new Label(3, m, jzgcf1, this.getTextCellAlignRightFormat()));
			String xasbf1 = "";
			if (bg.get("需安设备费") != null && ((Double) bg.get("需安设备费")).doubleValue() != 0.0) {
				xasbf1 = NumberFormatUtil.roundToString((Double) bg.get("需安设备费"));
			}
			ws.addCell(new Label(4, m, xasbf1, this.getTextCellAlignRightFormat()));
			String bxasbf1="";
			if(!(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")))).equals("0.00") ){
				bxasbf1=NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double)bg.get("不需安设备费")),NumberFormatUtil.roundToString((Double)bg.get("备品备件")));
			}
			ws.addCell(new Label(5, m, bxasbf1, this.getTextCellAlignRightFormat()));
			String jaf=NumberFormatUtil.roundToString((Double) bg.get("建筑安装工程费"));
			if(jaf.equals("0.00")){
				jaf="";
			}
			ws.addCell(new Label(6, m, jaf, this.getTextCellAlignRightFormat()));
			String b5qt=NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil
					.roundToDouble((Double) bg.get("光电缆设备费")), NumberFormatUtil.roundToDouble((Double) bg.get("表5合计其他费"))), NumberFormatUtil
					.roundToDouble((Double) bg.get("建设期利息"))));
			if(b5qt.equals("0.00")){
				b5qt="";
			}
			ws.addCell(new Label(7, m,b5qt , this.getTextCellAlignRightFormat()));
			String ybf1=NumberFormatUtil.roundToString((Double) bg.get("预备费"));
			if(ybf1.equals("0.00")){
				ybf1="";
			}
			ws.addCell(new Label(8, m, ybf1, this.getTextCellAlignRightFormat()));
			
			ws.addCell(new Label(9, m, zhj2, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("生产准备及开办费") != null && (Double) bg.get("生产准备及开办费")!=null && ((Double) bg.get("生产准备及开办费")).doubleValue() != 0.0) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "1", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(2, m, "生产准备及开办费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			String sczbjkbf = "";
			if (bg.get("生产准备及开办费") != null && ((Double) bg.get("生产准备及开办费")).doubleValue() != 0.0) {
				sczbjkbf = NumberFormatUtil.roundToString((Double) bg.get("生产准备及开办费"));
			}
			ws.addCell(new Label(7, m, sczbjkbf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, sczbjkbf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("维护器具费") != null &&(Double) bg.get("维护器具费")!=null&& ((Double) bg.get("维护器具费")).doubleValue() != 0.0){
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "2", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-B4J[WHQJ]", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "国内维护器具费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
			String whqjf = "";
			if (bg.get("维护器具费") != null && ((Double) bg.get("维护器具费")).doubleValue() != 0.0) {
				whqjf = NumberFormatUtil.roundToString((Double) bg.get("维护器具费"));
			}
			ws.addCell(new Label(5, m, whqjf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, whqjf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("回收设备费") != null &&(Double) bg.get("回收设备费")!=null && ((Double) bg.get("回收设备费")).doubleValue() != 0.0) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "3", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-HSSB", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "回收设备费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			String hssbf = "";
			if (bg.get("回收设备费") != null && ((Double) bg.get("回收设备费")).doubleValue() != 0.0) {
				hssbf = NumberFormatUtil.roundToString((Double) bg.get("回收设备费"));
			}
			ws.addCell(new Label(4, m, hssbf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, hssbf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		if (bg.get("回收主材费") != null && (Double) bg.get("回收主材费")!=null && ((Double) bg.get("回收主材费")).doubleValue() != 0.0) {
			m++;
			j++;
			ws.setRowView(m, 375);
			ws.addCell(new Label(0, m, "4", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(1, m, StringFormatUtil.format(gd02.getBgbh()) + "-HSZC", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(2, m, "回收主材费", this.getTextCellAlignLeftFormat()));
			ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
			String hszcf = "";
			if (bg.get("回收主材费") != null && ((Double) bg.get("回收主材费")).doubleValue() != 0.0) {
				hszcf = NumberFormatUtil.roundToString((Double) bg.get("回收主材费"));
			}
			ws.addCell(new Label(4, m, hszcf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
			ws.addCell(new Label(9, m, hszcf, this.getTextCellAlignRightFormat()));
			ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		}
		
		QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder2.eq("dxgc_id", gd02.getId());
		queryBuilder2.isNull("fy_id");
		queryBuilder2.eq("bgbh", "B1");
		ResultObject ro2 = queryService.search(queryBuilder2);
		Gd03_gcfysz gd032 = new Gd03_gcfysz();
		int i = 0;
		double qtfy = 0.00;
		while (ro2.next() || i < (17 - j)) {
			i++;
			gd032 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
			if (gd032 != null) {
				qtfy = NumberFormatUtil.addToDouble(gd032.getFyz().doubleValue(), qtfy);
				m++;
				ws.setRowView(m, 375);
				ws.addCell(new Label(0, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(2, m, gd032.getFymc(), this.getTextCellAlignLeftFormat()));
				ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
				String fyz = "";
				if (gd032.getFyz() != null && gd032.getFyz().doubleValue() != 0.0) {
					fyz = NumberFormatUtil.roundToString(gd032.getFyz());
				}
				ws.addCell(new Label(7, m, fyz, this.getTextCellAlignRightFormat()));
				ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(9, m, fyz, this.getTextCellAlignRightFormat()));
				ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
			} else {
				m++;
				ws.setRowView(m, 375);
				ws.addCell(new Label(0, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(2, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(4, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(5, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(7, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(9, m, "", this.getTextCellAlignCenterFormat()));
				ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
			}
		}
		String sum1 = "　";
		if (!NumberFormatUtil.roundToString(
				NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double) bg.get("回收设备费")), NumberFormatUtil.roundToDouble((Double) bg
						.get("回收主材费")))).equals("0.00")) {
			sum1 = NumberFormatUtil.roundToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToDouble((Double) bg.get("回收设备费")),
					NumberFormatUtil.roundToDouble((Double) bg.get("回收主材费"))));
		}
		String sum2 = "　";
		if (!NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double) bg.get("生产准备及开办费")), qtfy)).equals(
				"0.00")) {
			sum2 = NumberFormatUtil.roundToString(NumberFormatUtil.addToDouble(NumberFormatUtil.roundToDouble((Double) bg.get("生产准备及开办费")), qtfy));
		}
		String sum3 = "　";
		if (!NumberFormatUtil.addToString(
				NumberFormatUtil.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double) bg.get("生产准备及开办费")),
						NumberFormatUtil.roundToString((Double) bg.get("维护器具费"))), NumberFormatUtil.roundToString(NumberFormatUtil.addToString(
						NumberFormatUtil.roundToDouble((Double) bg.get("回收设备费")), NumberFormatUtil.roundToDouble((Double) bg.get("回收主材费"))))),
				String.valueOf(qtfy)).equals("0.00")) {
			sum3 = NumberFormatUtil.addToString(NumberFormatUtil
					.addToString(NumberFormatUtil.addToString(NumberFormatUtil.roundToString((Double) bg.get("生产准备及开办费")), NumberFormatUtil
							.roundToString((Double) bg.get("维护器具费"))), NumberFormatUtil.roundToString(NumberFormatUtil.addToString(NumberFormatUtil
							.roundToDouble((Double) bg.get("回收设备费")), NumberFormatUtil.roundToDouble((Double) bg.get("回收主材费"))))), String
					.valueOf(qtfy));
		}
		m++;
		ws.setRowView(m, 375);
		String zhhj="";
		if(!sum3.equals("　")){
			zhhj ="　　　　　合　　　　　计";
		}
		ws.addCell(new Label(0, m, "", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(1, m, "", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(2, m, zhhj, this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(3, m, "", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(4, m, sum1, this.getTextCellAlignRightFormat()));
		String whqjf1 = "";
		if (bg.get("维护器具费") != null && ((Double) bg.get("维护器具费")).doubleValue() != 0.0) {
			whqjf1 = NumberFormatUtil.roundToString((Double) bg.get("维护器具费"));
		}
		ws.addCell(new Label(5, m, whqjf1, this.getTextCellAlignRightFormat()));
		ws.addCell(new Label(6, m, "", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(7, m, sum2, this.getTextCellAlignRightFormat()));
		ws.addCell(new Label(8, m, "", this.getTextCellAlignCenterFormat()));
		ws.addCell(new Label(9, m, sum3, this.getTextCellAlignRightFormat()));
		ws.addCell(new Label(10, m, "", this.getTextCellAlignCenterFormat()));
		/**
		 * 处理审核信息行
		 */
		m++;
		ws.setRowView(m, 375);
		ws.mergeCells(0, m, 1, m);
		ws.mergeCells(2, m, 3, m);
		ws.mergeCells(4, m, 6, m);
		ws.mergeCells(7, m, 10, m);
		ws.addCell(new Label(0, m, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat()));
		ws.addCell(new Label(2, m, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat()));
		ws.addCell(new Label(4, m, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat()));
		ws.addCell(new Label(7, m, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this.getInfoCellAlignRightFormat()));

		/**
		 * 强制分页
		 */
		ws.addRowPageBreak(26);
	}

	/**
	 * 输出表4信息到指定WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程id
	 * @param bgbh
	 *            表格编号
	 * @param startPage
	 *            起始页
	 * @param bgbh
	 *            打印表格编号
	 * @throws Exception
	 */
	public void exportB4toExcel(WritableSheet ws, Integer dxgc_id, String bgbh, int startPage, String printBgbh) throws Exception {
		this.formatWritableSheet(ws);
		/**
		 * 写入工作薄
		 */
		Label label;
		/**
		 * 设置列宽，总宽度145
		 */
		ws.setColumnView(0, 5);
		ws.setColumnView(1, 45);
		ws.setColumnView(2, 26);
		ws.setColumnView(3, 9);
		ws.setColumnView(4, 9);
		ws.setColumnView(5, 9);
		ws.setColumnView(6, 13);
		ws.setColumnView(7, 13);
		ws.setColumnView(8, 23);

		/**
		 * 获取表4信息
		 */
		Gd07_b4 gd07;
		Gb03_bgxx gb03;
		Ga00_zclb ga00;
		Gd04_clfysz gd04;
		Gd02_dxgc gd02;
		B4_printVo vo;
		ResultObject ro, ro2;
		QueryBuilder queryBuilder;
		/**
		 * 获取单项工程信息
		 */
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}

		int B4_onePageRows = printService.getB4_onePageRows();

		queryBuilder = new HibernateQueryBuilder(Gb03_bgxx.class);
		queryBuilder.eq("bgbh", bgbh);
		ro = queryService.search(queryBuilder);
		ro.next();
		gb03 = (Gb03_bgxx) ro.get(Gb03_bgxx.class.getName());

		List list = new ArrayList();
		int listCount = 0;
		/**
		 * 材料行数累加
		 */
		int rowCount = 1;
		/**
		 * 总计值
		 */
		String zj = "0.00";
		queryBuilder = new HibernateQueryBuilder(Ga00_zclb.class);
		queryBuilder.addOrderBy(Order.asc("id"));
		ro2 = queryService.search(queryBuilder);
		while (ro2.next()) {
			/**
			 * 材料或设备顺序号
			 */

			ga00 = (Ga00_zclb) ro2.get(Ga00_zclb.class.getName());
			queryBuilder = new HibernateQueryBuilder(Gd07_b4.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			queryBuilder.eq("zclb", ga00.getZclb());
			queryBuilder.eq("bgbh", bgbh);
			queryBuilder.addOrderBy(Order.asc("xh"));
			ro = queryService.search(queryBuilder);
			if (ro.getLength() > 0) {
				/**
				 * 增加材料类别行
				 */
				vo = new B4_printVo();
				vo.setMc(ga00.getMc() + "类材料：");
				list.add(vo);
			}
			/**
			 * 单项小记累加变量
			 */
			String xj = "0";
			while (ro.next()) {
				/**
				 * 添加数据行
				 */
				gd07 = (Gd07_b4) ro.get(Gd07_b4.class.getName());
				vo = new B4_printVo();
				vo.setXh(String.valueOf(rowCount++));
				vo.setMc(gd07.getMc());
				vo.setGgcs(gd07.getXhgg());
				vo.setGg(gd07.getGg());
				vo.setDw(gd07.getDw());
				vo.setSl(NumberFormatUtil.roundToString(gd07.getSl()));
				vo.setDj(NumberFormatUtil.roundToString(gd07.getDj()));
				vo.setHj(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(gd07.getSl().toString(), gd07.getDj().toString())));
				vo.setBz(gd07.getBz());
				/**
				 * 处理调整系数
				 */
				if (gd07.getTzxs() != null && gd07.getTzxs().doubleValue() != 1) {
					vo.setMc(vo.getMc() + "（材料费调整　材料费×" + NumberFormatUtil.roundToString(gd07.getTzxs()) + "）");
					vo
							.setHj(NumberFormatUtil.roundToString(NumberFormatUtil.mulToString(vo.getHj(), NumberFormatUtil.roundToString(gd07
									.getTzxs()))));
				}
				xj = NumberFormatUtil.addToString(xj, vo.getHj());
				if (gd07.getSl() != null && gd07.getSl().doubleValue() != 0.0) {// 去掉费用为0的行
					list.add(vo);
				}
			}
			if (ro.getLength() > 0) {
				if (!ga00.getZclb().equals("YS")) {
					/**
					 * 增加小计行
					 */
					vo = new B4_printVo();
					vo.setMc("　　　　　　　　　　　　　小　　　　　计");
					vo.setHj(xj);
					list.add(vo);
					/**
					 * 增加费用
					 */
					queryBuilder = new HibernateQueryBuilder(Gd04_clfysz.class);
					queryBuilder.eq("bgbh", bgbh);
					queryBuilder.eq("dxgc_id", dxgc_id);
					queryBuilder.eq("zclb", ga00.getZclb());
					queryBuilder.addOrderBy(Order.asc("fy_id"));
					ro = queryService.search(queryBuilder);
					while (ro.next()) {
						gd04 = (Gd04_clfysz) ro.get(Gd04_clfysz.class.getName());
						vo = new B4_printVo();
						vo.setMc(gd04.getFymc()+"（类小计×"+gd04.getFlz()+"%）");
						vo.setHj(NumberFormatUtil.roundToString(gd04.getFyz()));
						xj = NumberFormatUtil.addToString(xj, vo.getHj());
						if (gd04.getFyz() != null && gd04.getFyz().doubleValue() != 0.0) {// 去掉费用为0的行
							list.add(vo);
						}
					}
				}
				/**
				 * 增加费用与合计行
				 */
				vo = new B4_printVo();
				vo.setMc("　　　　　　　　　　　　　合　　　　　计");
				vo.setHj(xj);
				list.add(vo);
				zj = NumberFormatUtil.addToString(zj, xj);
			}

		}
		if (list.size() > 0) {
			/**
			 * 增加总计行
			 */
			vo = new B4_printVo();
			vo.setMc("　　　　　　　　　　　　　总　　　　　计");
			vo.setHj(zj);
			list.add(vo);
		}
		int pages = printService.getB4pages(dxgc_id, bgbh).intValue();

		/**
		 * excel中每页行数
		 */
		int excelPageRowSize = B4_onePageRows + 6;
		
		int pageCount = 1;
		for (int i = 0; i < pages; i++) {
			/**
			 * 循环输出页
			 */

			/**
			 * 设置标题
			 */
			label = new Label(0, 0 + excelPageRowSize * i, gb03.getMc(), this.getTitleCellFormat());
			ws.addCell(label);
			ws.setRowView(0 + excelPageRowSize * i, 625);
			/**
			 * 合并第一行0-7单元格
			 */
			ws.mergeCells(0, 0 + excelPageRowSize * i, 8, 0 + excelPageRowSize * i);
			/**
			 * 设置副标题
			 */
			label = new Label(0, 1 + excelPageRowSize * i, "（" + gb03.getFbt() + "）", this.getInfoCellAlignCenterFormatForTitle());
			ws.addCell(label);
			ws.setRowView(1 + excelPageRowSize * i, 375);
			/**
			 * 合并第二行0-7单元格
			 */
			ws.mergeCells(0, 1 + excelPageRowSize * i, 7, 1 + excelPageRowSize * i);
			/**
			 * 合并工程信息行单元格
			 */
			ws.mergeCells(0, 2 + excelPageRowSize * i, 1, 2 + excelPageRowSize * i);
			ws.mergeCells(2, 2 + excelPageRowSize * i, 4, 2 + excelPageRowSize * i);
			ws.mergeCells(5, 2 + excelPageRowSize * i, 6, 2 + excelPageRowSize * i);
			/**
			 * 设置工程信息行
			 */
			label = new Label(0, 2 + excelPageRowSize * i, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(2, 2 + excelPageRowSize * i, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(5, 2 + excelPageRowSize * i, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(printBgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(8, 2 + excelPageRowSize * i, "第" + pageCount + "页 总第" +(startPage+(pageCount++))+ "页", this.getInfoCellAlignRightFormat());
			ws.addCell(label);
			/**
			 * 设置行高
			 */
			ws.setRowView(2 + excelPageRowSize * i, 375);

			/**
			 * 设置标题行
			 */
			label = new Label(0, 3 + excelPageRowSize * i, "序号", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(1, 3 + excelPageRowSize * i, "名称", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(2, 3 + excelPageRowSize * i, "规格", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(3, 3 + excelPageRowSize * i, "型号", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(4, 3 + excelPageRowSize * i, "单位", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(5, 3 + excelPageRowSize * i, "数量", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(6, 3 + excelPageRowSize * i, "单价（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(7, 3 + excelPageRowSize * i, "合计（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(8, 3 + excelPageRowSize * i, "备注", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(3 + excelPageRowSize * i, 375);

			label = new Label(0, 4 + excelPageRowSize * i, "I", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(1, 4 + excelPageRowSize * i, "II", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(2, 4 + excelPageRowSize * i, "III", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(3, 4 + excelPageRowSize * i, "IV", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(4, 4 + excelPageRowSize * i, "V", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(5, 4 + excelPageRowSize * i, "VI", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(6, 4 + excelPageRowSize * i, "VII", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(7, 4 + excelPageRowSize * i, "VIII", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(8, 4 + excelPageRowSize * i, "IX", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(4 + excelPageRowSize * i, 375);

			/**
			 * 循环输出数据行
			 */
			for (int j = 0; j < B4_onePageRows; j++) {
				if (listCount < list.size()) {
					vo = (B4_printVo) list.get(listCount++);
					label = new Label(0, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getXh()), this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getMc()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getGgcs()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getGg()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(4, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getDw()), this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(5, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getSl()), this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(6, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getDj()), this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(7, 5 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(vo.getHj(), ""), this
							.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(8, 5 + j + excelPageRowSize * i, StringFormatUtil.format(vo.getBz()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					//ws.setRowView(5 + j + excelPageRowSize * i, 375);
				} else {
					label = new Label(0, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(4, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(5, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(6, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(7, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(8, 5 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					//ws.setRowView(5 + j + excelPageRowSize * i, 375);
				}
			}

			/**
			 * 输出审核信息行
			 */
			label = new Label(0, B4_onePageRows + excelPageRowSize * i + 5, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(2, B4_onePageRows + excelPageRowSize * i + 5, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(4, B4_onePageRows + excelPageRowSize * i + 5, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(6, B4_onePageRows + excelPageRowSize * i + 5, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this
					.getInfoCellAlignRightFormat());
			ws.addCell(label);
			/**
			 * 设置行高
			 */
			ws.setRowView(B4_onePageRows + excelPageRowSize * i + 5, 375);
			/**
			 * 合并审核信息行单元格
			 */
			ws.mergeCells(0, B4_onePageRows + excelPageRowSize * i + 5, 1, B4_onePageRows + excelPageRowSize * i + 4);
			ws.mergeCells(2, B4_onePageRows + excelPageRowSize * i + 5, 3, B4_onePageRows + excelPageRowSize * i + 4);
			ws.mergeCells(4, B4_onePageRows + excelPageRowSize * i + 5, 5, B4_onePageRows + excelPageRowSize * i + 4);
			ws.mergeCells(6, B4_onePageRows + excelPageRowSize * i + 5, 8, B4_onePageRows + excelPageRowSize * i + 4);

			/**
			 * 强制分页
			 */
			ws.addRowPageBreak(B4_onePageRows + excelPageRowSize * i + 6);
		}
	}

	/**
	 * 输出表5信息到指定WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程id
	 * @param startPage
	 *            起始页
	 * @param bgbh
	 *            打印表格编号
	 * @throws Exception
	 */
	public void exportB5toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception {
		this.formatWritableSheet(ws);
		/**
		 * 写入工作薄
		 */
		Label label;
		/**
		 * 设置列宽，总宽度145
		 */
		ws.setColumnView(0, 5);
		ws.setColumnView(1, 32);
		ws.setColumnView(2, 54);
		ws.setColumnView(3, 16);
		ws.setColumnView(4, 16);
		ws.setColumnView(5, 16);

		/**
		 * 获取表5信息
		 */
		Gd02_dxgc gd02;
		Gd03_gcfysz gd03;
		ResultObject ro;
		QueryBuilder queryBuilder;
		int B5j_onePageRows = printService.getB5j_onePageRows();
		gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null) {
			throw new RuntimeException("单项工程未找到!");
		}
		String jsjd = "";
		if (gd02.getJsjd().intValue() == 1) {
			jsjd = "概算";
		} else if (gd02.getJsjd().intValue() == 2) {
			jsjd = "预算";
		} else if (gd02.getJsjd().intValue() == 3) {
			jsjd = "结算";
		} else if (gd02.getJsjd().intValue() == 4) {
			jsjd = "决算";
		}

		queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder.eq("dxgc_id", gd02.getId());
		queryBuilder.eq("bgbh", "B5");
		queryBuilder.addOrderBy(Order.asc("fy_id"));
		ro = queryService.search(queryBuilder);
		int pages = printService.getB5jpages(gd02.getId()).intValue();
		boolean setHj = true;
		boolean setSczbf = true;
		int rowCount = 0;
		int excelPageRowSize = B5j_onePageRows + 5;
		
		int pageCount=1;
		for (int i = 0; i < pages; i++) {
			/**
			 * 设置标题
			 */
			label = new Label(0, 0 + excelPageRowSize * i, "工程建设其他费用" + jsjd + "表（表五）", this.getTitleCellFormat());
			ws.addCell(label);
			ws.setRowView(0 + excelPageRowSize * i, 1000);
			/**
			 * 合并第一行0-5单元格
			 */
			ws.mergeCells(0, 0 + excelPageRowSize * i, 5, 0 + excelPageRowSize * i);
			/**
			 * 合并工程信息行单元格
			 */
			ws.mergeCells(0, 1 + excelPageRowSize * i, 1, 1 + excelPageRowSize * i);
			ws.mergeCells(3, 1 + excelPageRowSize * i, 4, 1 + excelPageRowSize * i);
			/**
			 * 设置工程信息行
			 */
			label = new Label(0, 1 + excelPageRowSize * i, "工程名称：" + StringFormatUtil.format(gd02.getGcmc()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(2, 1 + excelPageRowSize * i, "建设单位名称：" + StringFormatUtil.format(gd02.getJsdw()), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(3, 1 + excelPageRowSize * i, "表格编号：" + StringFormatUtil.format(gd02.getBgbh()) + "-" + StringFormatUtil.format(bgbh), this.getInfoCellAlignLeftFormat());
			ws.addCell(label);
			label = new Label(5, 1 + excelPageRowSize * i, "第" + pageCount + "页 总第" + (startPage+(pageCount++)) + "页", this.getInfoCellAlignRightFormat());
			ws.addCell(label);
			/**
			 * 设置行高
			 */
			ws.setRowView(1 + excelPageRowSize * i, 375);

			/**
			 * 设置标题行
			 */
			label = new Label(0, 2 + excelPageRowSize * i, "序号", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(1, 2 + excelPageRowSize * i, "费用名称", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(2, 2 + excelPageRowSize * i, "计算依据及方法", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(3, 2 + excelPageRowSize * i, "金额（元）", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(4, 2 + excelPageRowSize * i, "备注", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(2 + excelPageRowSize * i, 375);
			/**
			 * 合并备注单元格
			 */
			ws.mergeCells(4, 2 + excelPageRowSize * i, 5, 2 + excelPageRowSize * i);

			label = new Label(0, 3 + excelPageRowSize * i, "I", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(1, 3 + excelPageRowSize * i, "II", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(2, 3 + excelPageRowSize * i, "III", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(3, 3 + excelPageRowSize * i, "IV", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			label = new Label(4, 3 + excelPageRowSize * i, "V", this.getTextCellAlignCenterFormat());
			ws.addCell(label);
			ws.setRowView(3 + excelPageRowSize * i, 375);
			/**
			 * 合并备注单元格
			 */
			ws.mergeCells(4, 3 + excelPageRowSize * i, 5, 3 + excelPageRowSize * i);

			/**
			 * 输出数据
			 */
			for (int j = 0; j < B5j_onePageRows; j++) {
				if (ro.next()) {
					gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
					label = new Label(0, 4 + j + excelPageRowSize * i, (++rowCount) + "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 4 + j + excelPageRowSize * i, gd03.getFymc(), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 4 + j + excelPageRowSize * i, StringFormatUtil.format(gd03.getGsbds()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 4 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(gd03.getFyz()), this
							.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(4, 4 + j + excelPageRowSize * i, StringFormatUtil.format(gd03.getBz()), this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					ws.setRowView(4 + j + excelPageRowSize * i, 375);
					/**
					 * 合并备注单元格
					 */
					ws.mergeCells(4, 4 + j + excelPageRowSize * i, 5, 4 + j + excelPageRowSize * i);
				} else if (setHj) {
					setHj = false;
					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("dxgc_id", gd02.getId());
					queryBuilder.eq("fymc", "表5合计其他费");
					ResultObject ro2 = queryService.search(queryBuilder);
					String Hj = "0";
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						Hj = NumberFormatUtil.roundToString(gd03.getFyz());
					}
					label = new Label(0, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 4 + j + excelPageRowSize * i, "总　计", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 4 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(Hj), this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(4, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					ws.setRowView(4 + j + excelPageRowSize * i, 375);
					/**
					 * 合并备注单元格
					 */
					ws.mergeCells(4, 4 + j + excelPageRowSize * i, 5, 4 + j + excelPageRowSize * i);
				} else if (setSczbf) {
					setSczbf = false;
					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("dxgc_id", gd02.getId());
					queryBuilder.eq("fymc", "生产准备及开办费");
					ResultObject ro2 = queryService.search(queryBuilder);
					String Hj = "0";
					if (ro2.next()) {
						gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						Hj = NumberFormatUtil.roundToString(gd03.getFyz());
					}
					label = new Label(0, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 4 + j + excelPageRowSize * i, "生产准备及开办费（运营费）", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 4 + j + excelPageRowSize * i, NumberFormatUtil.roundToString(Hj), this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(4, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					ws.setRowView(4 + j + excelPageRowSize * i, 375);
					/**
					 * 合并备注单元格
					 */
					ws.mergeCells(4, 4 + j + excelPageRowSize * i, 5, 4 + j + excelPageRowSize * i);
				} else {
					label = new Label(0, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignCenterFormat());
					ws.addCell(label);
					label = new Label(1, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(2, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					label = new Label(3, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignRightFormat());
					ws.addCell(label);
					label = new Label(4, 4 + j + excelPageRowSize * i, "", this.getTextCellAlignLeftFormat());
					ws.addCell(label);
					ws.setRowView(4 + j + excelPageRowSize * i, 375);
					/**
					 * 合并备注单元格
					 */
					ws.mergeCells(4, 4 + j + excelPageRowSize * i, 5, 4 + j + excelPageRowSize * i);
				}
				/**
				 * 输出审核信息行
				 */
				label = new Label(0, B5j_onePageRows + excelPageRowSize * i + 4, "设计负责人：" + StringFormatUtil.format(gd02.getSjfzr()), this.getInfoCellAlignLeftFormat());
				ws.addCell(label);
				label = new Label(2, B5j_onePageRows + excelPageRowSize * i + 4, "审核：" + StringFormatUtil.format(gd02.getShr()), this.getInfoCellAlignLeftFormat());
				ws.addCell(label);
				label = new Label(3, B5j_onePageRows + excelPageRowSize * i + 4, "编制：" + StringFormatUtil.format(gd02.getBzr()), this.getInfoCellAlignLeftFormat());
				ws.addCell(label);
				label = new Label(4, B5j_onePageRows + excelPageRowSize * i + 4, "编制日期：" + DateFormatUtil.Format(gd02.getBzrq(), "yyyy年MM月dd日"), this
						.getInfoCellAlignRightFormat());
				ws.addCell(label);
				/**
				 * 设置行高
				 */
				ws.setRowView(B5j_onePageRows + excelPageRowSize * i + 4, 375);
				/**
				 * 合并审核信息行单元格
				 */
				ws.mergeCells(0, B5j_onePageRows + excelPageRowSize * i + 4, 1, B5j_onePageRows + excelPageRowSize * i + 4);
				ws.mergeCells(4, B5j_onePageRows + excelPageRowSize * i + 4, 5, B5j_onePageRows + excelPageRowSize * i + 4);

				/**
				 * 强制分页
				 */
				ws.addRowPageBreak(B5j_onePageRows + excelPageRowSize * i + 5);
			}
		}
	}

	/**
	 * 设定标题格式wcf_Title 黑体，15号，不加粗，无边框
	 */
	private WritableCellFormat getTitleCellFormat() throws WriteException {
		/**
		 * WritableFont参数说明：字体，字号，是否加粗，是否斜体
		 */
		WritableFont wf = new WritableFont(WritableFont.createFont("黑体"), 15, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Title = new WritableCellFormat(wf);
		wcf_Title.setAlignment(Alignment.CENTRE);
		wcf_Title.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Title.setWrap(true); // 是否换行
		return wcf_Title;
	}

	/**
	 * 设定文本域格式wcf_Text，有边框，居中对齐
	 */
	private WritableCellFormat getTextCellAlignCenterFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Text = new WritableCellFormat(wf);
		wcf_Text.setAlignment(Alignment.CENTRE);
		wcf_Text.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Text.setBorder(Border.ALL, BorderLineStyle.THIN);
		wcf_Text.setWrap(true); // 是否换行
		return wcf_Text;
	}

	/**
	 * 设定文本域格式wcf_Text，有边框，居中对齐
	 */
	private WritableCellFormat getTextCellAlignLeftFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Text = new WritableCellFormat(wf);
		wcf_Text.setAlignment(Alignment.LEFT);
		wcf_Text.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Text.setBorder(Border.ALL, BorderLineStyle.THIN);
		wcf_Text.setWrap(true); // 是否换行
		return wcf_Text;
	}

	/**
	 * 设定文本域格式wcf_Number，有边框，右对齐
	 */
	private WritableCellFormat getTextCellAlignRightFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Text = new WritableCellFormat(wf);
		wcf_Text.setAlignment(Alignment.RIGHT);
		wcf_Text.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Text.setBorder(Border.ALL, BorderLineStyle.THIN);
		wcf_Text.setWrap(true); // 是否换行
		return wcf_Text;
	}

	/**
	 * 设定文本域格式wcf_Info，无边框，左对齐
	 */
	private WritableCellFormat getInfoCellAlignLeftFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Info = new WritableCellFormat(wf);
		wcf_Info.setAlignment(Alignment.LEFT);
		wcf_Info.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Info.setWrap(true); // 是否换行
		return wcf_Info;
	}

	/**
	 * 设定文本域格式wcf_Info，无边框，右对齐
	 */
	private WritableCellFormat getInfoCellAlignRightFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Info = new WritableCellFormat(wf);
		wcf_Info.setAlignment(Alignment.RIGHT);
		wcf_Info.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Info.setWrap(true); // 是否换行
		return wcf_Info;
	}

	/**
	 * 设定文本域格式wcf_Info，无边框，居中对齐
	 */
	private WritableCellFormat getInfoCellAlignCenterFormat() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 9, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Info = new WritableCellFormat(wf);
		wcf_Info.setAlignment(Alignment.CENTRE);
		wcf_Info.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Info.setWrap(true); // 是否换行
		return wcf_Info;
	}
	
	/**
	 * 设定文本域格式wcf_Info，无边框，居中对齐,11号字体
	 */
	private WritableCellFormat getInfoCellAlignCenterFormatForTitle() throws WriteException {
		WritableFont wf = new WritableFont(WritableFont.createFont("宋体"), 11, WritableFont.NO_BOLD, false);
		WritableCellFormat wcf_Info = new WritableCellFormat(wf);
		wcf_Info.setAlignment(Alignment.CENTRE);
		wcf_Info.setVerticalAlignment(VerticalAlignment.CENTRE);
		wcf_Info.setWrap(true); // 是否换行
		return wcf_Info;
	}

	/**
	 * 设置WritableSheet页面样式
	 * 
	 * @param ws
	 *            需要设置样式的WritableSheet
	 */
	private void formatWritableSheet(WritableSheet ws) {
		/**
		 * 设置横向打印
		 */
		ws.getSettings().setOrientation(PageOrientation.LANDSCAPE);
		/**
		 * 设置纸张大小
		 */
		ws.getSettings().setPaperSize(PaperSize.A4);
		/**
		 * 设置缩放比例
		 */
		ws.getSettings().setScaleFactor(100);
		/**
		 * 设置页边距
		 */
		ws.getSettings().setTopMargin(1.25);
		ws.getSettings().setBottomMargin(0.25);
		ws.getSettings().setLeftMargin(0.5);
		ws.getSettings().setRightMargin(0.5);
		ws.getSettings().setHeaderMargin(0.1);
		ws.getSettings().setFooterMargin(0.1);
	}

	public BakVo expBak(String pID, String[] spIDs) throws Exception {
		BakVo prjBag = new BakVo();

		ResultObject rs = queryService.search("select gd01 from Gd01_gcxm gd01 where id=" + pID);
		rs.next();
		Gd01_gcxm gd01 = (Gd01_gcxm) rs.get("gd01");
		prjBag.setBasicInfo(gd01);

		for (int i = 0; i < spIDs.length; i++) {
			BakVo sprjBag = new BakVo();
			rs = queryService.search("select gd02 from Gd02_dxgc gd02 where id=" + spIDs[i]);
			rs.next();
			Gd02_dxgc gd02 = (Gd02_dxgc) rs.get("gd02");
			sprjBag.setBasicInfo(gd02);

			rs = queryService.search("select gd03 from Gd03_gcfysz gd03 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd03_gcfysz gd03 = (Gd03_gcfysz) rs.get("gd03");
				sprjBag.getList().add(gd03);
			}
			rs = queryService.search("select gd04 from Gd04_clfysz gd04 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd04_clfysz gd04 = (Gd04_clfysz) rs.get("gd04");
				sprjBag.getList().add(gd04);
			}
			rs = queryService.search("select gd05 from Gd05_b3j gd05 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd05_b3j gd05 = (Gd05_b3j) rs.get("gd05");
				sprjBag.getList().add(gd05);
			}
			rs = queryService.search("select gd06 from Gd06_b3y gd06 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd06_b3y gd06 = (Gd06_b3y) rs.get("gd06");
				sprjBag.getList().add(gd06);
			}
			rs = queryService.search("select gd07 from Gd07_b4 gd07 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd07_b4 gd07 = (Gd07_b4) rs.get("gd07");
				sprjBag.getList().add(gd07);
			}
			rs = queryService.search("select gd09 from Gd09_degl gd09 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd09_degl gd09 = (Gd09_degl) rs.get("gd09");
				sprjBag.getList().add(gd09);
			}
			rs = queryService.search("select gd10 from Gd10_b3fl gd10 where gcxm_id=" + pID + " and dxgc_id=" + spIDs[i]);
			while (rs.next()) {
				Gd10_b3fl gd10 = (Gd10_b3fl) rs.get("gd10");
				sprjBag.getList().add(gd10);
			}
			prjBag.getList().add(sprjBag);
		}

		return prjBag;
	}

	public boolean impValid(String pSign, String[] spSigns, ArrayList data, String cjr_id) throws Exception {
		boolean exist = false;
		for (int i = 0; i < data.size(); i++) {
			BakVo bak = (BakVo) data.get(i);
			Gd01_gcxm gd01 = (Gd01_gcxm) bak.getBasicInfo();
			if (!gd01.getId().toString().equals(pSign))
				continue;
			if (gd01.getCjr_id().toString().equals(cjr_id)) {// 导入自己的工程
				Integer pID = null;
				ResultObject rs = queryService.search("select id from Gd01_gcxm where xmmc='" + gd01.getXmmc() + "' and cjr_id=" + cjr_id);
				if (rs.next()) {// 工程存在
					pID = (Integer) rs.get("id");
					for (int j = 0; j < spSigns.length; j++) {
						ArrayList spList = bak.getList();
						for (int k = 0; k < spList.size(); k++) {
							BakVo spBak = (BakVo) spList.get(k);
							Gd02_dxgc gd02 = (Gd02_dxgc) spBak.getBasicInfo();
							if (!gd02.getId().toString().equals(spSigns[j]))
								continue;
							ResultObject rs2 = queryService.search("select id from Gd02_dxgc where gcmc='" + gd02.getGcmc() + "' and gcxm_id=" + pID);
							if (rs2.next()) {// 单项工程存在
								exist = true;
							}
							break;
						}
						if (exist)
							break;
					}
				}
			}
			break;
		}
		return exist;
	}

	public void impBak(String pSign, String[] spSigns, ArrayList data, String gcfl, String operate, String cjr_id, String cjr) throws Exception {
		for (int i = 0; i < data.size(); i++) {
			BakVo bak = (BakVo) data.get(i);
			Gd01_gcxm gd01 = (Gd01_gcxm) bak.getBasicInfo();
			if (!gd01.getId().toString().equals(pSign))
				continue;
			Integer pID = null;
			if (gd01.getCjr_id().toString().equals(cjr_id)) {// 导入自己的工程
				ResultObject rs = queryService.search("select id from Gd01_gcxm where xmmc='" + gd01.getXmmc() + "' and cjr_id=" + cjr_id);
				if (rs.next()) {// 工程已存在
					pID = (Integer) rs.get("id");
					if (operate.equals("1")) {// 如果需要覆盖
						gd01.setId(pID);
						saveService.save(gd01);
					}
					for (int j = 0; j < spSigns.length; j++) {
						ArrayList spList = bak.getList();
						for (int k = 0; k < spList.size(); k++) {
							BakVo spBak = (BakVo) spList.get(k);
							Gd02_dxgc gd02 = (Gd02_dxgc) spBak.getBasicInfo();
							if (!gd02.getId().toString().equals(spSigns[j]))
								continue;
							Integer spID = null;
							ResultObject rs2 = queryService.search("select id from Gd02_dxgc where gcmc='" + gd02.getGcmc() + "' and gcxm_id=" + pID);
							if (rs2.next()) {// 单项工程已存在
								spID = (Integer) rs2.get("id");
								if (operate.equals("1")) {// 如果需要覆盖
									gd02.setId(spID);
									gd02.setGcxm_id(pID);
									saveService.save(gd02);
									saveService.updateByHSql("delete from Gd03_gcfysz where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd04_clfysz where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd05_b3j where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd06_b3y where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd07_b4 where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd09_degl where gcxm_id=" + pID + " and dxgc_id=" + spID);
									saveService.updateByHSql("delete from Gd10_b3fl where gcxm_id=" + pID + " and dxgc_id=" + spID);
									ArrayList gdList = spBak.getList();
									for (int l = 0; l < gdList.size(); l++) {
										if (gdList.get(l) instanceof Gd03_gcfysz) {
											Gd03_gcfysz gd03 = (Gd03_gcfysz) gdList.get(l);
											gd03.setId(null);
											gd03.setGcxm_id(pID);
											gd03.setDxgc_id(spID);
											saveService.save(gd03);
										} else if (gdList.get(l) instanceof Gd04_clfysz) {
											Gd04_clfysz gd04 = (Gd04_clfysz) gdList.get(l);
											gd04.setId(null);
											gd04.setGcxm_id(pID);
											gd04.setDxgc_id(spID);
											saveService.save(gd04);
										} else if (gdList.get(l) instanceof Gd05_b3j) {
											Gd05_b3j gd05 = (Gd05_b3j) gdList.get(l);
											gd05.setId(null);
											gd05.setGcxm_id(pID);
											gd05.setDxgc_id(spID);
											saveService.save(gd05);
										} else if (gdList.get(l) instanceof Gd06_b3y) {
											Gd06_b3y gd06 = (Gd06_b3y) gdList.get(l);
											gd06.setId(null);
											gd06.setGcxm_id(pID);
											gd06.setDxgc_id(spID);
											saveService.save(gd06);
										} else if (gdList.get(l) instanceof Gd07_b4) {
											Gd07_b4 gd07 = (Gd07_b4) gdList.get(l);
											gd07.setId(null);
											gd07.setGcxm_id(pID);
											gd07.setDxgc_id(spID);
											saveService.save(gd07);
										} else if (gdList.get(l) instanceof Gd09_degl) {
											Gd09_degl gd09 = (Gd09_degl) gdList.get(l);
											gd09.setId(null);
											gd09.setGcxm_id(pID);
											gd09.setDxgc_id(spID);
											saveService.save(gd09);
										} else if (gdList.get(l) instanceof Gd10_b3fl) {
											Gd10_b3fl gd10 = (Gd10_b3fl) gdList.get(l);
											gd10.setId(null);
											gd10.setGcxm_id(pID);
											gd10.setDxgc_id(spID);
											saveService.save(gd10);
										}
									}
								}
							} else {// 单项工程不存在
								gd02.setId(null);
								gd02.setGcxm_id(pID);
								gd02.setCjsj(new java.util.Date());
								saveService.save(gd02);
								spID = gd02.getId();
								ArrayList gdList = spBak.getList();
								for (int l = 0; l < gdList.size(); l++) {
									if (gdList.get(l) instanceof Gd03_gcfysz) {
										Gd03_gcfysz gd03 = (Gd03_gcfysz) gdList.get(l);
										gd03.setId(null);
										gd03.setGcxm_id(pID);
										gd03.setDxgc_id(spID);
										saveService.save(gd03);
									} else if (gdList.get(l) instanceof Gd04_clfysz) {
										Gd04_clfysz gd04 = (Gd04_clfysz) gdList.get(l);
										gd04.setId(null);
										gd04.setGcxm_id(pID);
										gd04.setDxgc_id(spID);
										saveService.save(gd04);
									} else if (gdList.get(l) instanceof Gd05_b3j) {
										Gd05_b3j gd05 = (Gd05_b3j) gdList.get(l);
										gd05.setId(null);
										gd05.setGcxm_id(pID);
										gd05.setDxgc_id(spID);
										saveService.save(gd05);
									} else if (gdList.get(l) instanceof Gd06_b3y) {
										Gd06_b3y gd06 = (Gd06_b3y) gdList.get(l);
										gd06.setId(null);
										gd06.setGcxm_id(pID);
										gd06.setDxgc_id(spID);
										saveService.save(gd06);
									} else if (gdList.get(l) instanceof Gd07_b4) {
										Gd07_b4 gd07 = (Gd07_b4) gdList.get(l);
										gd07.setId(null);
										gd07.setGcxm_id(pID);
										gd07.setDxgc_id(spID);
										saveService.save(gd07);
									} else if (gdList.get(l) instanceof Gd09_degl) {
										Gd09_degl gd09 = (Gd09_degl) gdList.get(l);
										gd09.setId(null);
										gd09.setGcxm_id(pID);
										gd09.setDxgc_id(spID);
										saveService.save(gd09);
									} else if (gdList.get(l) instanceof Gd10_b3fl) {
										Gd10_b3fl gd10 = (Gd10_b3fl) gdList.get(l);
										gd10.setId(null);
										gd10.setGcxm_id(pID);
										gd10.setDxgc_id(spID);
										saveService.save(gd10);
									}
								}
							}
							break;
						}
					}
				} else {// 工程不存在
					gd01.setId(null);
					gd01.setCjrq(new java.util.Date());
					gd01.setGcfl_id(new Integer(gcfl));
					saveService.save(gd01);
					pID = gd01.getId();
					for (int j = 0; j < spSigns.length; j++) {
						ArrayList spList = bak.getList();
						for (int k = 0; k < spList.size(); k++) {
							BakVo spBak = (BakVo) spList.get(k);
							Gd02_dxgc gd02 = (Gd02_dxgc) spBak.getBasicInfo();
							if (!gd02.getId().toString().equals(spSigns[j]))
								continue;
							Integer spID = null;
							gd02.setId(null);
							gd02.setGcxm_id(pID);
							gd02.setCjsj(new java.util.Date());
							saveService.save(gd02);
							spID = gd02.getId();
							ArrayList gdList = spBak.getList();
							for (int l = 0; l < gdList.size(); l++) {
								if (gdList.get(l) instanceof Gd03_gcfysz) {
									Gd03_gcfysz gd03 = (Gd03_gcfysz) gdList.get(l);
									gd03.setId(null);
									gd03.setGcxm_id(pID);
									gd03.setDxgc_id(spID);
									saveService.save(gd03);
								} else if (gdList.get(l) instanceof Gd04_clfysz) {
									Gd04_clfysz gd04 = (Gd04_clfysz) gdList.get(l);
									gd04.setId(null);
									gd04.setGcxm_id(pID);
									gd04.setDxgc_id(spID);
									saveService.save(gd04);
								} else if (gdList.get(l) instanceof Gd05_b3j) {
									Gd05_b3j gd05 = (Gd05_b3j) gdList.get(l);
									gd05.setId(null);
									gd05.setGcxm_id(pID);
									gd05.setDxgc_id(spID);
									saveService.save(gd05);
								} else if (gdList.get(l) instanceof Gd06_b3y) {
									Gd06_b3y gd06 = (Gd06_b3y) gdList.get(l);
									gd06.setId(null);
									gd06.setGcxm_id(pID);
									gd06.setDxgc_id(spID);
									saveService.save(gd06);
								} else if (gdList.get(l) instanceof Gd07_b4) {
									Gd07_b4 gd07 = (Gd07_b4) gdList.get(l);
									gd07.setId(null);
									gd07.setGcxm_id(pID);
									gd07.setDxgc_id(spID);
									saveService.save(gd07);
								} else if (gdList.get(l) instanceof Gd09_degl) {
									Gd09_degl gd09 = (Gd09_degl) gdList.get(l);
									gd09.setId(null);
									gd09.setGcxm_id(pID);
									gd09.setDxgc_id(spID);
									saveService.save(gd09);
								} else if (gdList.get(l) instanceof Gd10_b3fl) {
									Gd10_b3fl gd10 = (Gd10_b3fl) gdList.get(l);
									gd10.setId(null);
									gd10.setGcxm_id(pID);
									gd10.setDxgc_id(spID);
									saveService.save(gd10);
								}
							}
							break;
						}
					}
				}
			} else {// 导入别人的工程
				gd01.setId(null);
				gd01.setCjr(cjr);
				gd01.setCjr_id(new Integer(cjr_id));
				gd01.setCjrq(new java.util.Date());
				gd01.setGcfl_id(new Integer(gcfl));
				saveService.save(gd01);
				pID = gd01.getId();
				for (int j = 0; j < spSigns.length; j++) {
					ArrayList spList = bak.getList();
					for (int k = 0; k < spList.size(); k++) {
						BakVo spBak = (BakVo) spList.get(k);
						Gd02_dxgc gd02 = (Gd02_dxgc) spBak.getBasicInfo();
						if (!gd02.getId().toString().equals(spSigns[j]))
							continue;
						Integer spID = null;
						gd02.setId(null);
						gd02.setGcxm_id(pID);
						gd02.setCjr(cjr);
						gd02.setCjr_id(new Integer(cjr_id));
						gd02.setCjsj(new java.util.Date());
						saveService.save(gd02);
						spID = gd02.getId();
						ArrayList gdList = spBak.getList();
						for (int l = 0; l < gdList.size(); l++) {
							if (gdList.get(l) instanceof Gd03_gcfysz) {
								Gd03_gcfysz gd03 = (Gd03_gcfysz) gdList.get(l);
								gd03.setId(null);
								gd03.setGcxm_id(pID);
								gd03.setDxgc_id(spID);
								saveService.save(gd03);
							} else if (gdList.get(l) instanceof Gd04_clfysz) {
								Gd04_clfysz gd04 = (Gd04_clfysz) gdList.get(l);
								gd04.setId(null);
								gd04.setGcxm_id(pID);
								gd04.setDxgc_id(spID);
								saveService.save(gd04);
							} else if (gdList.get(l) instanceof Gd05_b3j) {
								Gd05_b3j gd05 = (Gd05_b3j) gdList.get(l);
								gd05.setId(null);
								gd05.setGcxm_id(pID);
								gd05.setDxgc_id(spID);
								saveService.save(gd05);
							} else if (gdList.get(l) instanceof Gd06_b3y) {
								Gd06_b3y gd06 = (Gd06_b3y) gdList.get(l);
								gd06.setId(null);
								gd06.setGcxm_id(pID);
								gd06.setDxgc_id(spID);
								saveService.save(gd06);
							} else if (gdList.get(l) instanceof Gd07_b4) {
								Gd07_b4 gd07 = (Gd07_b4) gdList.get(l);
								gd07.setId(null);
								gd07.setGcxm_id(pID);
								gd07.setDxgc_id(spID);
								saveService.save(gd07);
							} else if (gdList.get(l) instanceof Gd09_degl) {
								Gd09_degl gd09 = (Gd09_degl) gdList.get(l);
								gd09.setId(null);
								gd09.setGcxm_id(pID);
								gd09.setDxgc_id(spID);
								saveService.save(gd09);
							} else if (gdList.get(l) instanceof Gd10_b3fl) {
								Gd10_b3fl gd10 = (Gd10_b3fl) gdList.get(l);
								gd10.setId(null);
								gd10.setGcxm_id(pID);
								gd10.setDxgc_id(spID);
								saveService.save(gd10);
							}
						}
						break;
					}
				}
			}
			break;
		}
	}
}
