package com.netsky.service;

/**
 * @author Chiang
 * 
 * ������ط���
 */
public interface ProjectService {

	/**
	 * ���Ƶ����
	 * 
	 * @param dxgc_id
	 *            �����Ƶ����id
	 * @param gcxm_id
	 *            �½���Ŀ����������Ŀid
	 * @param gcfl
	 *            �½���Ŀ����
	 * @return �½������id
	 */
	public Integer copyProject(Integer dxgc_id, Integer gcxm_id, String newDxgcName, String gcfl) throws Exception;

}
