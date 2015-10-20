package com.netsky.service;

/**
 * 计算服务
 * 
 * @author CT
 * @create 2009-04-09
 */
public interface CalculateService {
	/**
	 * 表计算
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @throws Exception
	 */
	public void Calculate(Integer dxgc_id) throws Exception;

	/**
	 * 表三计算
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @param gcxm_id
	 *            工程项目ID
	 */
	public void B3Calculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * 定额关联生成机械，仪表，主材，设备自动生成
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @param gcxm_id
	 *            工程项目ID
	 * @param glzc
	 *            关联机械自动生成 1关联 0 不关联
	 * @param glsb
	 *            关联设备自动生成 1关联 0 不关联
	 * @param gljx
	 *            关联机械自动生成 1关联 0 不关联
	 * @param glyb
	 *            关联仪表自动生成 1关联 0 不关联
	 * @throws Exception
	 */
	public void DeAssociated(Integer dxgc_id, Integer gcxm_id, Integer glzc, Integer glsb, Integer gljx, Integer glyb) throws Exception;

	/**
	 * 表三乙丙计算
	 * 
	 * @param dxgc_id
	 *            单项工程ＩＤ
	 * @param gcxm_id
	 *            工程项目ＩＤ
	 */
	public void B3yCalculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * 表三丙计算
	 * 
	 * @param dxgc_id
	 *            单项工程ＩＤ
	 * @param gcxm_id
	 *            工程项目ＩＤ
	 */
	public void B3bCalculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * 表四计算-单表
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @param gcxm_id
	 *            工程项目ID
	 * @param bgxx_id
	 *            表格信息ID
	 */
	public void B4Calculate(Integer gcxm_id, Integer dxgc_id, Integer bgxx_id);

	/**
	 * 表四计算-多表
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @param gcxm_id
	 *            工程项目ID
	 */
	public void B4CalculateAll(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 表四合并
	 * 
	 * @param dxgc_id
	 *            单项工程ID
	 * @param gcxm_id
	 *            工程项目ID
	 * @param bgxx_id
	 *            表格信息ID
	 */
	public void B4Merger(Integer gcxm_id, Integer dxgc_id, Integer bgxx_id, String[] fields);

	/**
	 * 计算建设单位管理费
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @return number 工程总概算= 工程费
	 */
	public String JSDWGLFCalculate(Integer dxgc_id, String number);
}
