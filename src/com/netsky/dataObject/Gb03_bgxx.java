package com.netsky.dataObject;

/**
 * 表格信息.
 * 
 * @hibernate.class table="GB03_BGXX"
 * @author wangflan
 * 
 */
public class Gb03_bgxx {
	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 表格名称
	 */
	private String mc;

	/**
	 * 副标题
	 */
	private String fbt;

	/**
	 * 表格编号
	 */
	private String bgbh;

	/**
	 * 顺序号
	 */
	private Integer sxh;

	/**
	 * 对应表单文件
	 */
	private String bdwj;

	/**
	 * 表4类别
	 */
	private String b4lb;

	/**
	 * 打印输出表格编号
	 */
	private String dyscbgbh;

	/**
	 * 表格相关费用，未选中表格时不出现在公式中
	 */
	private String xgfy;

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
	 * @hibernate.property column="fbt"
	 * @return the fbt
	 */
	public String getFbt() {
		return fbt;
	}

	/**
	 * @param fbt
	 *            the fbt to set
	 */
	public void setFbt(String fbt) {
		this.fbt = fbt;
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
	 * @hibernate.property column="sxh"
	 * @return the sxh
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
	 * @return the bdwj
	 * @hibernate.property column="bdwj"
	 */
	public String getBdwj() {
		return bdwj;
	}

	/**
	 * @param bdwj
	 *            the bdwj to set
	 */
	public void setBdwj(String bdwj) {
		this.bdwj = bdwj;
	}

	/**
	 * @return the b4lb
	 * @hibernate.property column="b4lb"
	 */
	public String getB4lb() {
		return b4lb;
	}

	/**
	 * @param b4lb
	 *            the b4lb to set
	 */
	public void setB4lb(String b4lb) {
		this.b4lb = b4lb;
	}

	/**
	 * @return the dyscbgbh
	 * @hibernate.property column="dyscbgbh"
	 */
	public String getDyscbgbh() {
		return dyscbgbh;
	}

	/**
	 * @param dyscbgbh
	 *            the dyscbgbh to set
	 */
	public void setDyscbgbh(String dyscbgbh) {
		this.dyscbgbh = dyscbgbh;
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
