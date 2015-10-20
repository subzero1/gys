package com.netsky.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;

import com.netsky.baseFormatUtils.NumberFormatUtil;
import com.netsky.baseObject.Calculator;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga05_fy;
import com.netsky.dataObject.Ga07_qfqj;
import com.netsky.dataObject.Ga08_flmx;
import com.netsky.dataObject.Ga14_b3jcfl;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * @author Chiang
 * 
 * 费率费用相关服务实现
 */
public class ExpenseServiceImpl implements ExpenseService {

	private QueryService queryService;

	private SaveService saveService;

	/**
	 * @return the queryService
	 */
	public QueryService getQueryService() {
		return queryService;
	}

	/**
	 * @param queryService
	 *            the queryService to set
	 */
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	/**
	 * @return the saveService
	 */
	public SaveService getSaveService() {
		return saveService;
	}

	/**
	 * @param saveService
	 *            the saveService to set
	 */
	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	/**
	 * 获取费率表1,2,5值
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @param fy_id
	 *            ga05费用id
	 * @throws Exception
	 * @return String flz 返回费用相关费率
	 */
	public String getFlz(Integer dxgc_id, Integer fy_id) throws Exception {
		Gd02_dxgc gd02;
		String flz = "0";
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("id", dxgc_id);
		ResultObject ro = queryService.search(queryBuilder);
		if (ro.next()) {
			gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
		} else {
			throw new Exception("单项工程不存在 dxgc_id = " + dxgc_id);
		}
		/**
		 * 获取费率
		 */
		Ga05_fy ga05;
		Ga08_flmx ga08;
		String HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
				+ gd02.getFlk_id() + " and ga05.id = '" + fy_id + "'";
		ro = queryService.search(HSql);
		while (ro.next()) {
			ga05 = (Ga05_fy) ro.get("ga05");
			ga08 = (Ga08_flmx) ro.get("ga08");
			/**
			 * 初始化默认费率值
			 */
			flz = ga08.getFlz().toString();
			/**
			 * 更新专业相关费率
			 */
			if (ga08.getZy_id() != null && ga08.getQj_id() == null && ga08.getZclb() == null) {
				HSql = "select ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = " + gd02.getFlk_id()
						+ " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId();
				ResultObject ro2 = queryService.search(HSql);
				if (ro2.getLength() == 1) {
					/**
					 * 仅与专业相关
					 */
					ro2.next();
					ga08 = (Ga08_flmx) ro2.get("ga08");
					flz = ga08.getFlz().toString();
				}
			}
			/**
			 * 更新区间相关费率
			 * 
			 * 临时设施费用 单程施工队伍调遣费定额 施工队伍调遣费调遣人数 建设单位管理费 建设工程监理费
			 */
			if (ga05.getMc().equals("临时设施费用")) {
				/**
				 * 调遣里程对应区间费用,费率关联工程专业.
				 */
				Double dqjl = gd02.getB2_sgdqlc();
				if (dqjl == null)
					dqjl = new Double(0);
				HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
						+ ga05.getId()
						+ ") and "
						+ dqjl
						+ " > xx and ("
						+ dqjl
						+ " <= sx or sx is null)) and zy_id = "
						+ gd02.getZy_id()
						+ " and ga08.flk_id = " + gd02.getFlk_id();
				ResultObject ro2 = queryService.search(HSql);
				if (ro2.next()) {
					ga08 = (Ga08_flmx) ro2.get("ga08");
					flz = ga08.getFlz().toString();
				} else {
					/**
					 * 费率替换为0
					 */
					flz = "0";
				}

			} else if (ga05.getMc().equals("单程施工队伍调遣费定额")) {
				/**
				 * 获取调遣里程
				 */
				Double dqlc = new Double(0);
				if (gd02.getB2_sgdqlc() != null)
					dqlc = gd02.getB2_sgdqlc();
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " and ga07.sx is null" + " and ga08.flk_id = " + gd02.getFlk_id();
				ResultObject ro2 = queryService.search(HSql);
				ro2.next();
				if (dqlc.doubleValue() >= 0 && dqlc.doubleValue() <= ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
					/**
					 * 调遣里程在区间范围内
					 */
					if (dqlc.doubleValue() > 0)
						HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
								+ ga05.getId() + ") and " + dqlc + " > xx and " + dqlc + " <= sx)" + " and ga08.flk_id = " + gd02.getFlk_id();
					else
						HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
								+ ga05.getId() + ") and " + dqlc + " >= xx and " + dqlc + " <= sx)" + " and ga08.flk_id = " + gd02.getFlk_id();
					ro2 = queryService.search(HSql);
					if (ro2.next()) {
						ga08 = (Ga08_flmx) ro2.get("ga08");
						flz = ga08.getFlz().toString();
					}
				} else if (dqlc.doubleValue() > ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
					/**
					 * 调遣里程超过区间范围,计算每增加数量
					 */
					Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
					Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
					/**
					 * 计算增加调遣费
					 */
					String zjs = NumberFormatUtil.mulToString(NumberFormatUtil.subScal(NumberFormatUtil.divToString(NumberFormatUtil.subToString(dqlc
							.toString(), xx.toString()), mzj.toString())), ((Ga08_flmx) ro2.get("ga08")).getFlz().toString());
					HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
							+ ga05.getId() + ") and sx = " + xx + ")" + " and ga08.flk_id = " + gd02.getFlk_id();
					ro2 = queryService.search(HSql);
					ro2.next();
					flz = NumberFormatUtil.addToString(zjs, ((Ga08_flmx) ro2.get("ga08")).getFlz().toString());

				} else {
					/**
					 * 调遣里程<0,费率替换为0
					 */
					flz = "0";

				}
			} else if (ga05.getMc().equals("施工队伍调遣费调遣人数") || ga05.getMc().equals("建设工程监理费")) {
				/**
				 * 获取技工总工日或建筑安装工程费
				 */
				Double number = new Double(0);
				if (ga05.getMc().equals("施工队伍调遣费调遣人数")) {
					HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
							+ " and fymc = '技工总工日'";
				} else if (ga05.getMc().equals("建设工程监理费")) {
					HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
							+ " and fymc = '建筑安装工程费'";
				}
				ResultObject ro2 = queryService.search(HSql);
				if (ro2.next()) {
					number = (Double) ro2.get("fyz");
					if (number == null)
						number = new Double(0);
				}
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " and ga07.sx is null and ga08.zy_id = " + gd02.getZy_id() + " and ga08.flk_id = " + gd02.getFlk_id();
				ro2 = queryService.search(HSql);
				ro2.next();
				if (number.doubleValue() >= 0 && number.doubleValue() <= ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
					/**
					 * number在区间范围内
					 */
					if (number.doubleValue() > 0)
						HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
								+ ga05.getId()
								+ " and zy_id = "
								+ gd02.getZy_id()
								+ ") and "
								+ number
								+ " > xx and "
								+ number
								+ " <= sx) and ga08.zy_id = " + gd02.getZy_id() + " and ga08.flk_id = " + gd02.getFlk_id();
					else
						HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
								+ ga05.getId()
								+ " and zy_id = "
								+ gd02.getZy_id()
								+ ") and "
								+ number
								+ " >= xx and "
								+ number
								+ " <= sx) and ga08.zy_id = " + gd02.getZy_id() + " and ga08.flk_id = " + gd02.getFlk_id();
					ro2 = queryService.search(HSql);
					if (ro2.next()) {
						ga08 = (Ga08_flmx) ro2.get("ga08");
						flz = ga08.getFlz().toString();
					}
				} else if (number.doubleValue() > ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
					/**
					 * number超过区间范围,计算每增加数量
					 */
					Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
					Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
					String zjs = "0";
					if (mzj != null) {
						/**
						 * 计算增加调遣费
						 */
						zjs = NumberFormatUtil.mulToString(NumberFormatUtil.subScal(NumberFormatUtil.divToString(NumberFormatUtil.subToString(number
								.toString(), xx.toString()), mzj.toString())), ((Ga08_flmx) ro2.get("ga08")).getFlz().toString());
						HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
								+ ga05.getId() + "and zy_id="+ gd02.getZy_id() +") and sx = " + xx + ") and zy_id = " + gd02.getZy_id() + " and ga08.flk_id = " + gd02.getFlk_id();
						ro2 = queryService.search(HSql);
						ro2.next();
					}
					flz = NumberFormatUtil.addToString(zjs, ((Ga08_flmx) ro2.get("ga08")).getFlz().toString());

				} else {
					/**
					 * number<0,费率替换为0
					 */
					flz = "0";

				}
			} else if (ga05.getMc().equals("建设单位管理费")) {
				String number = "0";
				/**
				 * 获取工程总概算
				 * 
				 * 工程费+表5其他费
				 */
				HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
						+ " and fymc in ('工程总概算')";
				ResultObject ro2 = queryService.search(HSql);
				while (ro2.next()) {
					if ((Double) ro2.get("fyz") != null)
						number = NumberFormatUtil.addToString(number, ((Double) ro2.get("fyz")).toString());
				}
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " and ga07.sx is null" + " and ga08.flk_id = " + gd02.getFlk_id();
				ro2 = queryService.search(HSql);
				ro2.next();
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " order by ga07.xx asc" + " and ga08.flk_id = " + gd02.getFlk_id();
				ro2 = queryService.search(HSql);
				flz = "0";
				while (ro2.next()) {
					Ga07_qfqj ga07 = (Ga07_qfqj) ro2.get("ga07");
					ga08 = (Ga08_flmx) ro2.get("ga08");
					if (Double.parseDouble(number) > ga07.getXx().doubleValue()) {
						/**
						 * 总概算大于下限,费率需要计算
						 */
						if (ga07.getSx() != null && Double.parseDouble(number) > ga07.getSx().doubleValue()) {
							/**
							 * 总概算大于上限,使用上限-下限运算
							 */
							flz = NumberFormatUtil.addToString(flz, NumberFormatUtil.mulToString(NumberFormatUtil.subToString(
									ga07.getSx().toString(), ga07.getXx().toString()), NumberFormatUtil.divToString(ga08.getFlz().toString(), "100",
									4)));
						} else if (ga07.getSx() == null || Double.parseDouble(number) < ga07.getSx().doubleValue()) {
							/**
							 * 总概算小于上限,或者上限为空,使用概算-下限运算
							 */
							flz = NumberFormatUtil.addToString(flz, NumberFormatUtil.mulToString(NumberFormatUtil.subToString(number, ga07.getXx()
									.toString()), NumberFormatUtil.divToString(ga08.getFlz().toString(), "100", 4)));
						}
					} else {
						break;
					}
				}
			}
		}
		return flz;
	}

