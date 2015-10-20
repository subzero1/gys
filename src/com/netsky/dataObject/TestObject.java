package com.netsky.dataObject;

/**
 * 测试信息表.
 * 
 * @hibernate.class table="TEST"
 * @author Chiang
 * @version $Revision: 1.6 $
 */
public class TestObject {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 测试text内容
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
