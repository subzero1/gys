package com.netsky.service;

/**
 * 同步表1-表5设置信息service接口
 * 
 * @author Chiang 2009-10-19
 */
public interface SynchronizeInfomation {

	/**
	 * 同步表1设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB1(Integer dxgc_id) throws Exception;

	/**
	 * 同步表2设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB2(Integer dxgc_id) throws Exception;

	/**
	 * 同步表3甲设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB3j(Integer dxgc_id) throws Exception;

	/**
	 * 同步表3乙丙设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB3yb(Integer dxgc_id) throws Exception;

	/**
	 * 同步表4设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @param bgbh
	 *            表格编号
	 * @throws Exception
	 */
	public void SynchronizeB4(Integer dxgc_id, String bgbh) throws Exception;

	/**
	 * 同步表5设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB5(Integer dxgc_id) throws Exception;
}
