package com.netsky.dataObject;

/**
 * 定额关联材料、设备、机械、仪表.
 * 
 * @hibernate.class table="GA03_GLCL"
 * @author lx
 * 
 */
public class Ga03_glcl {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * Number 10 N 定额ID( GA01.ID) 外键：GA01.ID
	 */
	private Integer de_id;

	/**
	 * Number 10 N 材料ID (GA02.ID) 外键：GA02.ID
	 */
	private Integer cl_id;

	/**
	 * Number 5 材料序号
	 */
	private Integer xh;

	/**
	 * Number 12,3 单位定额对应的材料数量
	 */
	private Double clsl;

	/**
	 * 定额编号
	 */
	private String de_bh;

	/**
	 * 材料编号
	 */
	private String cl_bh;

	/**
	 * @return the cl_id
	 * @hibernate.property column="cl_id"
	 */
	public Integer getCl_id() {
		return cl_id;
	}

	/**
	 * @param cl_id
	 *            the cl_id to set
	 */
	public void setCl_id(Integer cl_id) {
		this.cl_id = cl_id;
	}

	/**
	 * @return the clsl
	 * @hibernate.property column="clsl"
	 */
	public Double getClsl() {
		return clsl;
	}

	/**
	 * @param clsl
	 *            the clsl to set
	 */
	public void setClsl(Double clsl) {
		this.clsl = clsl;
	}

	/**
	 * @return the de_id
	 * @hibernate.property column="de_id"
	 */
	public Integer getDe_id() {
		return de_id;
	}

	/**
	 * @param de_id
	 *            the de_id to set
	 */
	public void setDe_id(Integer de_id) {
		this.de_id = de_id;
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
	 * @return the xh
	 * @hibernate.property column="xh"
	 */
	public Integer getXh() {
		return xh;
	}

	/**
	 * @param xh
	 *            the xh to set
	 */
	public void setXh(Integer xh) {
		this.xh = xh;
	}

	/**
	 * @hibernate.property column="cl_bh"
	 * @return cl_bh
	 */
	public String getCl_bh() {
		return cl_bh;
	}

	/**
	 * @param cl_bh
	 */
	public void setCl_bh(String cl_bh) {
		this.cl_bh = cl_bh;
	}

	/**
	 * @hibernate.property column="de_bh"
	 * @return de_bh
	 */
	public String getDe_bh() {
		return de_bh;
	}

	/**
	 * @param de_bh
	 */
	public void setDe_bh(String de_bh) {
		this.de_bh = de_bh;
	}
}
