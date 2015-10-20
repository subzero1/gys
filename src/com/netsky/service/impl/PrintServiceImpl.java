package com.netsky.service.impl;

import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;

import com.netsky.baseFormatUtils.NumberFormatUtil;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga00_zclb;
import com.netsky.dataObject.Ga09_kcxs;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.dataObject.Gd06_b3y;
import com.netsky.dataObject.Gd07_b4;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.PrintService;
import com.netsky.service.QueryService;

/**
 * ��ȡ��ӡ���ҳ������ʵ��
 * 
 * @author Chiang 2009-05-21
 */
public class PrintServiceImpl implements PrintService {

	private QueryService queryService;

	/**
	 * Ĭ�ϻ��ܱ�һҳ����
	 */
	private static final int Hzb_onePagesRows = 18;

	/**
	 * Ĭ�ϱ�5��һҳ����
	 */
	private static final int B5j_onePageRows = 19;

	/**
	 * Ĭ�ϱ�3��һҳ����
	 */
	private static final int B3j_onePageRows = 18;

	/**
	 * Ĭ�ϱ�3��һҳ����
	 */
	private static final int B3y_onePageRows = 18;

	/**
	 * Ĭ�ϱ�4һҳ����
	 */
	private static final int B4_onePageRows = 19;

	/**
	 * @return B3y_onePageRows
	 */
	public int getB3y_onePageRows() {
		return B3y_onePageRows;
	}

	/**
	 * @return the b4_onePageRows
	 */
	public int getB4_onePageRows() {
		return B4_onePageRows;
	}

	public int getB3j_onePageRows() {
		return B3j_onePageRows;
	}

	/**
	 * @return the queryService
	 */
	public QueryService getQueryService() {
		return queryService;
	}

	/**
	 * @return the hzbPagesRows
	 */
	public int getHzb_onePagesRows() {
		return Hzb_onePagesRows;
	}

	/**
	 * @param queryService
	 *            the queryService to set
	 */
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	/**
	 * @return the b5j_onePageRows
	 */
	public int getB5j_onePageRows() {
		return B5j_onePageRows;
	}

	/**
	 * ��ȡ��2ҳ��
	 */
	public Integer getB2pages(Integer gcxm_id, Integer dxgc_id) {
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("gcxm_id", gcxm_id);
		if (dxgc_id != null) {
			queryBuilder.eq("id", dxgc_id);
		}
		return new Integer((queryService.search(queryBuilder)).getLength());
	}

	/**
	 * ��ȡ��1ҳ��
	 */
	public Integer getB1pages(Integer gcxm_id, Integer dxgc_id) {
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("gcxm_id", gcxm_id);
		if (dxgc_id != null) {
			queryBuilder.eq("id", dxgc_id);
		}
		return new Integer((queryService.search(queryBuilder)).getLength());
	}

