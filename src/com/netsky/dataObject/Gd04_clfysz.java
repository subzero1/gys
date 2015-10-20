package com.netsky.dataObject;
import java.io.Serializable;
/**
 * 工程材料费用设置.
 * 
 * @hibernate.class table="GD04_CLFYSZ"
 * @author wangflan
 * 
 */
public class Gd04_clfysz  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6403440799251839602L;

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
	 * 主材类别
	 */
	private String zclb;

	/**
	 * 分类运距
	 */
	private Double flyj;

	/**
	 * 分类合计值
	 */
	private Double flhjz;

	/**
	 * 费用ID
	 */
	private Integer fy_id;

	/**
	 * 费用名称
	 */
	private String fymc;

	/**
	 * 费率值
	 */
	private Double flz;

	/**
	 * 费用值
	 */
	private Double fyz;

	/**
	 * 表格编号
	 */
	private String bgbh;

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
	 * @hibernate.property column="flhjz"
	 * @return the flhjz
	 */
	public Double getFlhjz() {
		return flhjz;
	}

	/**
	 * @param flhjz
	 *            the flhjz to set
	 */
	public void setFlhjz(Double flhjz) {
		this.flhjz = flhjz;
	}

	/**
	 * @hibernate.property column="flyj"
	 * @return the flyj
	 */
	public Double getFlyj() {
		return flyj;
	}

	/**
	 * @param flyj
	 *            the flyj to set
	 */
	public void setFlyj(Double flyj) {
		this.flyj = flyj;
	}

	/**
	 * @hibernate.property column="flz"
	 * @return the flz
	 */
	public Double getFlz() {
		return flz;
	}

	/**
	 * @param flz
	 *            the flz to set
	 */
	public void setFlz(Double flz) {
		this.flz = flz;
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
	 * @hibernate.property column="zclb"
	 * @return the zclb
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
	 * @return the bgbh
	 * @hibernate.property column="bgbh"
	 */
	public String getBgbh() {
		return bgbh;
	}

	/**
	 * @param bgbh the bgbh to set
	 */
	public void setBgbh(String bgbh) {
		this.bgbh = bgbh;
	}

}
