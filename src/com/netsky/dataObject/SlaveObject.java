package com.netsky.dataObject;

/**
 * �ϴ�������������Ӳ��ͨ�ýӿ�
 * 
 * @author Chiang 2009-08-18
 */
public interface SlaveObject {

	/**
	 * �����ļ���
	 * 
	 * @param FileName
	 *            �ļ���
	 */
	public void setFileName(String FileName);

	/**
	 * ���ñ�����ļ�·��
	 */
	public void setFilePatch(String FilePatch);

	/**
	 * ��ȡ��ǰ��id
	 */
	public Integer getId();
	
	/**
	 * ��ȡ������ʶ
	 * */
	public String getSlaveIdentifier();

}
