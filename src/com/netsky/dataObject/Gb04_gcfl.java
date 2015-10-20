package com.netsky.dataObject;

/**
 * 工程分类志.
 * 
 * @hibernate.class table="GB04_GCFL"
 * @author wangflan
 * 
 */
public class Gb04_gcfl {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 分类名称
	 */
	private String mc;

	/**
	 * 操作员标识
	 */
	private Integer czy_id;

	/**
	 * @hibernate.property column="czy_id"
	 * @return the czy_id
	 */
	public Integer getCzy_id() {
		return czy_id;
	}

	/**
	 * @param czy_id
	 *            the czy_id to set
	 */
	public void setCzy_id(Integer czy_id) {
		this.czy_id = czy_id;
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
	 * @hibernate.property column="mc"
	 * @return the mc
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
