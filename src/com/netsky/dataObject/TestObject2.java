package com.netsky.dataObject;

/**
 * 测试信息表2.
 * 
 * @hibernate.class table="TEST2"
 * @author Chiang
 * @version $Revision: 1.6 $
 */
public class TestObject2 {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 父表 TestObject test id
	 * 
	 * @see com.netsky.dataObject.TestObject
	 */
	private Integer parent_id;

	/**
	 * 测试文本
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
