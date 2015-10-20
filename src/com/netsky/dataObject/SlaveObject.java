package com.netsky.dataObject;

/**
 * 上传附件到服务器硬盘通用接口
 * 
 * @author Chiang 2009-08-18
 */
public interface SlaveObject {

	/**
	 * 设置文件名
	 * 
	 * @param FileName
	 *            文件名
	 */
	public void setFileName(String FileName);

	/**
	 * 设置保存后文件路径
	 */
	public void setFilePatch(String FilePatch);

	/**
	 * 获取当前表id
	 */
	public Integer getId();
	
	/**
	 * 获取附件标识
	 * */
	public String getSlaveIdentifier();

}
