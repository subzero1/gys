package com.netsky.dataObject;

/**
 * 标准材料、设备、机械、仪表库.
 * 
 * @hibernate.class table="GA02_CLSB"
 * @author lx
 * 
 */
public class Ga02_clsb {
	/**
	 * Number 10 N 标识 主键
	 */
	private Integer id;

	/**
	 * Varchar 20 N 编号
	 */
	private String bh;

	/**
	 * Varchar 200 N 名称
	 */
	private String mc;

	/**
	 * Varchar 20 单位
	 */
	private String dw;

	/**
	 * Varchar 200 型号规格
	 */
	private String xhgg;
	/**
	 * 规格(pss系统用)
	 */
	private String gg;

	/**
	 * Number 12,2 本地价
	 */
	private Double bdj;

	/**
	 * Number 12,2 本省价
	 */
	private Double bsj;

	/**
	 * Number 12,2 全国价
	 */
	private Double qgj;

	/**
	 * Number 12,2 预算价
	 */
	private Double ysj;

	/**
	 * Varchar 2 N 类别 ZC：主材 SB：设备JX：机械YB：仪表
	 */
	private String lb;

	/**
	 * Varchar 2 N 主材类别 GA00.ZCLB
	 */
	private String zclb;

	/**
	 * Varchar 200 备注
	 */
	private String bz;
	/**
	 * 材料来源（甲供/乙供/拆旧）
	 */
	private String clly;
	/**
	 * 所属材料库（[GC01.ID1][GC01.ID2][GC01.ID3]......）
	 */
    private Integer clk_id;
    /**
     * @hibernate.property column="clk_id"
     * @return clk_id
     */
	public Integer getClk_id() {
		return clk_id;
	}
	/**
	 * @param clk_id
	 */
	public void setClk_id(Integer clk_id) {
		this.clk_id = clk_id;
	}
	/**
	 * @hibernate.property column="clly"
	 * @return clly
	 */
	public String getClly() {
		return clly;
	}
	/**
	 * @param clly
	 */
	public void setClly(String clly) {
		this.clly = clly;
	}

	/**
	 * @return the bdj
	 * @hibernate.property column="bdj"
	 */
	public Double getBdj() {
		return bdj;
	}

	/**
	 * @param bdj
	 *            the bdj to set
	 */
	public void setBdj(Double bdj) {
		this.bdj = bdj;
	}

	/**
	 * @return the bh
	 * @hibernate.property column="bh"
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
	 * @return the bsj
	 * @hibernate.property column="bsj"
	 */
	public Double getBsj() {
		return bsj;
	}

	/**
	 * @param bsj
	 *            the bsj to set
	 */
	public void setBsj(Double bsj) {
		this.bsj = bsj;
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
	 * @return the dw
	 * @hibernate.property column="dw"
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

	/**
	 * @return the qgj
	 * @hibernate.property column="qgj"
	 */
	public Double getQgj() {
		return qgj;
	}

	/**
	 * @param qgj
	 *            the qgj to set
	 */
	public void setQgj(Double qgj) {
		this.qgj = qgj;
	}

	/**
	 * @return the xhgg
	 * @hibernate.property column="xhgg"
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

	/**
	 * @return the ysj
	 * @hibernate.property column="ysj"
	 */
	public Double getYsj() {
		return ysj;
	}

	/**
	 * @param ysj
	 *            the ysj to set
	 */
	public void setYsj(Double ysj) {
		this.ysj = ysj;
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
	 * @hibernate.property column="gg"
	 * @return gg;
	 */
	public String getGg() {
		return gg;
	}
	/**
	 * @param gg
	 */
	public void setGg(String gg) {
		this.gg = gg;
	}

}
