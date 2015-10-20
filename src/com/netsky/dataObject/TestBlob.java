package com.netsky.dataObject;

/**
 * ¸½¼þ²âÊÔ TESTBLOB
 * 
 * @author Chiang
 * @hibernate.class table="TESTBLOB"
 */
public class TestBlob implements BlobObject {

	private Integer id;

	private String name;

	private byte[] fileInfo;

	private String info;

	/**
	 * @return the fileInfo
	 * @hibernate.property column="fileInfo"
	 *                     type="org.springframework.orm.hibernate3.support.BlobByteArrayType"
	 * 
	 */
	public byte[] getFileInfo() {
		return fileInfo;
	}

	/**
	 * @param fileInfo
	 *            the fileInfo to set
	 */
	public void setFileInfo(byte[] fileInfo) {
		this.fileInfo = fileInfo;
	}

	/**
	 * @hibernate.id generator-class="increment"
	 * @return id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the name
	 * @hibernate.property column="name"
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	public byte[] getBlob() {
		return fileInfo;
	}

	public void setBlob(byte[] b) {
		this.fileInfo = b;

	}

	/**
	 * @return the info
	 * @hibernate.property column="info"
	 *                     type="org.springframework.orm.hibernate3.support.ClobStringType"
	 */
	public String getInfo() {
		return info;
	}

	/**
	 * @param info
	 *            the info to set
	 */
	public void setInfo(String info) {
		this.info = info;
	}

	public String getFileName() {
		return name;
	}

	public void setFileName(String fileName) {
		this.name = fileName;
	}

	public BlobObject cloneAttribute() {
		TestBlob cloneObject = new TestBlob();
		cloneObject.setInfo(this.getInfo());
		return cloneObject;
	}

}