	/**
	 * 插入综合信息后的处理,将ga05中费率数据写入gd03
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd03(Gd02_dxgc gd02) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		Gd03_gcfysz gd03;
		Ga05_fy ga05 = null;
		Ga08_flmx ga08;
		try {
			/**
			 * 关联费率数据
			 */
			String HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
					+ gd02.getFlk_id() + " and ga05.bgbh != 'B4'";
			ResultObject ro = queryService.search(HSql);
			while (ro.next()) {
				ga05 = (Ga05_fy) ro.get("ga05");
				ga08 = (Ga08_flmx) ro.get("ga08");
				gd03 = new Gd03_gcfysz();
				/**
				 * 初始化gd03数据
				 */
				gd03.setGcxm_id(gd02.getGcxm_id());
				gd03.setDxgc_id(gd02.getId());
				gd03.setFy_id(ga05.getId());
				gd03.setFymc(ga05.getMc());
				if (ga05.getJsgs() != null) {
					gd03.setJsgs(ga05.getJsgs().replaceAll("\\[费率]", NumberFormatUtil.roundToString(ga08.getFlz())));
					if (ga05.getGsbds() != null) {
						gd03.setGsbds(ga05.getGsbds().replaceAll("\\[费率]", NumberFormatUtil.roundToString(ga08.getFlz())));
					}
				}
				gd03.setBgbh(ga05.getBgbh());
				gd03.setBz(ga05.getBz());
				gd03.setSxh(ga05.getSxh());
				gd03.setXgfy(ga05.getXgfy());
				gd03.setDyyl(new Integer(1));
				/**
				 * 更新专业相关费率
				 */
				if (ga08.getZy_id() != null) {
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
							+ gd02.getFlk_id() + " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId();
					ResultObject ro2 = queryService.search(HSql);
					if (ro2.getLength() == 1) {
						/**
						 * 仅与专业相关
						 */
						ro2.next();
						ga08 = (Ga08_flmx) ro2.get("ga08");
						if (ga05.getJsgs() != null) {
							gd03.setJsgs(ga05.getJsgs().replaceAll("\\[费率]", NumberFormatUtil.roundToString(ga08.getFlz())));
							if (ga05.getGsbds() != null) {
								gd03.setGsbds(ga05.getGsbds().replaceAll("\\[费率]", NumberFormatUtil.roundToString(ga08.getFlz())));
							}
						}
					}
				}
				session.saveOrUpdate(gd03);
			}
			/**
			 * 非关联费率合计费用
			 */
			HSql = "select ga05 from Ga05_fy ga05 where ga05.id not in (select fy_id from Ga08_flmx) and ga05.bgbh != 'B4'";
			ro = queryService.search(HSql);
			while (ro.next()) {
				ga05 = (Ga05_fy) ro.get("ga05");
				gd03 = new Gd03_gcfysz();
				/**
				 * 初始化gd03数据
				 */
				gd03.setGcxm_id(gd02.getGcxm_id());
				gd03.setDxgc_id(gd02.getId());
				gd03.setFy_id(ga05.getId());
				gd03.setFymc(ga05.getMc());
				gd03.setJsgs(ga05.getJsgs());
				gd03.setGsbds(ga05.getGsbds());
				gd03.setBgbh(ga05.getBgbh());
				gd03.setBz(ga05.getBz());
				gd03.setSxh(ga05.getSxh());
				gd03.setXgfy(ga05.getXgfy());
				session.saveOrUpdate(gd03);
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 插入gd03数据出错! at expenseService.insertGd03" + ga05.getMc());
		} finally {
			session.close();
		}
	}

	/**
	 * 插入数据后续操作,将ga14数据写入gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {

			/**
			 * 高原地区人工调整系数,森林及沙漠地区
			 */
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
			queryBuilder.eq("flk_id", gd02.getFlk_id());
			queryBuilder.eq("fylb", new Integer(1));
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Ga14_b3jcfl ga14 = (Ga14_b3jcfl) ro.get(Ga14_b3jcfl.class.getName());
				Gd10_b3fl gd10 = new Gd10_b3fl();
				gd10.setBz(ga14.getBz());
				gd10.setDxgc_id(gd02.getId());
				gd10.setGcxm_id(gd02.getGcxm_id());
				gd10.setRgfl(ga14.getRgfl());
				gd10.setJxfl(ga14.getJxfl());
				gd10.setFylb(ga14.getFylb());
				gd10.setMc(ga14.getMc());
				if (request.getParameter("B3_GYDQ_BZ") != null && request.getParameter("B3_GYDQ_BZ").equals(ga14.getId().toString())) {
					gd10.setFlag(new Integer(1));
				}
				if (request.getParameter("B3_SLSM_BZ") != null && request.getParameter("B3_SLSM_BZ").equals(ga14.getId().toString())) {
					gd10.setFlag(new Integer(1));
				}
				session.saveOrUpdate(gd10);
			}
			/**
			 * 小工日调增
			 */
			queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
			queryBuilder.eq("flk_id", gd02.getFlk_id());
			queryBuilder.eq("fylb", new Integer(3));
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Ga14_b3jcfl ga14 = (Ga14_b3jcfl) ro.get(Ga14_b3jcfl.class.getName());
				Gd10_b3fl gd10 = new Gd10_b3fl();
				gd10.setBz(ga14.getBz());
				gd10.setDxgc_id(gd02.getId());
				gd10.setGcxm_id(gd02.getGcxm_id());
				gd10.setRgfl(ga14.getRgfl());
				gd10.setJxfl(ga14.getJxfl());
				gd10.setFylb(ga14.getFylb());
				gd10.setMc(ga14.getMc());
				session.saveOrUpdate(gd10);
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 插入gd10数据出错! at expenseService.insertGd10");
		} finally {
			session.close();
		}
	}
	
	/**
	 * 插入数据后续操作,将ga14数据写入gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd10Hessian(Gd02_dxgc gd02) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {

			/**
			 * 高原地区人工调整系数,森林及沙漠地区
			 */
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
			queryBuilder.eq("flk_id", gd02.getFlk_id());
			queryBuilder.eq("fylb", new Integer(1));
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Ga14_b3jcfl ga14 = (Ga14_b3jcfl) ro.get(Ga14_b3jcfl.class.getName());
				Gd10_b3fl gd10 = new Gd10_b3fl();
				gd10.setBz(ga14.getBz());
				gd10.setDxgc_id(gd02.getId());
				gd10.setGcxm_id(gd02.getGcxm_id());
				gd10.setRgfl(ga14.getRgfl());
				gd10.setJxfl(ga14.getJxfl());
				gd10.setFylb(ga14.getFylb());
				gd10.setMc(ga14.getMc());
				session.saveOrUpdate(gd10);
			}
			/**
			 * 小工日调增
			 */
			queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
			queryBuilder.eq("flk_id", gd02.getFlk_id());
			queryBuilder.eq("fylb", new Integer(3));
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Ga14_b3jcfl ga14 = (Ga14_b3jcfl) ro.get(Ga14_b3jcfl.class.getName());
				Gd10_b3fl gd10 = new Gd10_b3fl();
				gd10.setBz(ga14.getBz());
				gd10.setDxgc_id(gd02.getId());
				gd10.setGcxm_id(gd02.getGcxm_id());
				gd10.setRgfl(ga14.getRgfl());
				gd10.setJxfl(ga14.getJxfl());
				gd10.setFylb(ga14.getFylb());
				gd10.setMc(ga14.getMc());
				session.saveOrUpdate(gd10);
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 插入gd10数据出错! at expenseService.insertGd10");
		} finally {
			session.close();
		}
	
		
	}

	/**
	 * 更新数据后续操作,更新gd10
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void updateGd10(Gd02_dxgc gd02, HttpServletRequest request) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {

			/**
			 * 高原地区人工调整系数,森林及沙漠地区
			 */
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			queryBuilder.eq("gcxm_id", gd02.getGcxm_id());
			queryBuilder.eq("fylb", new Integer(1));
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd10_b3fl gd10 = (Gd10_b3fl) ro.get(Gd10_b3fl.class.getName());
				/**
				 * 设置高原地区选择
				 */
				if (gd10.getBz().intValue() == 1 && request.getParameter("B3_GYDQ_BZ") != null
						&& request.getParameter("B3_GYDQ_BZ").equals(gd10.getId().toString())) {
					gd10.setFlag(new Integer(1));
				} else if (gd10.getBz().intValue() == 1) {
					gd10.setFlag(new Integer(0));
				}
				/**
				 * 设置森林及沙漠地区
				 */
				if (gd10.getBz().intValue() == 2 && request.getParameter("B3_SLSM_BZ") != null
						&& request.getParameter("B3_SLSM_BZ").equals(gd10.getId().toString())) {
					gd10.setFlag(new Integer(1));
				} else if (gd10.getBz().intValue() == 2) {
					gd10.setFlag(new Integer(0));
				}
				session.saveOrUpdate(gd10);
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 更新gd10数据出错! at expenseService.updateGd10");
		} finally {
			session.close();
		}
	}

	/**
	 * 重新获取单表费率
	 * 
	 * @param gd02
	 * @param bgbh
	 *            表格编号
	 * @throws Exception
	 */
	public void reBuildFy(Gd02_dxgc gd02, String bgbh, HttpServletRequest request) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {
			if (bgbh.equals("B3J")) {
				/**
				 * 重新获取表3甲费率
				 */

				/**
				 * 删除原信息
				 */
				String HSql = "delete Gd10_b3fl where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId() + " and fylb= "
						+ new Integer(3);
				Query query = session.createQuery(HSql);
				query.executeUpdate();
				/**
				 * 重新写入,默认均不选中
				 */
				QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga14_b3jcfl.class);
				queryBuilder.eq("flk_id", gd02.getFlk_id());
				queryBuilder.eq("fylb", new Integer(3));
				ResultObject ro = queryService.search(queryBuilder);
				while (ro.next()) {
					Ga14_b3jcfl ga14 = (Ga14_b3jcfl) ro.get(Ga14_b3jcfl.class.getName());
					Gd10_b3fl gd10 = new Gd10_b3fl();
					gd10.setBz(ga14.getBz());
					gd10.setDxgc_id(gd02.getId());
					gd10.setGcxm_id(gd02.getGcxm_id());
					gd10.setRgfl(ga14.getRgfl());
					gd10.setJxfl(ga14.getJxfl());
					gd10.setFylb(ga14.getFylb());
					gd10.setMc(ga14.getMc());
					session.saveOrUpdate(gd10);
				}

				QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd10_b3fl.class);
				queryBuilder9.eq("gcxm_id", gd02.getGcxm_id());
				queryBuilder9.eq("dxgc_id", gd02.getId());
				queryBuilder9.eq("fylb", new Integer(1));
				ResultObject ro9 = queryService.search(queryBuilder9);
				Gd10_b3fl b3fl = new Gd10_b3fl();
				while (ro9.next()) {
					b3fl = (Gd10_b3fl) ro9.get(Gd10_b3fl.class.getName());
					QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Ga14_b3jcfl.class);
					queryBuilder99.eq("flk_id", gd02.getFlk_id());
					queryBuilder99.eq("fylb", new Integer(1));
					queryBuilder99.eq("mc", b3fl.getMc());
					ResultObject ro99 = queryService.search(queryBuilder99);
					Ga14_b3jcfl b3jcfl = new Ga14_b3jcfl();
					if (ro99.next()) {
						b3jcfl = (Ga14_b3jcfl) ro99.get(Ga14_b3jcfl.class.getName());
					}
					if (b3jcfl.getId() != null) {
						b3fl.setRgfl(b3jcfl.getRgfl());
					}
					session.saveOrUpdate(b3fl);
				}

			} else if (bgbh.equals("B3Y")) {
				/**
				 * 重取表三乙费率
				 */
				QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd10_b3fl.class);
				queryBuilder.eq("gcxm_id", gd02.getGcxm_id());
				queryBuilder.eq("dxgc_id", gd02.getId());
				queryBuilder.eq("fylb", new Integer(1));
				ResultObject ro = queryService.search(queryBuilder);
				Gd10_b3fl b3fl = new Gd10_b3fl();
				while (ro.next()) {
					b3fl = (Gd10_b3fl) ro.get(Gd10_b3fl.class.getName());
					QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Ga14_b3jcfl.class);
					queryBuilder9.eq("flk_id", gd02.getFlk_id());
					queryBuilder9.eq("fylb", new Integer(1));
					queryBuilder9.eq("mc", b3fl.getMc());
					ResultObject ro9 = queryService.search(queryBuilder9);
					Ga14_b3jcfl b3jcfl = new Ga14_b3jcfl();
					if (ro9.next()) {
						b3jcfl = (Ga14_b3jcfl) ro9.get(Ga14_b3jcfl.class.getName());
					}
					if (b3jcfl.getId() != null) {
						b3fl.setJxfl(b3jcfl.getJxfl());
					}
					session.saveOrUpdate(b3fl);
				}

			} else if (bgbh.equals("B4")) {
				/**
				 * 重新获取表4费率,保留运距,原信息不删除
				 */

				/**
				 * 获取原gd04费率相关费用
				 */
				String HSql = "select gd04 from Gd04_clfysz gd04 where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
						+ " and fymc in (select ga05.mc from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = "
						+ gd02.getFlk_id() + ")";
				ResultObject ro = queryService.search(HSql);
				while (ro.next()) {
					Gd04_clfysz gd04 = (Gd04_clfysz) ro.get("gd04");
					/**
					 * 更新只与材料类别或设备类别相关费率
					 */
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 "
							+ " where ga05.bgbh = 'B4' and ga05.id = ga08.fy_id and ga08.zy_id is null and ga05.mc = '" + gd04.getFymc()
							+ "' and ga08.zclb = '" + gd04.getZclb() + "' and ga08.flk_id = " + gd02.getFlk_id() + " and ga08.qj_id is null";
					ResultObject ro2 = queryService.search(HSql);
					if (ro2.next()) {
						/**
						 * 与主材类别关联,不与专业关联费用
						 */
						Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
						Ga08_flmx ga08 = (Ga08_flmx) ro2.get("ga08");
						gd04.setFlz(ga08.getFlz());
						gd04.setFy_id(ga05.getId());
					}
					/**
					 * 更新与材料类别,设备类别相和工程专业相关关费率
					 */
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 " + " where ga05.bgbh = 'B4' and ga05.id = ga08.fy_id and ga05.mc = '"
							+ gd04.getFymc() + "' and ga08.zclb = '" + gd04.getZclb() + "' and ga08.flk_id = " + gd02.getFlk_id()
							+ " and ga08.zy_id = " + gd02.getZy_id() + " and ga08.qj_id is null";
					ro2 = queryService.search(HSql);
					if (ro2.next()) {
						/**
						 * 与主材类别关联,不与专业关联费用
						 */
						Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
						Ga08_flmx ga08 = (Ga08_flmx) ro2.get("ga08");
						gd04.setFlz(ga08.getFlz());
						gd04.setFy_id(ga05.getId());
					}
					/**
					 * 更新区间相关费率
					 * 
					 * 运杂费
					 */
					if (gd04.getFymc().equals("运杂费")) {
						if (gd04.getFlyj() == null || gd04.getFlyj().doubleValue() <= 0) {
							/**
							 * 运距为空或<=0,更新为默认值,默认值为第一区间
							 */
							HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga05.mc = '" + gd04.getFymc()
									+ "' and ga08.gcflbz = 1 and ga08.flk_id = " + gd02.getFlk_id();
							ro2 = queryService.search(HSql);
							if (ro2.next()) {
								Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
								Ga08_flmx ga08 = (Ga08_flmx) ro2.get("ga08");
								gd04.setFlz(ga08.getFlz());
								gd04.setFy_id(ga05.getId());
							}
						} else {
							HSql = "select ga08,ga07,ga05 from Ga08_flmx ga08,Ga07_qfqj ga07,Ga05_fy ga05 where ga08.qj_id = ga07.id and ga08.fy_id = ga05.id and ga05.mc = '"
									+ gd04.getFymc()
									+ "' and ga07.sx is null and ga08.flk_id = "
									+ gd02.getFlk_id()
									+ " and ga08.zclb = '"
									+ gd04.getZclb() + "'" + " and ga08.flk_id = " + gd02.getFlk_id();
							ro2 = queryService.search(HSql);
							ro2.next();
							Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
							if (gd04.getFlyj().doubleValue() <= ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
								/**
								 * 运距在区间范围内
								 */
								HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
										+ ga05.getId()
										+ ") and "
										+ gd04.getFlyj()
										+ " > xx and "
										+ gd04.getFlyj()
										+ " <= sx) and ga08.zclb = '"
										+ gd04.getZclb() + "'" + " and ga08.flk_id = " + gd02.getFlk_id();
								ro2 = queryService.search(HSql);
								if (ro2.next()) {
									gd04.setFlz(((Ga08_flmx) ro2.get("ga08")).getFlz());
								}
							} else if (gd04.getFlyj().doubleValue() > ((Ga07_qfqj) ro2.get("ga07")).getXx().doubleValue()) {
								/**
								 * 运距超过区间范围,计算每增加数量
								 */
								Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
								Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
								/**
								 * 计算增加费率
								 */
								String zjs = NumberFormatUtil.mulToString(NumberFormatUtil.subScal(NumberFormatUtil.divToString(NumberFormatUtil
										.subToString(gd04.getFlyj().toString(), xx.toString()), mzj.toString())), ((Ga08_flmx) ro2.get("ga08"))
										.getFlz().toString());
								HSql = "select ga08 from Ga08_flmx ga08 where qj_id =(select id from Ga07_qfqj ga07 where id in (select qj_id from Ga08_flmx where fy_id = "
										+ ga05.getId()
										+ ") and sx = "
										+ xx
										+ ") and ga08.zclb = '"
										+ gd04.getZclb()
										+ "'"
										+ " and ga08.flk_id = "
										+ gd02.getFlk_id();
								;
								ro2 = queryService.search(HSql);
								ro2.next();
								String flz = NumberFormatUtil.addToString(zjs, ((Ga08_flmx) ro2.get("ga08")).getFlz().toString());
								gd04.setFlz(Double.valueOf(flz));
							}
						}
					}
					session.saveOrUpdate(gd04);
				}
			} else if (bgbh.equals("B1") || bgbh.equals("B2") || bgbh.equals("B5")) {
				/**
				 * 重新获取表1,表2或表5费用
				 */

				/**
				 * 获取原与费率相关信息
				 */
				String HSql = "select gd03,ga05 from Gd03_gcfysz gd03,Ga05_fy ga05 where gd03.fy_id in (select ga05.id from Ga05_fy ga05,Ga08_flmx ga08 where ga05.bgbh like '%"
						+ bgbh + "%' and ga05.id = ga08.fy_id) and gd03.fy_id = ga05.id and gd03.dxgc_id = " + gd02.getId() + " order by ga05.id asc";
				ResultObject ro = new ResultObject(session.createQuery(HSql).list(), HSql);
				// ResultObject ro = queryService.search(HSql);
				List resultList = new ArrayList();
				while (ro.next()) {
					Gd03_gcfysz gd03 = (Gd03_gcfysz) ro.get("gd03");
					Ga05_fy ga05 = (Ga05_fy) ro.get("ga05");
					if (ga05.getJsgs() != null) {
						String flz = this.getFlz(gd02.getId(), gd03.getFy_id());
						gd03.setJsgs(ga05.getJsgs().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
						if (ga05.getGsbds() != null)
							gd03.setGsbds(ga05.getGsbds().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
					}
					resultList.add(gd03);
				}

				for (int i = 0; i < resultList.size(); i++) {
					session.saveOrUpdate(resultList.get(i));
				}

			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 重新获取" + bgbh + "费率出错! at expenseService.reBuildFy");
		} finally {
			session.close();
		}

	}

	/**
	 * 新建综合信息时写入gd04信息。
	 * 
	 * @param gd02
	 * @throws Exception
	 */
	public void insertGd04(Gd02_dxgc gd02) throws Exception {
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {
			Gd04_clfysz gd04;
			Ga05_fy ga05;
			Ga08_flmx ga08;
			Gb03_bgxx gb03;
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gb03_bgxx.class);
			queryBuilder.like("bgbh", "B4J", MatchMode.ANYWHERE);
			ResultObject resultObject = queryService.search(queryBuilder);
			while (resultObject.next()) {
				gb03 = (Gb03_bgxx) resultObject.get(Gb03_bgxx.class.getName());
				/**
				 * 关联费率数据
				 */
				String HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
						+ gd02.getFlk_id() + " and ga05.bgbh = 'B4' and ga08.zclb in (select zclb from Ga00_zclb where lb = '" + gb03.getB4lb()
						+ "')";
				ResultObject ro = queryService.search(HSql);
				while (ro.next()) {
					ga05 = (Ga05_fy) ro.get("ga05");
					ga08 = (Ga08_flmx) ro.get("ga08");
					gd04 = new Gd04_clfysz();
					/**
					 * 初始化gd04数据
					 */
					gd04.setGcxm_id(gd02.getGcxm_id());
					gd04.setDxgc_id(gd02.getId());
					gd04.setFy_id(ga05.getId());
					gd04.setFymc(ga05.getMc());
					gd04.setFlz(ga08.getFlz());
					gd04.setZclb(ga08.getZclb());
					gd04.setBgbh(gb03.getBgbh());
					/**
					 * 更新专业,材料相关费率
					 */
					if (ga08.getZy_id() != null) {
						HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = " + gd02.getFlk_id()
								+ " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId() + " and ga08.zclb = '" + ga08.getZclb()
								+ "'";
						ResultObject ro2 = queryService.search(HSql);
						if (ro2.getLength() == 1) {
							/**
							 * 仅与专业,材料相关
							 */
							ro2.next();
							ga08 = (Ga08_flmx) ro2.get("ga08");
							if (ga05.getJsgs() != null) {
								gd04.setFlz(ga08.getFlz());
							}
						}
					}
					session.saveOrUpdate(gd04);
				}
				/**
				 * 非关联费率合计费用
				 */
				HSql = "select ga05 from Ga05_fy ga05 where ga05.id not in (select fy_id from Ga08_flmx) and ga05.bgbh = 'B4'";
				ro = queryService.search(HSql);
				while (ro.next()) {
					ga05 = (Ga05_fy) ro.get("ga05");
					gd04 = new Gd04_clfysz();
					/**
					 * 初始化gd04数据
					 */
					gd04.setGcxm_id(gd02.getGcxm_id());
					gd04.setDxgc_id(gd02.getId());
					gd04.setFy_id(ga05.getId());
					gd04.setFymc(ga05.getMc());
					gd04.setBgbh(gb03.getBgbh());
					session.saveOrUpdate(gd04);
				}
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 插入gd04数据出错! at expenseService.insertGd04");
		} finally {
			session.close();
		}
	}

	public void rebuildZyfl(Gd02_dxgc gd02) throws Exception {
		String HSql = "select ga05 from Ga05_fy ga05 where ga05.id in (select distinct fy_id from Ga08_flmx where zy_id is not null)";
		/**
		 * 获取所有专业相关费用
		 */
		ResultObject ro = queryService.search(HSql);
		while (ro.next()) {
			Ga05_fy ga05 = (Ga05_fy) ro.get("ga05");
			if (ga05.getBgbh().equals("B4")) {
				/**
				 * 表4费用,更新gd04
				 */
				HSql = "from Gd04_clfysz gd04 where gd04.fy_id = " + ga05.getId() + " and gd04.dxgc_id = " + gd02.getId();
				ResultObject ro2 = queryService.search(HSql);
				while (ro2.next()) {
					Gd04_clfysz gd04 = (Gd04_clfysz) ro2.get("gd04");
					HSql = "from Ga08_flmx ga08 where ga08.fy_id = " + ga05.getId() + " and flk_id = " + gd02.getFlk_id() + " and zy_id = "
							+ gd02.getZy_id() + " and ga08.zclb = '" + gd04.getZclb() + "'";
					ResultObject ro3 = queryService.search(HSql);
					if (ro3.getLength() == 1) {
						/**
						 * 只与专业主材类别关联的费用
						 */
						ro3.next();
						Ga08_flmx ga08 = (Ga08_flmx) ro3.get("ga08");
						gd04.setFlz(ga08.getFlz());
						saveService.save(gd04);
					}
				}
			} else {
				/**
				 * 其他费用,更新gd03公式
				 */
				HSql = "from Gd03_gcfysz gd03 where dxgc_id = " + gd02.getId() + " and fy_id = " + ga05.getId();
				ResultObject ro2 = queryService.search(HSql);
				while (ro2.next()) {
					Gd03_gcfysz gd03 = (Gd03_gcfysz) ro2.get("gd03");
					String flz = this.getFlz(gd02.getId(), ga05.getId());
					gd03.setJsgs(ga05.getJsgs().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
					gd03.setGsbds(ga05.getGsbds().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
					saveService.save(gd03);
				}
			}
		}

	}

	/**
	 * 删除表格时处理相关费用,从公式中删除此费用,增加表格信息时重新给公式添加费用,gb03中存储需要此处理的费用
	 * 
	 * @param gd02
	 * @param bgxx_id
	 *            gb03_id 需要操作的表格
	 * @param oper_flag
	 *            "delete" or "add"
	 * @throws Exception
	 */
	public void updateJsgc(Gd02_dxgc gd02, Integer bgxx_id, String oper_flag) throws Exception {
		QueryBuilder queryBuilder;
		ResultObject ro;
		/**
		 * 获取表格相关费用
		 */
		Gb03_bgxx gb03 = (Gb03_bgxx) queryService.searchById(Gb03_bgxx.class, bgxx_id);
		if (gb03 == null) {
			throw new Exception("错误的表格id");
		}
		if (gb03.getXgfy() == null || gb03.getXgfy().equals("")) {
			return;
		}
		String xgfy[] = gb03.getXgfy().split(",");
		if (oper_flag.equals("add")) {
			/**
			 * 增加表格时重新获取与gb03中记录费用相关费用计算公式
			 */
			for (int i = 0; i < xgfy.length; i++) {
				queryBuilder = new HibernateQueryBuilder(Ga05_fy.class);
				queryBuilder.like("jsgs", "[" + xgfy[i] + "]", MatchMode.ANYWHERE);
				ro = queryService.search(queryBuilder);
				while (ro.next()) {
					Ga05_fy ga05 = (Ga05_fy) ro.get(Ga05_fy.class.getName());
					String flz = this.getFlz(gd02.getId(), ga05.getId());
					queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
					queryBuilder.eq("fy_id", ga05.getId());
					queryBuilder.eq("dxgc_id", gd02.getId());
					ResultObject ro2 = queryService.search(queryBuilder);
					if (ro2.next()) {
						Gd03_gcfysz gd03 = (Gd03_gcfysz) ro2.get(Gd03_gcfysz.class.getName());
						gd03.setJsgs(ga05.getJsgs().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
						gd03.setGsbds(ga05.getGsbds().replaceAll("\\[费率]", NumberFormatUtil.roundToString(flz)));
						saveService.save(gd03);
					}
				}
			}
		} else if (oper_flag.equals("delete")) {
			/**
			 * 删除表格时更新gd03中与gb03相关费用有关的公式
			 */
			for (int i = 0; i < xgfy.length; i++) {
				queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
				queryBuilder.eq("dxgc_id", gd02.getId());
				queryBuilder.like("jsgs", "[" + xgfy[i] + "]", MatchMode.ANYWHERE);
				ro = queryService.search(queryBuilder);
				while (ro.next()) {
					Gd03_gcfysz gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
					gd03.setJsgs(Calculator.deleteFy(gd03.getJsgs(), "[" + xgfy[i] + "]"));
					gd03.setGsbds(Calculator.deleteFy(gd03.getJsgs(), xgfy[i]));
					saveService.save(gd03);
				}
			}
		}
	}

	
}
