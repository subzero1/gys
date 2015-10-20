package com.netsky.service;

/**
 * ͬ����1-��5������Ϣservice�ӿ�
 * 
 * @author Chiang 2009-10-19
 */
public interface SynchronizeInfomation {

	/**
	 * ͬ����1������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @throws Exception
	 */
	public void SynchronizeB1(Integer dxgc_id) throws Exception;

	/**
	 * ͬ����2������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @throws Exception
	 */
	public void SynchronizeB2(Integer dxgc_id) throws Exception;

	/**
	 * ͬ����3��������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @throws Exception
	 */
	public void SynchronizeB3j(Integer dxgc_id) throws Exception;

	/**
	 * ͬ����3�ұ�������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @throws Exception
	 */
	public void SynchronizeB3yb(Integer dxgc_id) throws Exception;

	/**
	 * ͬ����4������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @throws Exception
	 */
	public void SynchronizeB4(Integer dxgc_id, String bgbh) throws Exception;

	/**
	 * ͬ����5������Ϣ,���������ݼ���
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @throws Exception
	 */
	public void SynchronizeB5(Integer dxgc_id) throws Exception;
}
