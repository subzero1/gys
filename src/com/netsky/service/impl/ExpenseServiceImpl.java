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
 * ���ʷ�����ط���ʵ��
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
	 * ��ȡ���ʱ�1,2,5ֵ
	 * 
	 * @param dxgc_id
	 *            �����id
	 * @param fy_id
	 *            ga05����id
	 * @throws Exception
	 * @return String flz ���ط�����ط���
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
			throw new Exception("����̲����� dxgc_id = " + dxgc_id);
		}
		/**
		 * ��ȡ����
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
			 * ��ʼ��Ĭ�Ϸ���ֵ
			 */
			flz = ga08.getFlz().toString();
			/**
			 * ����רҵ��ط���
			 */
			if (ga08.getZy_id() != null && ga08.getQj_id() == null && ga08.getZclb() == null) {
				HSql = "select ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = " + gd02.getFlk_id()
						+ " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId();
				ResultObject ro2 = queryService.search(HSql);
				if (ro2.getLength() == 1) {
					/**
					 * ����רҵ���
					 */
					ro2.next();
					ga08 = (Ga08_flmx) ro2.get("ga08");
					flz = ga08.getFlz().toString();
				}
			}
			/**
			 * ����������ط���
			 * 
			 * ��ʱ��ʩ���� ����ʩ�������ǲ�Ѷ��� ʩ�������ǲ�ѵ�ǲ���� ���赥λ����� ���蹤�̼����
			 */
			if (ga05.getMc().equals("��ʱ��ʩ����")) {
				/**
				 * ��ǲ��̶�Ӧ�������,���ʹ�������רҵ.
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
					 * �����滻Ϊ0
					 */
					flz = "0";
				}

			} else if (ga05.getMc().equals("����ʩ�������ǲ�Ѷ���")) {
				/**
				 * ��ȡ��ǲ���
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
					 * ��ǲ��������䷶Χ��
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
					 * ��ǲ��̳������䷶Χ,����ÿ��������
					 */
					Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
					Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
					/**
					 * �������ӵ�ǲ��
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
					 * ��ǲ���<0,�����滻Ϊ0
					 */
					flz = "0";

				}
			} else if (ga05.getMc().equals("ʩ�������ǲ�ѵ�ǲ����") || ga05.getMc().equals("���蹤�̼����")) {
				/**
				 * ��ȡ�����ܹ��ջ�����װ���̷�
				 */
				Double number = new Double(0);
				if (ga05.getMc().equals("ʩ�������ǲ�ѵ�ǲ����")) {
					HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
							+ " and fymc = '�����ܹ���'";
				} else if (ga05.getMc().equals("���蹤�̼����")) {
					HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
							+ " and fymc = '������װ���̷�'";
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
					 * number�����䷶Χ��
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
					 * number�������䷶Χ,����ÿ��������
					 */
					Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
					Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
					String zjs = "0";
					if (mzj != null) {
						/**
						 * �������ӵ�ǲ��
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
					 * number<0,�����滻Ϊ0
					 */
					flz = "0";

				}
			} else if (ga05.getMc().equals("���赥λ�����")) {
				String number = "0";
				/**
				 * ��ȡ�����ܸ���
				 * 
				 * ���̷�+��5������
				 */
				HSql = "select fyz from Gd03_gcfysz where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
						+ " and fymc in ('�����ܸ���')";
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
						 * �ܸ����������,������Ҫ����
						 */
						if (ga07.getSx() != null && Double.parseDouble(number) > ga07.getSx().doubleValue()) {
							/**
							 * �ܸ����������,ʹ������-��������
							 */
							flz = NumberFormatUtil.addToString(flz, NumberFormatUtil.mulToString(NumberFormatUtil.subToString(
									ga07.getSx().toString(), ga07.getXx().toString()), NumberFormatUtil.divToString(ga08.getFlz().toString(), "100",
									4)));
						} else if (ga07.getSx() == null || Double.parseDouble(number) < ga07.getSx().doubleValue()) {
							/**
							 * �ܸ���С������,��������Ϊ��,ʹ�ø���-��������
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
	 * �����ۺ���Ϣ��Ĵ���,��ga05�з�������д��gd03
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
			throw new Exception("���ܻ�ȡsession" + e);
		}
		Gd03_gcfysz gd03;
		Ga05_fy ga05 = null;
		Ga08_flmx ga08;
		try {
			/**
			 * ������������
			 */
			String HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
					+ gd02.getFlk_id() + " and ga05.bgbh != 'B4'";
			ResultObject ro = queryService.search(HSql);
			while (ro.next()) {
				ga05 = (Ga05_fy) ro.get("ga05");
				ga08 = (Ga08_flmx) ro.get("ga08");
				gd03 = new Gd03_gcfysz();
				/**
				 * ��ʼ��gd03����
				 */
				gd03.setGcxm_id(gd02.getGcxm_id());
				gd03.setDxgc_id(gd02.getId());
				gd03.setFy_id(ga05.getId());
				gd03.setFymc(ga05.getMc());
				if (ga05.getJsgs() != null) {
					gd03.setJsgs(ga05.getJsgs().replaceAll("\\[����]", NumberFormatUtil.roundToString(ga08.getFlz())));
					if (ga05.getGsbds() != null) {
						gd03.setGsbds(ga05.getGsbds().replaceAll("\\[����]", NumberFormatUtil.roundToString(ga08.getFlz())));
					}
				}
				gd03.setBgbh(ga05.getBgbh());
				gd03.setBz(ga05.getBz());
				gd03.setSxh(ga05.getSxh());
				gd03.setXgfy(ga05.getXgfy());
				gd03.setDyyl(new Integer(1));
				/**
				 * ����רҵ��ط���
				 */
				if (ga08.getZy_id() != null) {
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
							+ gd02.getFlk_id() + " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId();
					ResultObject ro2 = queryService.search(HSql);
					if (ro2.getLength() == 1) {
						/**
						 * ����רҵ���
						 */
						ro2.next();
						ga08 = (Ga08_flmx) ro2.get("ga08");
						if (ga05.getJsgs() != null) {
							gd03.setJsgs(ga05.getJsgs().replaceAll("\\[����]", NumberFormatUtil.roundToString(ga08.getFlz())));
							if (ga05.getGsbds() != null) {
								gd03.setGsbds(ga05.getGsbds().replaceAll("\\[����]", NumberFormatUtil.roundToString(ga08.getFlz())));
							}
						}
					}
				}
				session.saveOrUpdate(gd03);
			}
			/**
			 * �ǹ������ʺϼƷ���
			 */
			HSql = "select ga05 from Ga05_fy ga05 where ga05.id not in (select fy_id from Ga08_flmx) and ga05.bgbh != 'B4'";
			ro = queryService.search(HSql);
			while (ro.next()) {
				ga05 = (Ga05_fy) ro.get("ga05");
				gd03 = new Gd03_gcfysz();
				/**
				 * ��ʼ��gd03����
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
			throw new Exception(e + " ����gd03���ݳ���! at expenseService.insertGd03" + ga05.getMc());
		} finally {
			session.close();
		}
	}

	/**
	 * �������ݺ�������,��ga14����д��gd10
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
			throw new Exception("���ܻ�ȡsession" + e);
		}
		try {

			/**
			 * ��ԭ�����˹�����ϵ��,ɭ�ּ�ɳĮ����
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
			 * С���յ���
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
			throw new Exception(e + " ����gd10���ݳ���! at expenseService.insertGd10");
		} finally {
			session.close();
		}
	}
	
	/**
	 * �������ݺ�������,��ga14����д��gd10
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
			throw new Exception("���ܻ�ȡsession" + e);
		}
		try {

			/**
			 * ��ԭ�����˹�����ϵ��,ɭ�ּ�ɳĮ����
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
			 * С���յ���
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
			throw new Exception(e + " ����gd10���ݳ���! at expenseService.insertGd10");
		} finally {
			session.close();
		}
	
		
	}

	/**
	 * �������ݺ�������,����gd10
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
			throw new Exception("���ܻ�ȡsession" + e);
		}
		try {

			/**
			 * ��ԭ�����˹�����ϵ��,ɭ�ּ�ɳĮ����
			 */
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder.eq("dxgc_id", gd02.getId());
			queryBuilder.eq("gcxm_id", gd02.getGcxm_id());
			queryBuilder.eq("fylb", new Integer(1));
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd10_b3fl gd10 = (Gd10_b3fl) ro.get(Gd10_b3fl.class.getName());
				/**
				 * ���ø�ԭ����ѡ��
				 */
				if (gd10.getBz().intValue() == 1 && request.getParameter("B3_GYDQ_BZ") != null
						&& request.getParameter("B3_GYDQ_BZ").equals(gd10.getId().toString())) {
					gd10.setFlag(new Integer(1));
				} else if (gd10.getBz().intValue() == 1) {
					gd10.setFlag(new Integer(0));
				}
				/**
				 * ����ɭ�ּ�ɳĮ����
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
			throw new Exception(e + " ����gd10���ݳ���! at expenseService.updateGd10");
		} finally {
			session.close();
		}
	}

	/**
	 * ���»�ȡ�������
	 * 
	 * @param gd02
	 * @param bgbh
	 *            �����
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
			throw new Exception("���ܻ�ȡsession" + e);
		}
		try {
			if (bgbh.equals("B3J")) {
				/**
				 * ���»�ȡ��3�׷���
				 */

				/**
				 * ɾ��ԭ��Ϣ
				 */
				String HSql = "delete Gd10_b3fl where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId() + " and fylb= "
						+ new Integer(3);
				Query query = session.createQuery(HSql);
				query.executeUpdate();
				/**
				 * ����д��,Ĭ�Ͼ���ѡ��
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
				 * ��ȡ�����ҷ���
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
				 * ���»�ȡ��4����,�����˾�,ԭ��Ϣ��ɾ��
				 */

				/**
				 * ��ȡԭgd04������ط���
				 */
				String HSql = "select gd04 from Gd04_clfysz gd04 where gcxm_id = " + gd02.getGcxm_id() + " and dxgc_id = " + gd02.getId()
						+ " and fymc in (select ga05.mc from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = "
						+ gd02.getFlk_id() + ")";
				ResultObject ro = queryService.search(HSql);
				while (ro.next()) {
					Gd04_clfysz gd04 = (Gd04_clfysz) ro.get("gd04");
					/**
					 * ����ֻ����������豸�����ط���
					 */
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 "
							+ " where ga05.bgbh = 'B4' and ga05.id = ga08.fy_id and ga08.zy_id is null and ga05.mc = '" + gd04.getFymc()
							+ "' and ga08.zclb = '" + gd04.getZclb() + "' and ga08.flk_id = " + gd02.getFlk_id() + " and ga08.qj_id is null";
					ResultObject ro2 = queryService.search(HSql);
					if (ro2.next()) {
						/**
						 * ������������,����רҵ��������
						 */
						Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
						Ga08_flmx ga08 = (Ga08_flmx) ro2.get("ga08");
						gd04.setFlz(ga08.getFlz());
						gd04.setFy_id(ga05.getId());
					}
					/**
					 * ������������,�豸�����͹���רҵ��عط���
					 */
					HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 " + " where ga05.bgbh = 'B4' and ga05.id = ga08.fy_id and ga05.mc = '"
							+ gd04.getFymc() + "' and ga08.zclb = '" + gd04.getZclb() + "' and ga08.flk_id = " + gd02.getFlk_id()
							+ " and ga08.zy_id = " + gd02.getZy_id() + " and ga08.qj_id is null";
					ro2 = queryService.search(HSql);
					if (ro2.next()) {
						/**
						 * ������������,����רҵ��������
						 */
						Ga05_fy ga05 = (Ga05_fy) ro2.get("ga05");
						Ga08_flmx ga08 = (Ga08_flmx) ro2.get("ga08");
						gd04.setFlz(ga08.getFlz());
						gd04.setFy_id(ga05.getId());
					}
					/**
					 * ����������ط���
					 * 
					 * ���ӷ�
					 */
					if (gd04.getFymc().equals("���ӷ�")) {
						if (gd04.getFlyj() == null || gd04.getFlyj().doubleValue() <= 0) {
							/**
							 * �˾�Ϊ�ջ�<=0,����ΪĬ��ֵ,Ĭ��ֵΪ��һ����
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
								 * �˾������䷶Χ��
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
								 * �˾೬�����䷶Χ,����ÿ��������
								 */
								Integer xx = ((Ga07_qfqj) ro2.get("ga07")).getXx();
								Integer mzj = ((Ga07_qfqj) ro2.get("ga07")).getMzj();
								/**
								 * �������ӷ���
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
				 * ���»�ȡ��1,��2���5����
				 */

				/**
				 * ��ȡԭ����������Ϣ
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
						gd03.setJsgs(ga05.getJsgs().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
						if (ga05.getGsbds() != null)
							gd03.setGsbds(ga05.getGsbds().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
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
			throw new Exception(e + " ���»�ȡ" + bgbh + "���ʳ���! at expenseService.reBuildFy");
		} finally {
			session.close();
		}

	}

	/**
	 * �½��ۺ���Ϣʱд��gd04��Ϣ��
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
			throw new Exception("���ܻ�ȡsession" + e);
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
				 * ������������
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
					 * ��ʼ��gd04����
					 */
					gd04.setGcxm_id(gd02.getGcxm_id());
					gd04.setDxgc_id(gd02.getId());
					gd04.setFy_id(ga05.getId());
					gd04.setFymc(ga05.getMc());
					gd04.setFlz(ga08.getFlz());
					gd04.setZclb(ga08.getZclb());
					gd04.setBgbh(gb03.getBgbh());
					/**
					 * ����רҵ,������ط���
					 */
					if (ga08.getZy_id() != null) {
						HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = " + gd02.getFlk_id()
								+ " and ga08.zy_id = '" + gd02.getZy_id() + "' and ga05.id = " + ga05.getId() + " and ga08.zclb = '" + ga08.getZclb()
								+ "'";
						ResultObject ro2 = queryService.search(HSql);
						if (ro2.getLength() == 1) {
							/**
							 * ����רҵ,�������
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
				 * �ǹ������ʺϼƷ���
				 */
				HSql = "select ga05 from Ga05_fy ga05 where ga05.id not in (select fy_id from Ga08_flmx) and ga05.bgbh = 'B4'";
				ro = queryService.search(HSql);
				while (ro.next()) {
					ga05 = (Ga05_fy) ro.get("ga05");
					gd04 = new Gd04_clfysz();
					/**
					 * ��ʼ��gd04����
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
			throw new Exception(e + " ����gd04���ݳ���! at expenseService.insertGd04");
		} finally {
			session.close();
		}
	}

	public void rebuildZyfl(Gd02_dxgc gd02) throws Exception {
		String HSql = "select ga05 from Ga05_fy ga05 where ga05.id in (select distinct fy_id from Ga08_flmx where zy_id is not null)";
		/**
		 * ��ȡ����רҵ��ط���
		 */
		ResultObject ro = queryService.search(HSql);
		while (ro.next()) {
			Ga05_fy ga05 = (Ga05_fy) ro.get("ga05");
			if (ga05.getBgbh().equals("B4")) {
				/**
				 * ��4����,����gd04
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
						 * ֻ��רҵ�����������ķ���
						 */
						ro3.next();
						Ga08_flmx ga08 = (Ga08_flmx) ro3.get("ga08");
						gd04.setFlz(ga08.getFlz());
						saveService.save(gd04);
					}
				}
			} else {
				/**
				 * ��������,����gd03��ʽ
				 */
				HSql = "from Gd03_gcfysz gd03 where dxgc_id = " + gd02.getId() + " and fy_id = " + ga05.getId();
				ResultObject ro2 = queryService.search(HSql);
				while (ro2.next()) {
					Gd03_gcfysz gd03 = (Gd03_gcfysz) ro2.get("gd03");
					String flz = this.getFlz(gd02.getId(), ga05.getId());
					gd03.setJsgs(ga05.getJsgs().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
					gd03.setGsbds(ga05.getGsbds().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
					saveService.save(gd03);
				}
			}
		}

	}

	/**
	 * ɾ�����ʱ������ط���,�ӹ�ʽ��ɾ���˷���,���ӱ����Ϣʱ���¸���ʽ��ӷ���,gb03�д洢��Ҫ�˴���ķ���
	 * 
	 * @param gd02
	 * @param bgxx_id
	 *            gb03_id ��Ҫ�����ı��
	 * @param oper_flag
	 *            "delete" or "add"
	 * @throws Exception
	 */
	public void updateJsgc(Gd02_dxgc gd02, Integer bgxx_id, String oper_flag) throws Exception {
		QueryBuilder queryBuilder;
		ResultObject ro;
		/**
		 * ��ȡ�����ط���
		 */
		Gb03_bgxx gb03 = (Gb03_bgxx) queryService.searchById(Gb03_bgxx.class, bgxx_id);
		if (gb03 == null) {
			throw new Exception("����ı��id");
		}
		if (gb03.getXgfy() == null || gb03.getXgfy().equals("")) {
			return;
		}
		String xgfy[] = gb03.getXgfy().split(",");
		if (oper_flag.equals("add")) {
			/**
			 * ���ӱ��ʱ���»�ȡ��gb03�м�¼������ط��ü��㹫ʽ
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
						gd03.setJsgs(ga05.getJsgs().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
						gd03.setGsbds(ga05.getGsbds().replaceAll("\\[����]", NumberFormatUtil.roundToString(flz)));
						saveService.save(gd03);
					}
				}
			}
		} else if (oper_flag.equals("delete")) {
			/**
			 * ɾ�����ʱ����gd03����gb03��ط����йصĹ�ʽ
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
