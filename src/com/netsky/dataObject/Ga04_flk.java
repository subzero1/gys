package com.netsky.dataObject;

/**
 * ���ʿ�.
 * 
 * @hibernate.class table="GA04_FLK"
 * @author lx
 * 
 */
public class Ga04_flk {
	/**
	 * Number 10 N
	 */
	private Integer id;

	/**
	 * Varchar 200 N ���ʿ�����
	 */
	private String mc;

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
	 * @return the mc
	 * @hibernate.property column="mc"
	 */
	public String getMc() {
		return mc;
	}

	/**
	 * @param mc
	 *            the mc to set
	 */
	public void setMc(String mc) {
		this.mc = mc;
	}

}
