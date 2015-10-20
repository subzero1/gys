package com.netsky.service;

/**
 * ��ȡ��ӡ���ҳ������ӿ�
 * 
 * @author Chiang 2009-05-21
 */
public interface PrintService {
	/**
	 * ��ȡ��1ҳ��
	 * 
	 * @param gcxm_id
	 *            ������ĿID
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB1pages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ��2ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB2pages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ��5j��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB5jTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ������5jҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB5jpages(Integer dxgc_id);

	/**
	 * ��ȡ��3j��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB3jTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ������3jҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3jpages(Integer dxgc_id);

	/**
	 * ��ȡ��3y��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB3yTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ������3yiҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3ypages(Integer dxgc_id);

	/**
	 * ��ȡ��3����ҳ��
	 * 
	 * @param gcxm_id
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3bTotalpages(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ��ȡ������3��ҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3bpages(Integer dxgc_id);

	/**
	 * ��ȡ��5��Ĭ������
	 */
	public int getB5j_onePageRows();

	/**
	 * ��ȡ��3��Ĭ������
	 * 
	 */
	public int getB3j_onePageRows();

	/**
	 * ��ȡ��4Ĭ������
	 */
	public int getB4_onePageRows();

	/**
	 * ��ȡ��3��Ĭ������
	 * 
	 * @return
	 */
	public int getB3y_onePageRows();

	/**
	 * ��ȡ������4ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @return Integer ҳ��
	 */
	public Integer getB4pages(Integer dxgc_id, String bgbh);

	/**
	 * ��ȡ��4��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @return Integer ҳ��
	 */
	public Integer getB4Totalpages(Integer gcxm_id, Integer dxgc_id, String bgbh);

	/**
	 * ��ȡ���ܱ���ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @return Integer ҳ��
	 */
	public Integer getHzbTotalpages(Integer gcxm_id, String dxgc_ids);

	/**
	 * ��ȡ���ܱ�Ĭ������
	 */
	public int getHzb_onePagesRows();

}
