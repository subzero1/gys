package com.netsky.dataObject;
import java.io.Serializable;
/**
 * 表三乙.
 * 
 * @hibernate.class table="GD06_B3Y"
 * @author wangflan
 * 
 */
public class Gd06_b3y implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8046283654814881141L;

	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 项目ID
	 */
	private Integer gcxm_id;

	/**
	 * 单项工程ID
	 */
	private Integer dxgc_id;

	/**
	 * 表三甲
	 */
	private Integer b3j_id;

	/**
	 * 单位定额关联数量
	 */
	private Double glsl;

	/**
	 * 编号
	 */
	private String bh;

	/**
	 * 名称
	 */
	private String mc;

	/**
	 * 型号规格
	 */
	private String xhgg;

	/**
	 * 单位
	 */
	private String dw;

	/**
	 * 单价
	 */
	private Double dj;

	/**
	 * 调整系数
	 */
	private Double tzxs;

	/**
	 * 类别 JX：机械YB：仪表
	 */
	private String lb;

	/**
	 * 序号
	 */
	private Integer xh;

	/**
	 * @hibernate.property column="b3j_id"
	 * @return the b3j_id
	 */
	public Integer getB3j_id() {
		return b3j_id;
	}

	/**
	 * @param b3j_id
	 *            the b3j_id to set
	 */
	public void setB3j_id(Integer b3j_id) {
		this.b3j_id = b3j_id;
	}

	/**
	 * @hibernate.property column="bh"
	 * @return the bh
	 */
	public String getBh() {
		return bh;
	}

	/**
	 * @param bh
	 *            the bh to set
	 */
	public void setBh(String bh) {
		this.bh = bh;
	}

	/**
	 * @hibernate.property column="dj"
	 * @return the dj
	 */
	public Double getDj() {
		return dj;
	}

	/**
	 * @param dj
	 *            the dj to set
	 */
	public void setDj(Double dj) {
		this.dj = dj;
	}

	/**
	 * @hibernate.property column="dw"
	 * @return the dw
	 */
	public String getDw() {
		return dw;
	}

	/**
	 * @param dw
	 *            the dw to set
	 */
	public void setDw(String dw) {
		this.dw = dw;
	}

	/**
	 * @hibernate.property column="dxgc_id"
	 * @return the dxgc_id
	 */
	public Integer getDxgc_id() {
		return dxgc_id;
	}

	/**
	 * @param dxgc_id
	 *            the dxgc_id to set
	 */
	public void setDxgc_id(Integer dxgc_id) {
		this.dxgc_id = dxgc_id;
	}

	/**
	 * @hibernate.property column="gcxm_id"
	 * @return the gcxm_id
	 */
	public Integer getGcxm_id() {
		return gcxm_id;
	}

	/**
	 * @param gcxm_id
	 *            the gcxm_id to set
	 */
	public void setGcxm_id(Integer gcxm_id) {
		this.gcxm_id = gcxm_id;
	}

	/**
	 * @hibernate.property column="glsl"
	 * @return the glsl
	 */
	public Double getGlsl() {
		return glsl;
	}

	/**
	 * @param glsl
	 *            the glsl to set
	 */
	public void setGlsl(Double glsl) {
		this.glsl = glsl;
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
	 * @hibernate.property column="lb"
	 * @return the lb
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

	/**
	 * @hibernate.property column="tzxs"
	 * @return the tzxs
	 */
	public Double getTzxs() {
		return tzxs;
	}

	/**
	 * @param tzxs
	 *            the tzxs to set
	 */
	public void setTzxs(Double tzxs) {
		this.tzxs = tzxs;
	}

	/**
	 * @hibernate.property column="xh"
	 * @return the xh
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
	 * @hibernate.property column="xhgg"
	 * @return the xhgg
	 */
	public String getXhgg() {
		return xhgg;
	}

	/**
	 * @param xhgg
	 *            the xhgg to set
	 */
	public void setXhgg(String xhgg) {
		this.xhgg = xhgg;
	}

}
