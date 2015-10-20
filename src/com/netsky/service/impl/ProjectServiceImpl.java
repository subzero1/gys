package com.netsky.service.impl;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gd01_gcxm;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.dataObject.Gd06_b3y;
import com.netsky.dataObject.Gd07_b4;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.ProjectService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * @author Chiang
 * 
 * ������ط���
 */
public class ProjectServiceImpl implements ProjectService {

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
	 * ���Ƶ����
	 * 
	 * @param dxgc_id
	 *            �����Ƶ����id
	 * @param gcxm_id
	 *            �½���Ŀ����������Ŀid
	 * @return �½������id
	 */
	public Integer copyProject(Integer dxgc_id, Integer gcxm_id, String newDxgcName, String gcfl) throws Exception {
		Gd02_dxgc gd02;
		QueryBuilder queryBuilder;
		ResultObject ro;
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("���ܻ�ȡsession" + e);
		}
		try {
			gd02 = (Gd02_dxgc) queryService.searchById(Gd02_dxgc.class, dxgc_id);
			/**
			 * ����gd02
			 */
			gd02 = (Gd02_dxgc) PropertyInject.cloneObject(gd02);
			gd02.setId(null);
			gd02.setGcmc(newDxgcName);
			if (gcxm_id != null) {
				gd02.setGcxm_id(gcxm_id);
			} else {
				/**
				 * �½���Ŀ
				 */
				Gd01_gcxm gd01 = new Gd01_gcxm();
				gd01.setCjr(gd02.getCjr());
				gd01.setCjr_id(gd02.getCjr_id());
				gd01.setBzr(gd02.getBzr());
				gd01.setBzrq(gd02.getBzrq());
				gd01.setCjrq(gd02.getCjsj());
				gd01.setXmmc(gd02.getGcmc());
				gd01.setXmsm(gd02.getGcsm());
				gd01.setJsdw(gd02.getJsdw());
				gd01.setBgbh(gd02.getBgbh());
				gd01.setJsjd(gd02.getJsjd());
				gd01.setSjfzr(gd02.getSjfzr());
				gd01.setShr(gd02.getShr());
				if (gcfl != null) {
					gd01.setGcfl_id(Integer.valueOf(gcfl));
				}
				session.saveOrUpdate(gd01);
				gd02.setGcxm_id(gd01.getId());
			}
			session.saveOrUpdate(gd02);

			/**
			 * ����gd03
			 */
			queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd03_gcfysz gd03 = (Gd03_gcfysz) ro.get(Gd03_gcfysz.class.getName());
				gd03 = (Gd03_gcfysz) PropertyInject.cloneObject(gd03);
				gd03.setId(null);
				gd03.setDxgc_id(gd02.getId());
				gd03.setGcxm_id(gd02.getGcxm_id());
				session.saveOrUpdate(gd03);
			}

			/**
			 * ����gd04
			 */
			queryBuilder = new HibernateQueryBuilder(Gd04_clfysz.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd04_clfysz gd04 = (Gd04_clfysz) ro.get(Gd04_clfysz.class.getName());
				gd04 = (Gd04_clfysz) PropertyInject.cloneObject(gd04);
				gd04.setId(null);
				gd04.setDxgc_id(gd02.getId());
				gd04.setGcxm_id(gd02.getGcxm_id());
				session.saveOrUpdate(gd04);
			}

			/**
			 * ����gd05,gd06,����gd06����gd05id
			 */
			queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd05_b3j gd05 = (Gd05_b3j) ro.get(Gd05_b3j.class.getName());
				gd05 = (Gd05_b3j) PropertyInject.cloneObject(gd05);
				queryBuilder = new HibernateQueryBuilder(Gd06_b3y.class);
				queryBuilder.eq("dxgc_id", dxgc_id);
				queryBuilder.eq("b3j_id", gd05.getId());
				ResultObject ro2 = queryService.search(queryBuilder);
				gd05.setId(null);
				gd05.setDxgc_id(gd02.getId());
				gd05.setGcxm_id(gd02.getGcxm_id());
				session.saveOrUpdate(gd05);
				while(ro2.next()){
					Gd06_b3y gd06 = (Gd06_b3y) ro2.get(Gd06_b3y.class.getName());
					gd06 = (Gd06_b3y) PropertyInject.cloneObject(gd06);
					gd06.setId(null);
					gd06.setDxgc_id(gd02.getId());
					gd06.setGcxm_id(gd02.getGcxm_id());
					gd06.setB3j_id(gd05.getId());
					session.saveOrUpdate(gd06);
				}
			}

			/**
			 * ����gd07
			 */
			queryBuilder = new HibernateQueryBuilder(Gd07_b4.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd07_b4 gd07 = (Gd07_b4) ro.get(Gd07_b4.class.getName());
				gd07 = (Gd07_b4) PropertyInject.cloneObject(gd07);
				gd07.setId(null);
				gd07.setDxgc_id(gd02.getId());
				gd07.setGcxm_id(gd02.getGcxm_id());
				session.saveOrUpdate(gd07);
			}

			/**
			 * ����gd10
			 */
			queryBuilder = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd10_b3fl gd10 = (Gd10_b3fl) ro.get(Gd10_b3fl.class.getName());
				gd10 = (Gd10_b3fl) PropertyInject.cloneObject(gd10);
				gd10.setId(null);
				gd10.setDxgc_id(gd02.getId());
				gd10.setGcxm_id(gd02.getGcxm_id());
				session.saveOrUpdate(gd10);
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + "���Ƶ���̳���");
		} finally {
			session.close();
		}
		return gd02.getId();
	}
}
