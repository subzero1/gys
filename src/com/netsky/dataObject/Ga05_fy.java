package com.netsky.dataObject;

/**
 * 费用表.
 * 
 * @hibernate.class table="GA05_FY"
 * @author lx
 * 
 */
public class Ga05_fy {
	/**
	 * ID Number 10 N
	 */
	private Integer id;

	/**
	 * MC Varchar 200 费用名称
	 */
	private String mc;

	/**
	 * JSGS Varchar 200 计算公式
	 */
	private String jsgs;

	/**
	 * BGBH Varchar 20 表格编号
	 */
	private String bgbh;

	/**
	 * SXH Number 10 顺序号
	 */
	private Integer sxh;

	/**
	 * BZ Varchar 200 备注
	 */
	private String bz;

	/**
	 * 公式表达式
	 */
	private String gsbds;

	/**
	 * 公式相关费用
	 */
	private String xgfy;
	
	/**
	 * 查看各表计算结果顺序
	 */
	private Integer sortid;

	/**
	 * 
	 * @return sortid
	 * @hibernate.property column="sortid"
	 */
	public Integer getSortid() {
		return sortid;
	}
	/**
	 * 
	 * @param sortid
	 */
	public void setSortid(Integer sortid) {
		this.sortid = sortid;
	}

	/**
	 * @return the bgbh
	 * @hibernate.property column="bgbh"
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
	 * @return the bz
	 * @hibernate.property column="bz"
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
	 * @return the jsgs
	 * @hibernate.property column="jsgs"
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
	 * @return the gsbds
	 * @hibernate.property column="gsbds"
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

}
