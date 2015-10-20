package com.netsky.service;

import javax.servlet.http.HttpServletRequest;

import com.netsky.dataObject.Gd02_dxgc;

/**
 * @author Chiang 2009-05-13
 * 
 * 费率费用相关服务
 */
public interface ExpenseService {

	/**
	 * 获取费率表1,2,5值
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @param fy_id
	 *            ga05费用id
	 * @throws Exception
	 * @return String flz 返回费用相关费率
	 */
	public String getFlz(Integer dxgc_id, Integer fy_id) throws Exception;

	/**
	 * 更新数据后续操作,更新gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void updateGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception;

	/**
	 * 插入数据后续操作,将ga14数据写入gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception;
	
	/**
	 * 插入数据后续操作,将ga14数据写入gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10Hessian(Gd02_dxgc gd02) throws Exception;

	/**
	 * 插入综合信息后的处理,将ga05中费率数据写入gd03
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd03(Gd02_dxgc gd02) throws Exception;

	/**
	 * 重新获取单表费率
	 * 
	 * @param gd02
	 * @param bgbh
	 *            表格编号
	 * @throws Exception
	 */
	public void reBuildFy(Gd02_dxgc gd02, String bgbh, HttpServletRequest request) throws Exception;

	/**
	 * 新建综合信息时写入gd04信息。
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd04(Gd02_dxgc gd02) throws Exception;

	/**
	 * 重取专业相关费率
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void rebuildZyfl(Gd02_dxgc gd02) throws Exception;

	/**
	 * 删除表格时处理相关费用,从公式中删除此费用,增加表格信息时重新给公式添加费用,gb03中存储需要此处理的费用
	 * 
	 * @param gd02
	 * @param bgxx_id gb03_id 需要操作的表格
	 * @param oper_flag "delete" or "add" 
	 * @throws Exception
	 */
	public void updateJsgc(Gd02_dxgc gd02, Integer bgxx_id, String oper_flag) throws Exception;

}
