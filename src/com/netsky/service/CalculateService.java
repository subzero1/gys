package com.netsky.service;

/**
 * �������
 * 
 * @author CT
 * @create 2009-04-09
 */
public interface CalculateService {
	/**
	 * �����
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @throws Exception
	 */
	public void Calculate(Integer dxgc_id) throws Exception;

	/**
	 * ��������
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @param gcxm_id
	 *            ������ĿID
	 */
	public void B3Calculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * ����������ɻ�е���Ǳ����ģ��豸�Զ�����
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @param gcxm_id
	 *            ������ĿID
	 * @param glzc
	 *            ������е�Զ����� 1���� 0 ������
	 * @param glsb
	 *            �����豸�Զ����� 1���� 0 ������
	 * @param gljx
	 *            ������е�Զ����� 1���� 0 ������
	 * @param glyb
	 *            �����Ǳ��Զ����� 1���� 0 ������
	 * @throws Exception
	 */
	public void DeAssociated(Integer dxgc_id, Integer gcxm_id, Integer glzc, Integer glsb, Integer gljx, Integer glyb) throws Exception;

	/**
	 * �����ұ�����
	 * 
	 * @param dxgc_id
	 *            ����̣ɣ�
	 * @param gcxm_id
	 *            ������Ŀ�ɣ�
	 */
	public void B3yCalculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * ����������
	 * 
	 * @param dxgc_id
	 *            ����̣ɣ�
	 * @param gcxm_id
	 *            ������Ŀ�ɣ�
	 */
	public void B3bCalculate(Integer dxgc_id, Integer gcxm_id);

	/**
	 * ���ļ���-����
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @param gcxm_id
	 *            ������ĿID
	 * @param bgxx_id
	 *            �����ϢID
	 */
	public void B4Calculate(Integer gcxm_id, Integer dxgc_id, Integer bgxx_id);

	/**
	 * ���ļ���-���
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @param gcxm_id
	 *            ������ĿID
	 */
	public void B4CalculateAll(Integer gcxm_id, Integer dxgc_id);

	/**
	 * ���ĺϲ�
	 * 
	 * @param dxgc_id
	 *            �����ID
	 * @param gcxm_id
	 *            ������ĿID
	 * @param bgxx_id
	 *            �����ϢID
	 */
	public void B4Merger(Integer gcxm_id, Integer dxgc_id, Integer bgxx_id, String[] fields);

	/**
	 * ���㽨�赥λ�����
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @return number �����ܸ���= ���̷�
	 */
	public String JSDWGLFCalculate(Integer dxgc_id, String number);
}
