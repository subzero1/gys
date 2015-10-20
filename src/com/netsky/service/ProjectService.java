package com.netsky.service;

/**
 * @author Chiang
 * 
 * 工程相关服务
 */
public interface ProjectService {

	/**
	 * 复制单项工程
	 * 
	 * @param dxgc_id
	 *            被复制单项工程id
	 * @param gcxm_id
	 *            新建项目所属工程项目id
	 * @param gcfl
	 *            新建项目分类
	 * @return 新建单项工程id
	 */
	public Integer copyProject(Integer dxgc_id, Integer gcxm_id, String newDxgcName, String gcfl) throws Exception;

}
