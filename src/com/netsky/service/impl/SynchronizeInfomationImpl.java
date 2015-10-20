package com.netsky.service.impl;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
import com.netsky.service.SynchronizeInfomation;

/**
 * 同步表1-表5设置信息service实现类
 * 
 * @author Chiang 2009-10-19
 */
public class SynchronizeInfomationImpl implements SynchronizeInfomation {

	private QueryService queryService;

	private SaveService saveService;

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public SaveService getSaveService() {
		return saveService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	/**
	 * 同步表1设置信息,更新相关费用计算公式，不重新计算费用值
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB1(Integer dxgc_id) throws Exception {
		String HSql = "";
		QueryBuilder queryBuilder;
		ResultObject ro;
		Gd03_gcfysz gd03;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			 * 更新gd02中表1相关设置字段
			 */
			HSql = "update Gd02_dxgc set b1_qzbz = " + gd02.getB1_qzbz() + ",b1_tzxs = " + gd02.getB1_tzxs() + ",b1_ybf_bz = " + gd02.getB1_ybf_bz()
					+ " where gcxm_id = " + gd02.getGcxm_id() + " and id != " + gd02.getId();
			session.createQuery(HSql).executeUpdate();
			/**
			 * 更新相关费用计算公式:预备费,建设期利息
			 */
			queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			queryBuilder.in("fymc", new String[] { "预备费", "建设期利息" });
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
				HSql = "update Gd03_gcfysz set jsgs = '" + gd03.getJsgs() + "',gsbds = '" + gd03.getGsbds() + "' where gcxm_id = "
						+ gd02.getGcxm_id() + " and fymc = '" + gd03.getFymc() + "' and dxgc_id != " + gd02.getId();
				session.createQuery(HSql).executeUpdate();
			}

			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + "同步表1设置信息出错! " + HSql);
		} finally {
			session.close();
		}
	}

	/**
	 * 同步表2设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB2(Integer dxgc_id) throws Exception {
		String HSql;
		QueryBuilder queryBuilder;
		ResultObject ro;
		Gd03_gcfysz gd03;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			 * 更新gd02中表2相关设置字段
			 */
			HSql = "update Gd02_dxgc set b2_bgbbl = " + gd02.getB2_bgbbl() + ",b2_jxdqdw = " + gd02.getB2_jxdqdw() + ",b2_jxdqf_wfbz = "
					+ gd02.getB2_jxdqf_wfbz() + ",b2_jxdqlc = " + gd02.getB2_jxdqlc() + ",b2_sgdqf_wfbz = " + gd02.getB2_sgdqf_wfbz()
					+ ",b2_sgdqlc = " + gd02.getB2_sgdqlc() + ",b2_tzxs = " + gd02.getB2_tzxs() + ",sj_bgbbl = " + gd02.getSj_bgbbl()
					+ " where gcxm_id = " + gd02.getGcxm_id() + " and id != " + gd02.getId();
			session.createQuery(HSql).executeUpdate();
			/**
			 * 更新相关费用计算公式:施工队伍调遣费,大型机械调遣费,税金
			 */
			queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			queryBuilder.in("fymc", new String[] { "施工队伍调遣费", "大型机械调遣费", "税金" });
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
				HSql = "update Gd03_gcfysz set jsgs = '" + gd03.getJsgs() + "',gsbds = '" + gd03.getGsbds() + "' where gcxm_id = "
						+ gd02.getGcxm_id() + " and fymc = '" + gd03.getFymc() + "' and dxgc_id != " + gd02.getId();
				session.createQuery(HSql).executeUpdate();
			}

			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 同步表2设置信息出错! ");
		} finally {
			session.close();
		}
	}

	/**
	 * 同步表3甲设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB3j(Integer dxgc_id) throws Exception {
		String HSql;
		QueryBuilder queryBuilder;
		ResultObject ro;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			 * 更新gd02中表3甲相关设置字段
			 */
			HSql = "update Gd02_dxgc set xgr_bz = " + gd02.getXgr_bz() + ",b4_zcjg = '" + gd02.getB4_zcjg() + "',b4_sbjg = " + gd02.getB4_sbjg()
					+ ",b3_jxjg = '" + gd02.getB3_jxjg() + "',b3_ybjg = " + gd02.getB3_ybjg() + ",b3_sgtj_bz = " + gd02.getB3_sgtj_bz()
					+ " where gcxm_id = " + gd02.getGcxm_id() + " and id != " + gd02.getId();
			session.createQuery(HSql).executeUpdate();

			/**
			 * 更新gd10中表3甲相关设置字段
			 */
			Gd10_b3fl gd10 = new Gd10_b3fl();// 100工日以下小工日
			queryBuilder = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				gd10 = (Gd10_b3fl) ro.get(Gd10_b3fl.class.getName());
				HSql = "update Gd10_b3fl set rgfl = " + gd10.getRgfl() + ",jxfl = " + gd10.getJxfl() + ",flag = " + gd10.getFlag()
						+ " where gcxm_id = " + gd02.getGcxm_id() + " and fylb = " + gd10.getFylb() + " and bz = " + gd10.getBz() + " and mc = '"
						+ gd10.getMc() + "' and dxgc_id != " + gd02.getId();
				session.createQuery(HSql).executeUpdate();
			}
			/**
			 * 更新相关费用公式
			 */
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 同步表3甲设置信息出错! ");
		} finally {
			session.close();
		}
	}

	/**
	 * 同步表3乙丙设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB3yb(Integer dxgc_id) throws Exception {
		String HSql;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			 * 更新gd02中表3乙丙相关设置字段
			 */
			HSql = "update Gd02_dxgc set b3_jxf_tzxs = '" + gd02.getB3_jxf_tzxs() + "',b3_jxjg = '" + gd02.getB3_jxjg() + "' where gcxm_id = "
					+ gd02.getGcxm_id() + " and id != " + gd02.getId();
			session.createQuery(HSql).executeUpdate();
			/**
			 * 更新相关费用公式
			 */
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 同步表3乙丙设置信息出错! ");
		} finally {
			session.close();
		}
	}

	/**
	 * 同步表4设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @param bgbh
	 *            表格编号
	 * @throws Exception
	 */
	public void SynchronizeB4(Integer dxgc_id, String bgbh) throws Exception {
		String HSql;
		QueryBuilder queryBuilder;
		ResultObject ro;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			if (!bgbh.equals("JZGCB")) {
				/**
				 * 更新gd02中表4相关设置字段
				 */
				HSql = "update Gd02_dxgc set b4_sbjg = " + gd02.getB4_sbjg() + ",b4_zcjg = '" + gd02.getB4_zcjg() + "' where gcxm_id = "
						+ gd02.getGcxm_id() + " and id != " + gd02.getId();
				session.createQuery(HSql).executeUpdate();

			}

			/**
			 * 更新gd04中表3甲相关设置字段
			 */
			Gd04_clfysz gd04 = new Gd04_clfysz();// 100工日以下小工日
			queryBuilder = new HibernateQueryBuilder(Gd04_clfysz.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			queryBuilder.eq("bgbh", bgbh);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				gd04 = (Gd04_clfysz) ro.get(Gd04_clfysz.class.getName());
				HSql = "update Gd04_clfysz set flyj = " + gd04.getFlyj() + ",flz = " + gd04.getFlz() + " where gcxm_id = " + gd02.getGcxm_id()
						+ " and dxgc_id != " + gd02.getId() + " and zclb = '" + gd04.getZclb() + "' and fy_id = " + gd04.getFy_id() + " and bgbh = '"
						+ gd04.getBgbh() + "'";
				session.createQuery(HSql).executeUpdate();
			}
			/**
			 * 更新相关费用公式
			 */
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 同步表4设置信息出错! ");
		} finally {
			session.close();
		}
	}

	/**
	 * 同步表5设置信息,并处理数据计算
	 * 
	 * @param dxgc_id
	 *            单项工程id
	 * @throws Exception
	 */
	public void SynchronizeB5(Integer dxgc_id) throws Exception {
		String HSql;
		String HSql1;
		ResultObject ro;
		Gd02_dxgc gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
		if (gd02 == null)
			throw new Exception("未找到单项工程!");
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
			 * 更新gd02中表5相关设置字段
			 */
			HSql = "update Gd02_dxgc set B5_SCZBF_SJDY = " + gd02.getB5_sczbf_sjdy() + " where gcxm_id = "
					+ gd02.getGcxm_id() + " and id != " + gd02.getId();
			session.createQuery(HSql).executeUpdate();
			/**
			 * 更新相关费用公式
			 */
	        String HSql2="select gd03 from Gd03_gcfysz gd03 where gcxm_id="+gd02.getGcxm_id()+" and dxgc_id="+gd02.getId()+" and FY_ID in(92,71,86,87)";
	        ro = queryService.search(HSql2);
			Gd03_gcfysz gd03 = new Gd03_gcfysz();
			while (ro.next()) {
				gd03 = (Gd03_gcfysz) ro.get("gd03");
				HSql1 = "update Gd03_gcfysz set GSBDS ='" +gd03.getGsbds()+"',JSGS='"+gd03.getJsgs()+"' where gcxm_id = "
		        + gd02.getGcxm_id() + " and dxgc_id != " + gd02.getId()+" and FY_ID="+gd03.getFy_id();
				session.createQuery(HSql1).executeUpdate();
			}
			
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 同步表5设置信息出错! ");
		} finally {
			session.close();
		}
	}
}
