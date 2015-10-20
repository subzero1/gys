package com.netsky.dataObject;

import java.io.Serializable;

/**
 * 工程费用设置.
 * 
 * @hibernate.class table="GD03_GCFYSZ"
 * @author wangflan
 * 
 */
public class Gd03_gcfysz  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7015404532976835217L;

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
	 * 费用ID
	 */
	private Integer fy_id;

	/**
	 * 计算公式
	 */
	private String fymc;

	/**
	 * 计算公式
	 */
	private String jsgs;

	/**
	 * 公式表达式
	 */
	private String gsbds;

	/**
	 * 费用值
	 */
	private Double fyz;

	/**
	 * 表格编号
	 */
	private String bgbh;

	/**
	 * 备注
	 */
	private String bz;

	/**
	 * 顺序号
	 */
	private Integer sxh;

	/**
	 * 相关费用
	 */
	private String xgfy;

	/**
	 * 打印预览标识
	 */
	private Integer dyyl;

	/**
	 * @hibernate.property column="bgbh"
	 * @return the bgbh
	 */
	public String getBgbh() {
		return bgbh;
	}

	/**
	 * @param bgbh
	 *            the bgbh to set
	 */
	public void setBgbh(String bgbh) {
		this.bgbh = bgbh;
	}

	/**
	 * @hibernate.property column="bz"
	 * @return the bz
	 */
	public String getBz() {
		return bz;
	}

	/**
	 * @param bz
	 *            the bz to set
	 */
	public void setBz(String bz) {
		this.bz = bz;
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
	 * @hibernate.property column="fy_id"
	 * @return the fy_id
	 */
	public Integer getFy_id() {
		return fy_id;
	}

	/**
	 * @param fy_id
	 *            the fy_id to set
	 */
	public void setFy_id(Integer fy_id) {
		this.fy_id = fy_id;
	}

	/**
	 * @hibernate.property column="fymc"
	 * @return the fymc
	 */
	public String getFymc() {
		return fymc;
	}

	/**
	 * @param fymc
	 *            the fymc to set
	 */
	public void setFymc(String fymc) {
		this.fymc = fymc;
	}

	/**
	 * @hibernate.property column="fyz"
	 * @return the fyz
	 */
	public Double getFyz() {
		return fyz;
	}

	/**
	 * @param fyz
	 *            the fyz to set
	 */
	public void setFyz(Double fyz) {
		this.fyz = fyz;
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
	 * @hibernate.property column="gsbds"
	 * @return the gsbds
	 */
	public String getGsbds() {
		return gsbds;
	}

	/**
	 * @param gsbds
	 *            the gsbds to set
	 */
	public void setGsbds(String gsbds) {
		this.gsbds = gsbds;
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
	 * @hibernate.property column="jsgs"
	 * @return the jsgs
	 */
	public String getJsgs() {
		return jsgs;
	}

	/**
	 * @param jsgs
	 *            the jsgs to set
	 */
	public void setJsgs(String jsgs) {
		this.jsgs = jsgs;
	}

	/**
	 * @return the sxh
	 * @hibernate.property column="sxh"
	 */
	public Integer getSxh() {
		return sxh;
	}

	/**
	 * @param sxh
	 *            the sxh to set
	 */
	public void setSxh(Integer sxh) {
		this.sxh = sxh;
	}

	/**
	 * @return the xgfy
	 * @hibernate.property column="xgfy"
	 */
	public String getXgfy() {
		return xgfy;
	}

	/**
	 * @param xgfy
	 *            the xgfy to set
	 */
	public void setXgfy(String xgfy) {
		this.xgfy = xgfy;
	}

	/**
	 * @return the dyyl
	 * @hibernate.property column="dyyl"
	 */
	public Integer getDyyl() {
		return dyyl;
	}

	/**
	 * @param dyyl
	 *            the dyyl to set
	 */
	public void setDyyl(Integer dyyl) {
		this.dyyl = dyyl;
	}

}