	/**
	 * ��ȡ��5j��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB5jTotalpages(Integer gcxm_id, Integer dxgc_id) {
		/**
		 * ��ҳ��
		 */
		int totalPages = 0;
		if (dxgc_id == null) {
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd02_dxgc gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
				totalPages += getB5jpages(gd02.getId()).intValue();
			}

		} else {
			return getB5jpages(dxgc_id);
		}
		return new Integer(totalPages);
	}

	/**
	 * ��ȡ������5jҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB5jpages(Integer dxgc_id) {
		/**
		 * ������
		 */
		int totalRows = 0;
		/**
		 * �����ҳ��
		 */
		int pages = 0;

		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder.eq("dxgc_id", dxgc_id);
		queryBuilder.like("bgbh", "B5", MatchMode.ANYWHERE);
		queryBuilder.notEq("bgbh", "B5HJ");
		ResultObject ro = queryService.search(queryBuilder);
		/**
		 * ���Ӻϼ���
		 */
		totalRows = ro.getLength() + 1;
		pages = totalRows / B5j_onePageRows;
		if (totalRows % B5j_onePageRows != 0 || pages == 0) {
			pages++;
		}
		return new Integer(pages);
	}

	/**
	 * ��ȡ��3j��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB3jTotalpages(Integer gcxm_id, Integer dxgc_id) {
		int totalPages = 0;
		if (dxgc_id == null) {
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			Gd02_dxgc dxgc = new Gd02_dxgc();
			while (ro.next()) {
				dxgc = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
				if (dxgc != null) {
					totalPages += getB3jpages(dxgc.getId()).intValue();
				}
			}
		} else {
			return getB3jpages(dxgc_id);
		}
		return new Integer(totalPages);
	}

	/**
	 * ��ȡ������3jҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3jpages(Integer dxgc_id) {
		int pages = 0;// ���ص�ҳ��
		int lines = 0;// ������
		double ckxsValue = 1.00;// ����ϵ��
		double tzxs = 1.00;// ����ϵ��
		double jgsum = 0.00;// �������պϼ�
		double pgsum = 0.00;// �չ����պϼ�
		double zgrSum = 0.00;// �ܹ���
		// ��ѯ����̱�õ�����������Ϣ
		QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder2.eq("id", dxgc_id);
		ResultObject ro2 = queryService.search(queryBuilder2);
		Gd02_dxgc dxgc = new Gd02_dxgc();
		if (ro2.next()) {
			dxgc = (Gd02_dxgc) ro2.get(Gd02_dxgc.class.getName());
		}

		// ��ѯb3j����
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
		queryBuilder.eq("dxgc_id", dxgc_id);
		ResultObject ro = queryService.search(queryBuilder);
		lines = ro.getLength();// �ܵĶ�����
		while (ro.next()) {
			Gd05_b3j b3j = (Gd05_b3j) ro.get(Gd05_b3j.class.getName());
			if (b3j.getId() != null) {
				if (b3j.getCk_bz() != null) {// ��ѯ����ϵ��
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder1.eq("lb", b3j.getCk_bz());
					queryBuilder1.ge("jzbh", b3j.getDebh());// ������С�ڵ�����ֹ���
					queryBuilder1.le("qsbh", b3j.getDebh());// �����Ŵ��ڵ�����ʼ���
					ResultObject ro1 = queryService.search(queryBuilder1);
					if (ro1.next()) {
						Ga09_kcxs ckxs = (Ga09_kcxs) ro1.get(Ga09_kcxs.class.getName());
						if (ckxs != null) {
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//��������ϵ��
						}
					}
				}
				if (b3j.getTzxs() != null) {
					tzxs = b3j.getTzxs().doubleValue();
				}
				jgsum = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j
						.getJggr().doubleValue(), b3j.getSl().doubleValue()), tzxs), ckxsValue), jgsum);
				pgsum = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j
						.getPggr().doubleValue(), b3j.getSl().doubleValue()), tzxs), ckxsValue), pgsum);
			}
			tzxs = 1.00;
			ckxsValue = 1.00;// �����û�1
		}

		if (dxgc.getB3_sgtj_bz() != null && dxgc.getB3_sgtj_bz().intValue() == 0) {// �Ƿ���������
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("fylb", new Integer(1));
			queryBuilder99.eq("bz", new Integer(1));// ȡ��ԭ��
			queryBuilder99.eq("flag", new Integer(1));
			ResultObject ro99 = queryService.search(queryBuilder99);
			lines = ro99.getLength() + lines;
			Gd10_b3fl data99 = new Gd10_b3fl();
			if (ro99.next()) {
				data99 = (Gd10_b3fl) ro99.get(Gd10_b3fl.class.getName());
			}
			if (data99.getId() != null && data99.getRgfl() != null) {
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data99.getRgfl().doubleValue());// ���Ը�ԭ��ϵ��
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data99.getRgfl().doubleValue());
			}

			QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder100.eq("dxgc_id", dxgc_id);
			queryBuilder100.eq("fylb", new Integer(1));
			queryBuilder100.eq("bz", new Integer(2));// ȡɳĮɭ�ֵ�
			queryBuilder100.eq("flag", new Integer(1));
			ResultObject ro100 = queryService.search(queryBuilder100);
			lines = ro100.getLength() + lines;
			Gd10_b3fl data100 = new Gd10_b3fl();
			if (ro100.next()) {
				data100 = (Gd10_b3fl) ro100.get(Gd10_b3fl.class.getName());
			}
			if (data100.getId() != null && data100.getRgfl() != null) {
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data100.getRgfl().doubleValue());// ����ɳĮɭ�ֵ�ϵ��
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data100.getRgfl().doubleValue());
			}
		}

		zgrSum = NumberFormatUtil.addToDouble(jgsum, pgsum);
		if (dxgc.getZy_id() != null) {
			if (dxgc.getZy_id().intValue() == 1 || dxgc.getZy_id().intValue() == 2) {// ����ǹ��߹��̼���С���յ���
				if (dxgc.getXgr_bz() != null && dxgc.getXgr_bz().intValue() == 0) {// 0��Ҫ����С���յ���
					if (100 < zgrSum && zgrSum <= 250) {
						Gd10_b3fl xgr = new Gd10_b3fl();
						QueryBuilder queryBuilder3 = new HibernateQueryBuilder(Gd10_b3fl.class);
						queryBuilder3.eq("dxgc_id", dxgc_id);
						queryBuilder3.eq("fylb", new Integer(3));
						queryBuilder3.eq("bz", new Integer(250));
						ResultObject ro3 = queryService.search(queryBuilder3);
						lines = ro3.getLength() + lines;
						if (ro3.next()) {
							xgr = (Gd10_b3fl) ro3.get(Gd10_b3fl.class.getName());
						}
						if (xgr != null) {
							zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
							jgsum = NumberFormatUtil.mulToDouble(jgsum, xgr.getRgfl().doubleValue());
							pgsum = NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl().doubleValue());
						}
					}
					if (zgrSum <= 100) {
						Gd10_b3fl xgr = new Gd10_b3fl();
						QueryBuilder queryBuilder4 = new HibernateQueryBuilder(Gd10_b3fl.class);
						queryBuilder4.eq("dxgc_id", dxgc_id);
						queryBuilder4.eq("fylb", new Integer(3));
						queryBuilder4.eq("bz", new Integer(100));
						ResultObject ro4 = queryService.search(queryBuilder4);
						lines = ro4.getLength() + lines;
						if (ro4.next()) {
							xgr = (Gd10_b3fl) ro4.get(Gd10_b3fl.class.getName());
						}
						if (xgr != null) {
							zgrSum = NumberFormatUtil.mulToDouble(zgrSum, xgr.getRgfl().doubleValue());
							jgsum = NumberFormatUtil.mulToDouble(jgsum, xgr.getRgfl().doubleValue());
							pgsum = NumberFormatUtil.mulToDouble(pgsum, xgr.getRgfl().doubleValue());
						}
					}
				}
			}
		}

		if (dxgc.getGcxz() != null && dxgc.getGcxz().intValue() == 2) {// ȫ���������̹��յ�������
			Gd10_b3fl data99 = new Gd10_b3fl();
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("fylb", new Integer(3));
			queryBuilder99.eq("mc", new String("ȫ���������̹��յ�������"));
			ResultObject ro99 = queryService.search(queryBuilder99);
			lines = ro99.getLength() + lines;
			if (ro99.next()) {
				data99 = (Gd10_b3fl) ro99.get(Gd10_b3fl.class.getName());
			}
			if (data99 != null && data99.getRgfl() != null) {
				jgsum = NumberFormatUtil.mulToDouble(jgsum, data99.getRgfl().doubleValue());
				pgsum = NumberFormatUtil.mulToDouble(pgsum, data99.getRgfl().doubleValue());
			}
		}
		lines = lines + 2;// ���Ϻϼƺ��ܼ�����
		pages = lines / B3j_onePageRows;
		if (lines % B3j_onePageRows != 0 || pages == 0) {
			pages++;
		}
		return new Integer(pages);
	}

	/**
	 * ��ȡ��4��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @return Integer ҳ��
	 */
	public Integer getB4Totalpages(Integer gcxm_id, Integer dxgc_id, String bgbh) {
		/**
		 * ��ҳ��
		 */
		int totalPages = 0;
		if (dxgc_id == null) {
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd02_dxgc gd02 = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
				totalPages += getB4pages(gd02.getId(), bgbh).intValue();
			}

		} else {
			return getB4pages(dxgc_id, bgbh);
		}
		return new Integer(totalPages);
	}

	/**
	 * ��ȡ������4ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @param bgbh
	 *            �����
	 * @return Integer ҳ��
	 */
	public Integer getB4pages(Integer dxgc_id, String bgbh) {
		/**
		 * ������
		 */
		int totalRows = 0;
		/**
		 * �����ҳ��
		 */
		int pages = 0;
		Ga00_zclb ga00;
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga00_zclb.class);
		queryBuilder.addOrderBy(Order.asc("id"));
		ResultObject ro = queryService.search(queryBuilder);
		while (ro.next()) {
			ga00 = (Ga00_zclb) ro.get(Ga00_zclb.class.getName());
			queryBuilder = new HibernateQueryBuilder(Gd07_b4.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			queryBuilder.eq("bgbh", bgbh);
			queryBuilder.eq("zclb", ga00.getZclb());
			ResultObject ro2 = queryService.search(queryBuilder);
			if (ro2.getLength() > 0) {
				//ȥ������Ϊ0����
				while(ro2.next()){
					Gd07_b4 b4=(Gd07_b4)ro2.get(Gd07_b4.class.getName());
					if(b4.getId()!=null&&b4.getSl()!=null&&b4.getSl().doubleValue()!=0.0){
						totalRows++;
					}
				}
				//totalRows += ro2.getLength();
				totalRows++;//�������һ��
				/**
				 * ����С������
				 */
				totalRows++;
				/**
				 * ��Ԥ��������豸������ط���
				 */
				if (!ga00.getZclb().equals("YS")) {
					/**
					 * ���Ӳɹ��������ѣ��ɹ������ܷѣ����ӷѣ����䱣�շѼ����Ϸ�����úϼ��У���5��
					 */
					//totalRows += 5;
					totalRows ++;//�Ӻϼ�һ��
					/**
					 * ���ӷ���
					 */
					QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd04_clfysz.class);
					queryBuilder99.eq("bgbh",bgbh);
					queryBuilder99.eq("dxgc_id",dxgc_id);
					queryBuilder99.eq("zclb",ga00.getZclb());
					queryBuilder99.addOrderBy(Order.asc("fy_id"));
					ResultObject ro99 = queryService.search(queryBuilder99);
					while(ro99.next()){
						Gd04_clfysz gd04 = (Gd04_clfysz) ro99.get(Gd04_clfysz.class.getName());
						if(gd04.getFlz()!=null&&gd04.getFlz().doubleValue()!=0.0){//ȥ������Ϊ0 ����
							totalRows++;
						}
					}
				}
			}
		}
		/**
		 * �����ܼ�����
		 */
		totalRows++;
		pages = totalRows / B4_onePageRows;
		if (totalRows % B4_onePageRows != 0 || pages == 0) {
			pages++;
		}
		//if(totalRows==1){//���û�����ݷ���0ҳ
		//	return new Integer(0);
		//}else{
			return new Integer(pages);
		//}
	}

	public Integer getHzbTotalpages(Integer gcxm_id, String dxgc_ids) {
		/**
		 * ������
		 */
		int totalRows = 0;
		/**
		 * ҳ��
		 */
		int pages = 0;
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("gcxm_id", gcxm_id);
		if (dxgc_ids != null) {
			Integer dxgc_id[] = new Integer[(dxgc_ids.split(",")).length];
			for (int i = 0; i < dxgc_id.length; i++) {
				dxgc_id[i] = Integer.valueOf(dxgc_ids.split(",")[i]);
			}
			queryBuilder.in("id", dxgc_id);
		}
		totalRows = (queryService.search(queryBuilder)).getLength();
		/**
		 * �����ܼ�����
		 */
		totalRows++;
		pages = totalRows / Hzb_onePagesRows;
		if (totalRows % Hzb_onePagesRows != 0 || pages == 0) {
			pages++;
		}
		return new Integer(pages);
	}

	/**
	 * ��ȡ��3y��ҳ��
	 * 
	 * @param gcxm_id
	 *            ������Ŀid
	 * @param dxgc_id
	 *            �����id
	 * @return Integer ҳ��
	 */
	public Integer getB3yTotalpages(Integer gcxm_id, Integer dxgc_id) {
		int totalPages = 0;
		if (dxgc_id == null) {
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd02_dxgc dxgc = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
				totalPages += getB3ypages(dxgc.getId()).intValue();
			}
		} else {
			return getB3ypages(dxgc_id);
		}
		return new Integer(totalPages);
	}

	/**
	 * ��ȡ������3yiҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3ypages(Integer dxgc_id) {
		int pages = 0;// ���ص�ҳ��
		int lines = 0;// ������
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("id", dxgc_id);
		ResultObject ro = queryService.search(queryBuilder);
		Gd02_dxgc dxgc = new Gd02_dxgc();
		if (ro.next()) {
			dxgc = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
		}

		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id", dxgc_id);
		queryBuilder1.eq("lb", new String("JX"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		lines = ro1.getLength();

		if (dxgc.getB3_sgtj_bz().intValue() == 0) {// �Ƿ���������
			QueryBuilder queryBuilder12 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder12.eq("dxgc_id", dxgc_id);
			queryBuilder12.eq("fylb", new Integer(1));
			queryBuilder12.eq("bz", new Integer(1));// ȡ��ԭ��
			queryBuilder12.eq("flag", new Integer(1));
			ResultObject ro12 = queryService.search(queryBuilder12);
			lines += ro12.getLength();

			QueryBuilder queryBuilder13 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder13.eq("dxgc_id", dxgc_id);
			queryBuilder13.eq("fylb", new Integer(1));
			queryBuilder13.eq("bz", new Integer(2));// ȡɳĮɭ�ֵ�
			queryBuilder13.eq("flag", new Integer(1));
			ResultObject ro13 = queryService.search(queryBuilder13);
			lines += ro13.getLength();
		}
		lines += 2;// ���Ϻϼƺ��ܼ�����
		pages = lines / B3y_onePageRows;
		if (lines % B3y_onePageRows != 0 || pages == 0) {
			pages++;
		}
		return new Integer(pages);
	}

	/**
	 * ��ȡ��3����ҳ��
	 * 
	 * @param gcxm_id
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3bTotalpages(Integer gcxm_id, Integer dxgc_id) {
		int totalPages = 0;
		if (dxgc_id == null) {
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro = queryService.search(queryBuilder);
			while (ro.next()) {
				Gd02_dxgc dxgc = (Gd02_dxgc) ro.get(Gd02_dxgc.class.getName());
				totalPages += getB3bpages(dxgc.getId()).intValue();
			}
		} else {
			return getB3bpages(dxgc_id);
		}
		return new Integer(totalPages);
	}

	/**
	 * ��ȡ������3��ҳ��
	 * 
	 * @param dxgc_id
	 * @return Integer ҳ��
	 */
	public Integer getB3bpages(Integer dxgc_id) {
		int pages = 0;// ���ص�ҳ��
		int lines = 0;// ������
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder.eq("dxgc_id", dxgc_id);
		queryBuilder.eq("lb", new String("YB"));
		ResultObject ro = queryService.search(queryBuilder);
		lines = ro.getLength();
		lines += 2;// �����ܼ�һ��
		pages = lines / B3y_onePageRows;// ��3�ұ�ÿҳ������һ��
		if (lines % B3y_onePageRows != 0 || pages == 0) {
			pages++;
		}
		return new Integer(pages);
	}
}
