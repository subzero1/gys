package com.netsky.service;

import java.util.ArrayList;

import com.netsky.viewObject.BakVo;

import jxl.write.WritableSheet;

/**
 * 数据导出服务
 * 
 * @author Chiang 2009-06-22
 */
public interface ExportService {

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
	 * @param bgbh
	 *            打印表格编号
	 * @throws Exception
	 */
	public void exportHzbtoExcel(WritableSheet ws, Integer gcxm_id, String dxgc_ids, int startPage, String bgbh) throws Exception;

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
	public void exportB2toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	public BakVo expBak(String pID, String[] spIDs) throws Exception;

	public void impBak(String pSign, String[] spSigns, ArrayList data, String gcfl, String operate, String cjr_id, String cjr) throws Exception;

	public boolean impValid(String pSign, String[] spSigns, ArrayList data, String cjr_id) throws Exception;

	/**
	 * 输出表3甲信息到指WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程Id
	 * @throws Exception
	 */

	public void exportB3JtoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * 输出表3乙信息到指定的WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程ID
	 * @throws Exception
	 */
	public void exportB3ytoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * 输出表3丙信息Excel
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB3btoExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

	/**
	 * 表1Excel输出
	 * 
	 * @param ws
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void exportB1toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

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
	 * @param printBgbh
	 *            打印表格编号
	 * @throws Exception
	 */
	public void exportB4toExcel(WritableSheet ws, Integer dxgc_id, String bgbh, int startPage, String printBgbh) throws Exception;

	/**
	 * 输出表5信息到指定WritableSheet
	 * 
	 * @param ws
	 *            可写Sheet
	 * @param dxgc_id
	 *            单项工程id
	 * @param startPage
	 *            起始页
	 * @param totalPage
	 *            总页数
	 * @throws Exception
	 */
	public void exportB5toExcel(WritableSheet ws, Integer dxgc_id, int startPage, String bgbh) throws Exception;

}
