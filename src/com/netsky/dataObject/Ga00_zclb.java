package com.netsky.dataObject;

/**
 * ��������.
 * 
 * @hibernate.class table="GA00_ZCLB"
 * @author lx
 * 
 */

public class Ga00_zclb {
	/**
	 * Number 10 N ��ʶ ����
	 */
	private Integer id;

	/**
	 * Varchar 20 N ����������
	 */
	private String zclb;

	/**
	 * Varchar 50 N ����
	 */
	private String mc;

	/**
	 * Varchar 20 N ��� ZC������ SB �豸JX����еYB���Ǳ�
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
	 * @return the zclb
	 * @hibernate.property column="zclb"
	 */
	public String getZclb() {
		return zclb;
	}

	/**
	 * @param zclb
	 *            the zclb to set
	 */
	public void setZclb(String zclb) {
		this.zclb = zclb;
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
