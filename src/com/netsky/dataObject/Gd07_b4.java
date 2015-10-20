package com.netsky.dataObject;
import java.io.Serializable;
/**
 * 表四.
 * 
 * @hibernate.class table="GD07_B4"
 * @author wangflan
 * 
 */
public class Gd07_b4 implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 291589461850776486L;

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
	 * 数量
	 */
	private Double sl;

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
	 * 规格
	 */
	private String gg;

	/**
	 * 单位
	 */
	private String dw;

	/**
	 * 单价
	 */
	private Double dj;

	/**
	 * 主材类别
	 */
	private String zclb;

	/**
	 * 表格编号 B4ZC：主材 B4ZCFB：主材附表 B4XASB：需安设备 B4BXASB：不需安设备 B4BPBJ：备品备件
	 * B4WHQJ：维护器具 B4GDLSB：光电缆设备 B4HSSBB：回收设备表 B4HSCLB：回收材料表 B4JZGCB：建筑工程表
	 */
	private String bgbh;

	/**
	 * 备注
	 */
	private String bz;

	/**
	 * 计取税金标志
	 */
	private Integer sj_bz;

	/**
	 * 调整系数
	 */
	private Double tzxs;

	/**
	 * 序号
	 */
	private Integer xh;
	


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

	/**
	 * @hibernate.property column="sj_bz"
	 * @return the sj_bz
	 */
	public Integer getSj_bz() {
		return sj_bz;
	}

	/**
	 * @param sj_bz
	 *            the sj_bz to set
	 */
	public void setSj_bz(Integer sj_bz) {
		this.sj_bz = sj_bz;
	}

	/**
	 * @hibernate.property column="sl"
	 * @return the sl
	 */
	public Double getSl() {
		return sl;
	}

	/**
	 * @param sl
	 *            the sl to set
	 */
	public void setSl(Double sl) {
		this.sl = sl;
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
	 * @hibernate.property column = "gg"
	 * @return gg
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
