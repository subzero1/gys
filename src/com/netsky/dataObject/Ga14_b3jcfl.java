package com.netsky.dataObject;

/**
 * 表三基础费率表
 * 
 * @hibernate.class table="GA14_B3JCFL"
 * @author CT
 * 
 */
public class Ga14_b3jcfl {
	/**
	 * id
	 */
	private Integer id;

	/**
	 * 费率库id GA04.ID
	 */
	private Integer flk_id;

	/**
	 * 名称
	 */
	private String mc;

	/**
	 * 人工费率
	 */
	private Double rgfl;

	/**
	 * 机械费率
	 */
	private Double jxfl;

	/**
	 * 费用类别 1：人工；2：机械
	 */
	private Integer fylb;

	/**
	 * 施工条件标志 1：高原；2：森林沙漠
	 */
	private Integer bz;

	/**
	 * @hibernate.property column="bz"
	 * @return bz
	 */
	public Integer getBz() {
		return bz;
	}

	/**
	 * @param bz
	 */
	public void setBz(Integer bz) {
		this.bz = bz;
	}

	/**
	 * @return the jxfl
	 * @hibernate.property column="jxfl"
	 */
	public Double getJxfl() {
		return jxfl;
	}

	/**
	 * @param jxfl
	 *            the jxfl to set
	 */
	public void setJxfl(Double jxfl) {
		this.jxfl = jxfl;
	}

	/**
	 * @return the rgfl
	 * @hibernate.property column="rgfl"
	 */
	public Double getRgfl() {
		return rgfl;
	}

	/**
	 * @param rgfl
	 *            the rgfl to set
	 */
	public void setRgfl(Double rgfl) {
		this.rgfl = rgfl;
	}

	/**
	 * @hibernate.property column="flk_id"
	 * @return flk_id
	 */
	public Integer getFlk_id() {
		return flk_id;
	}

	/**
	 * @param flk_id
	 */
	public void setFlk_id(Integer flk_id) {
		this.flk_id = flk_id;
	}

	/**
	 * @hibernate.property column="fylb"
	 * @return fylb
	 */
	public Integer getFylb() {
		return fylb;
	}

	/**
	 * @param fylb
	 */
	public void setFylb(Integer fylb) {
		this.fylb = fylb;
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
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @hibernate.property column="mc"
	 * @return mc
	 */
	public String getMc() {
		return mc;
	}

	/**
	 * @param mc
	 */
	public void setMc(String mc) {
		this.mc = mc;
	}
}
