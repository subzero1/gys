package com.netsky.dataObject;

/**
 * ����blob�ֶνӿڶ���,������Ҫ����blob�ֶγ־û�������ʵ�ִ˽ӿ�.
 * 
 * @author Chiang
 */
public interface BlobObject {

	/**
	 * ����blob
	 * 
	 * @param Blob
	 */
	public void setBlob(byte[] b);

	/**
	 * ��ȡblob
	 * 
	 * @return Blob
	 */
	public byte[] getBlob();

	/**
	 * �����ļ���
	 */
	public void setFileName(String fileName);

	/**
	 * ��ȡ�ļ���
	 */
	public String getFileName();

	/**
	 * ���ƶ���
	 */
	public BlobObject cloneAttribute();
}
