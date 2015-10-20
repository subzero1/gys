package com.netsky.dataObject;

import java.util.Date;
/**
 * 专业表表.
 * 
 * @hibernate.class table="GB05_YHk"
 * @author lx
 * 
 */
public class Gb05_yhk {

	/**
	 * 标识 主键
	 */
	private Integer id;

	/**
	 * 用户库名称
	 */
	private String mc;

	/**
	 * 备注
	 */
	private String bz;
	
	/**
	 * 创建人id
	 */
	private Integer cjr_id;
	
	/**
	 * 创建时间
	 */
	private Date cjsj;
	
	/**
	 * 库分类
	 */
	private String lb;
	
	/**
	 * 共享标志
	 */
	private Integer gxbz;

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
	 * @hibernate.property column="cjr_id"
	 * @return the cjr_id
	 */
	public Integer getCjr_id() {
		return cjr_id;
	}

	/**
	 * @param cjr_id
	 *            the cjr_id to set
	 */
	public void setCjr_id(Integer cjr_id) {
		this.cjr_id = cjr_id;
	}
	
	/**
	 * @hibernate.property column="cjsj"
	 * @return the cjsj
	 */
	public Date getCjsj() {
		return cjsj;
	}

	/**
	 * @param cjsj
	 *            the cjsj to set
	 */
	public void setCjsj(Date cjsj) {
		this.cjsj = cjsj;
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
	 * @hibernate.property column="gxbz"
	 * @return the gxbz
	 */
	public Integer getGxbz() {
		return gxbz;
	}

	/**
	 * @param gxbz
	 *            the gxbz to set
	 */
	public void setGxbz(Integer gxbz) {
		this.gxbz = gxbz;
	}
}
