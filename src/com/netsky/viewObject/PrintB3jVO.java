package com.netsky.viewObject;
/**
 * 打印表三甲时需要用到的VO 
 * @author CT
 * @create 2009-05-27
 */
public class PrintB3jVO {
	/**
	 * 序号
	 */
	private Integer xh;
	/**
	 * 定额编号
	 */
	private String debh;
	/**
	 * 定额名称
	 */
	private String demc;
	/**
	 * 单位
	 */
	private String dw;
	/**
	 * 数量
	 */
	private Double sl;
	/**
	 * 技工工日
	 */
	private Double jggr;
	/**
	 * 普工工日
	 */
	private Double pggr;
	/**
	 * 技工合计
	 */
	private String jghj;
	/**
	 * 普工合计
	 */
	private String pghj;
	
	public String getDebh() {
		return debh;
	}
	public void setDebh(String debh) {
		this.debh = debh;
	}
	public String getDemc() {
		return demc;
	}
	public void setDemc(String demc) {
		this.demc = demc;
	}
	public String getDw() {
		return dw;
	}
	public void setDw(String dw) {
		this.dw = dw;
	}
	public Double getJggr() {
		return jggr;
	}
	public void setJggr(Double jggr) {
		this.jggr = jggr;
	}

	public Double getPggr() {
		return pggr;
	}
	public void setPggr(Double pggr) {
		this.pggr = pggr;
	}

	public String getJghj() {
		return jghj;
	}
	public void setJghj(String jghj) {
		this.jghj = jghj;
	}
	public String getPghj() {
		return pghj;
	}
	public void setPghj(String pghj) {
		this.pghj = pghj;
	}
	public Double getSl() {
		return sl;
	}
	public void setSl(Double sl) {
		this.sl = sl;
	}
	public Integer getXh() {
		return xh;
	}
	public void setXh(Integer xh) {
		this.xh = xh;
	}

	
}
