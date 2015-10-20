package com.netsky.service;

/**
 * 获取打印表格页数服务接口
 * 
 * @author Chiang 2009-05-21
 */
public interface PrintService {
	/**
	 * 获取表1页数
	 * 
	 * @param gcxm_id
	 *            工程项目ID
	 * @param dxgc_id
	 * @return Integer 页数
	 */
	public Integer getB1pages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取表2页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @return Integer 页数
	 */
	public Integer getB2pages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取表5j总页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @return Integer 页数
	 */
	public Integer getB5jTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取单个表5j页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @return Integer 页数
	 */
	public Integer getB5jpages(Integer dxgc_id);

	/**
	 * 获取表3j总页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @return Integer 页数
	 */
	public Integer getB3jTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取单个表3j页数
	 * 
	 * @param dxgc_id
	 * @return Integer 页数
	 */
	public Integer getB3jpages(Integer dxgc_id);

	/**
	 * 获取表3y总页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @return Integer 页数
	 */
	public Integer getB3yTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取单个表3yi页数
	 * 
	 * @param dxgc_id
	 * @return Integer 页数
	 */
	public Integer getB3ypages(Integer dxgc_id);

	/**
	 * 获取表3丙总页数
	 * 
	 * @param gcxm_id
	 * @param dxgc_id
	 * @return Integer 页数
	 */
	public Integer getB3bTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * 获取单个表3丙页数
	 * 
	 * @param dxgc_id
	 * @return Integer 页数
	 */
	public Integer getB3bpages(Integer dxgc_id);

	/**
	 * 获取表5甲默认行数
	 */
	public int getB5j_onePageRows();

	/**
	 * 获取表3甲默认行数
	 * 
	 */
	public int getB3j_onePageRows();

	/**
	 * 获取表4默认行数
	 */
	public int getB4_onePageRows();

	/**
	 * 获取表3乙默认行数
	 * 
	 * @return
	 */
	public int getB3y_onePageRows();

	/**
	 * 获取单个表4页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @param bgbh
	 *            表格编号
	 * @return Integer 页数
	 */
	public Integer getB4pages(Integer dxgc_id, String bgbh);

	/**
	 * 获取表4总页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @param dxgc_id
	 *            单项工程id
	 * @param bgbh
	 *            表格编号
	 * @return Integer 页数
	 */
	public Integer getB4Totalpages(Integer gcxm_id, Integer dxgc_id, String bgbh);

	/**
	 * 获取汇总表总页数
	 * 
	 * @param gcxm_id
	 *            工程项目id
	 * @return Integer 页数
	 */
	public Integer getHzbTotalpages(Integer gcxm_id, String dxgc_ids);

	/**
	 * 获取汇总表默认行数
	 */
	public int getHzb_onePagesRows();

}
