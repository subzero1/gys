package com.netsky.dataObject;

/**
 * ������Ϣ��2.
 * 
 * @hibernate.class table="TEST2"
 * @author Chiang
 * @version $Revision: 1.6 $
 */
public class TestObject2 {

	/**
	 * ����
	 */
	private Integer id;

	/**
	 * ���� TestObject test id
	 * 
	 * @see com.netsky.dataObject.TestObject
	 */
	private Integer parent_id;

	/**
	 * �����ı�
	 */
	private String text;

	/**
	 * @hibernate.id generator-class="increment"
	 * @return id.
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
	 * @hibernate.property column="parent_id"
	 * @return parent_id.
	 */
	public Integer getParent_id() {
		return parent_id;
	}

	/**
	 * @param parent_id
	 */
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}

	/**
	 * @hibernate.property column="text"
	 * @return text.
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
