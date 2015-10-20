package com.netsky.dataObject;

/**
 * ������Ϣ��.
 * 
 * @hibernate.class table="TEST"
 * @author Chiang
 * @version $Revision: 1.6 $
 */
public class TestObject {

	/**
	 * ����
	 */
	private Integer id;

	/**
	 * ����text����
	 */
	private String text;

	/**
	 * @hibernate.id generator-class="increment"
	 * @return id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @hibernate.property column="text"
	 * @return text
	 */
	public String getText() {
		return text;
	}

	/**
	 * @param text
	 */
	public void setText(String text) {
		this.text = text;
	}

}
