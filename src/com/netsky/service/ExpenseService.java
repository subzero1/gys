package com.netsky.service;

import javax.servlet.http.HttpServletRequest;

import com.netsky.dataObject.Gd02_dxgc;

/**
 * @author Chiang 2009-05-13
 * 
 * ���ʷ�����ط���
 */
public interface ExpenseService {

	/**
	 * ��ȡ���ʱ�1,2,5ֵ
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @param fy_id
	 *            ga05����id
	 * @throws Exception
	 * @return String flz ���ط�����ط���
	 */
	public String getFlz(Integer dxgc_id, Integer fy_id) throws Exception;

	/**
	 * �������ݺ�������,����gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void updateGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception;

	/**
	 * �������ݺ�������,��ga14����д��gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception;
	
	/**
	 * �������ݺ�������,��ga14����д��gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10Hessian(Gd02_dxgc gd02) throws Exception;

	/**
	 * �����ۺ���Ϣ��Ĵ���,��ga05�з�������д��gd03
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd03(Gd02_dxgc gd02) throws Exception;

	/**
	 * ���»�ȡ�������
	 * 
	 * @param gd02
	 * @param bgbh
	 *            �����
	 * @throws Exception
	 */
	public void reBuildFy(Gd02_dxgc gd02, String bgbh, HttpServletRequest request) throws Exception;

	/**
	 * �½��ۺ���Ϣʱд��gd04��Ϣ��
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd04(Gd02_dxgc gd02) throws Exception;

	/**
	 * ��ȡרҵ��ط���
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void rebuildZyfl(Gd02_dxgc gd02) throws Exception;

	/**
	 * ɾ�����ʱ������ط���,�ӹ�ʽ��ɾ���˷���,���ӱ����Ϣʱ���¸���ʽ��ӷ���,gb03�д洢��Ҫ�˴���ķ���
	 * 
	 * @param gd02
	 * @param bgxx_id gb03_id ��Ҫ�����ı��
	 * @param oper_flag "delete" or "add" 
	 * @throws Exception
	 */
	public void updateJsgc(Gd02_dxgc gd02, Integer bgxx_id, String oper_flag) throws Exception;

}
