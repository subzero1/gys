package com.netsky.dataObject;

/**
 * 专业表表.
 * 
 * @hibernate.class table="GA06_ZY"
 * @author lx
 * 
 */
public class Ga06_zy {
	/**
	 * ID Number 10 N
	 */
	private Integer id;

	/**
	 * MC Varchar 200 N 专业名称
	 */
	private String mc;

	/**
	 * LB Varchar 10 N 专业类别 XL：线路GD：管道SB：设备QT：其它
	 */
	private String lb;

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
	 * @return the lb
	 * @hibernate.property column="lb"
	 */
	public String getLb() {
		return lb;
	}

	/**
	 * @param lb
	 *            the lb to set
	 */
	public void setLb(String lb) {
		this.lb = lb;
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
