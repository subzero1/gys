/**
 * 
 */
package com.netsky.dataObject;

/**
 * 扩拆系数.
 * 
 * @hibernate.class table="GA09_KCXS"
 * @author wangflan
 * 
 */
public class Ga09_kcxs {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 拆扩类别 1：新建 2：扩建 3：拆除再利用 4：拆除不再利用 5：更换
	 */
	private Integer lb;

	/**
	 * 说明
	 */
	private String sm;

	/**
	 * 起始定额编号
	 */
	private String qsbh;

	/**
	 * 截止定额编号
	 */
	private String jzbh;

	/**
	 * 系数
	 */
	private Double xs;
	/**
	 * 类别 1人工；2机械
	 */
	private Integer sort;
	
	/**
	 * @hibernate.property column="sort"
	 * @return sort
	 */
	public Integer getSort() {
		return sort;
	}
	/**
	 * 
	 * @param sort
	 */
	public void setSort(Integer sort) {
		this.sort = sort;
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
	 * @hibernate.property column="jzbh"
	 * @return the jzbh
	 */
	public String getJzbh() {
		return jzbh;
	}

	/**
	 * @param jzbh
	 *            the jzbh to set
	 */
	public void setJzbh(String jzbh) {
		this.jzbh = jzbh;
	}

	/**
	 * @hibernate.property column="lb"
	 * @return the lb
	 */
	public Integer getLb() {
		return lb;
	}

	/**
	 * @param lb
	 *            the lb to set
	 */
	public void setLb(Integer lb) {
		this.lb = lb;
	}

	/**
	 * @hibernate.property column="qsbh"
	 * @return the qsbh
	 */
	public String getQsbh() {
		return qsbh;
	}

	/**
	 * @param qsbh
	 *            the qsbh to set
	 */
	public void setQsbh(String qsbh) {
		this.qsbh = qsbh;
	}

	/**
	 * @hibernate.property column="sm"
	 * @return the sm
	 */
	public String getSm() {
		return sm;
	}

	/**
	 * @param sm
	 *            the sm to set
	 */
	public void setSm(String sm) {
		this.sm = sm;
	}

	/**
	 * @hibernate.property column="xs"
	 * @return the xs
	 */
	public Double getXs() {
		return xs;
	}

	/**
	 * @param xs
	 *            the xs to set
	 */
	public void setXs(Double xs) {
		this.xs = xs;
	}

}
