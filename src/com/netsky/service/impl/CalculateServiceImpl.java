package com.netsky.service.impl;

import java.math.BigDecimal;
import java.util.*;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;

import com.netsky.baseObject.Calculator;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga02_clsb;
import com.netsky.dataObject.Ga03_glcl;
import com.netsky.dataObject.Ga05_fy;
import com.netsky.dataObject.Ga07_qfqj;
import com.netsky.dataObject.Ga08_flmx;
import com.netsky.dataObject.Ga09_kcxs;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.dataObject.Gd06_b3y;
import com.netsky.dataObject.Gd07_b4;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

import com.netsky.baseFormatUtils.NumberFormatUtil;

/**
 * ���������ʵ��
 * 
 * @author CT
 * @create 2009-04-09
 */
public class CalculateServiceImpl implements CalculateService {

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
	 * ����
	 * 
	 * @param dxgc_id
	 * @throws Exception
	 */
	public void Calculate(Integer dxgc_id) throws Exception {
		List list=new ArrayList();
		
		HashMap map = new HashMap();
		
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd03_gcfysz.class);// ȡ��������������
		queryBuilder.eq("dxgc_id", dxgc_id);
		queryBuilder.addOrderBy(Order.asc("sxh"));
		ResultObject ro = queryService.search(queryBuilder);
		//ȡ��map��Ҫ�ĳ�ʼֵ-------------
		Gd02_dxgc data2=new Gd02_dxgc();
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder1.eq("id",dxgc_id);
		ResultObject ro1=queryService.search(queryBuilder1);
		if(ro1.next()){
			data2= (Gd02_dxgc)ro1.get(Gd02_dxgc.class.getName());
		}//----------------------
		int jj = 0;
		Gd03_gcfysz data;
		for (int i = 0;ro.next(); i++) {
			
			data=(Gd03_gcfysz)ro.get(Gd03_gcfysz.class.getName());
			double zdw=0.0;
			if(data2.getB2_jxdqdw()!=null){
				zdw=data2.getB2_jxdqdw().doubleValue();
			}
			map.put("[�ܶ�λ]", new BigDecimal(new Double(zdw).toString()).toString());
			double sjdy=0.0;
			if(data2.getB5_sczbf_sjdy()!=null){
				sjdy=data2.getB5_sczbf_sjdy().doubleValue();
			}
			map.put("[��ƶ�Ա]",new BigDecimal(new Double(sjdy).toString()).toString());
			double dqyj=0.0;
			if(data2.getB2_jxdqlc()!=null){
				dqyj=data2.getB2_jxdqlc().doubleValue();
			}
			map.put("[��ǲ�˾�]", new BigDecimal(new Double(dqyj).toString()).toString());
			try {
				if(data.getJsgs()!=null&&!data.getJsgs().equals("")){

					if(data.getFymc().equals("���赥λ�����")){//���㽨�赥λ�������Ҫ���⴦��
						String flz = "0";
						String number = "0";
						String gcf=(String) map.get("[�����ܸ���]");
						number =gcf.toString();
						flz = JSDWGLFCalculate(data2.getId(),number);
						data.setJsgs(flz);
						if(NumberFormatUtil.roundToDouble(flz)==0.00){
							data.setFyz(null);
						}else{
							data.setFyz(new Double(NumberFormatUtil.roundToDouble(flz)));
						}
						
					}else{
						if(NumberFormatUtil.roundToDouble(Calculator.exec(data.getJsgs(), map))==0.00){
							data.setFyz(null);
						}else{
							data.setFyz(new Double(NumberFormatUtil.roundToDouble(Calculator.exec(data.getJsgs(), map))));
						}
					}
				}
			} catch (Exception e) {
				throw new Exception("���㹫ʽ����" + e);
			}
			double fyz=0.00;
			if(data.getFyz()!=null){
				fyz=data.getFyz().doubleValue();
			}
			map.put("["+data.getFymc()+"]", new BigDecimal(new Double(fyz).toString()).toString());
			if(data!=null){
				list.add(data);
			}
		}
		try {
			saveService.save((Object[]) list.toArray(new Object[list.size()]));
		} catch (Exception e) {
			throw new Exception("�������" + e);
		}
		
		/**
		 * ��һ�Ƿ����Ƿ�
		 */
		if(data2.getB1_qzbz()!=null&&data2.getB1_qzbz().intValue()==0){//0������Ƿ�
			QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd03_gcfysz.class);
			queryBuilder9.eq("dxgc_id", dxgc_id);
			queryBuilder9.eq("fy_id", new Integer(3));
			ResultObject ro9 = queryService.search(queryBuilder9);
			if(ro9.next()){
				Gd03_gcfysz data9 = (Gd03_gcfysz)ro9.get(Gd03_gcfysz.class.getName());
				if(data9.getFyz()!=null){
					data9.setFyz(new Double(new BigDecimal(data9.getFyz().doubleValue()).divide(new BigDecimal("1"), 0, BigDecimal.ROUND_HALF_UP).doubleValue()));
					saveService.save(data9);
				}
			}
		}
	}
	/**
	 * �������� 
	 * 
	 * ע�����˳��Ҫ����Ķ�
	 */
	public void  B3Calculate(Integer dxgc_id,Integer gcxm_id){
		
		double ckxsValue = 1.00;//����ϵ��
		double tzxs = 1.00;//����ϵ��	
		double jgsum=0.00;//�������պϼ�
		double pgsum=0.00;//�չ����պϼ�
		double zgrSum=0.00;//�ܹ���
		double yjjggr=0.00;//ҹ�似������
		double yjpggr=0.00;//ҹ���չ�����
		double dyjggr=0.00;//���꼼������
		double dypggr=0.00;//�����չ�����
		double gcgrjggr=0.00;//���̸��ż�������
		double gcgrpggr=0.00;//���̸����չ�����
		double tsbzjggr = 0.00;//�����־������
		double tsbzpggr = 0.00;//�����־�չ�����
		
		double jghj = 0.00;//�ϼ�
		double pghj =0.00;
		double jggy = 0.00;//��ԭ
		double pggy = 0.00;
		double jgsm = 0.00;//ɳĮ
		double pgsm = 0.00;
		double jgkc = 0.00;//����
		double pgkc = 0.00;
		double jgxgrtz = 0.00;//С����
		double pgxgrtz = 0.00;
		double jgzj = 0.00;//�ܼ�
		double pgzj = 0.00;
		/**
		 * ��ѯ����̱� --�Ƿ�ȡС���յ���ϵ��--�ϼƼ����յ���ϵ��--�ϼ���ͨ���յ���ϵ��
		 */
		Gd02_dxgc dxgc= new Gd02_dxgc(); 
		QueryBuilder queryBuilderGd02 = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilderGd02.eq("id", dxgc_id);
		queryBuilderGd02.eq("gcxm_id", gcxm_id);
		ResultObject roGd02 = queryService.search(queryBuilderGd02);
		if(roGd02.next()){
			dxgc = (Gd02_dxgc)roGd02.get(Gd02_dxgc.class.getName());
		}
		
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
		queryBuilder.eq("dxgc_id",dxgc_id);
		queryBuilder.eq("gcxm_id",gcxm_id);
		queryBuilder.addOrderBy(Order.asc("xh"));
		ResultObject ro=queryService.search(queryBuilder);
		
		while(ro.next()){
			Gd05_b3j b3j=(Gd05_b3j)ro.get(Gd05_b3j.class.getName());
			if(b3j!=null){
				if(b3j.getCk_bz()!=null){// ��ѯ����ϵ��
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder1.eq("lb", b3j.getCk_bz());
					queryBuilder1.eq("sort", new Integer(1));//���1���˹��ģ�2�ǻ�е��
					queryBuilder1.ge("jzbh", b3j.getDebh());//������С�ڵ�����ֹ���
					queryBuilder1.le("qsbh", b3j.getDebh());//�����Ŵ��ڵ�����ʼ���
					ResultObject ro1 = queryService.search(queryBuilder1);
					if(ro1.next()){
						Ga09_kcxs ckxs = (Ga09_kcxs)ro1.get(Ga09_kcxs.class.getName());
						if(ckxs!=null){
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//��������ϵ��
						}
					}
				}
				if(b3j.getTzxs()!=null && b3j.getTzxs().doubleValue()!=0.0){
					tzxs=b3j.getTzxs().doubleValue();
				}
				jgsum=NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue), jgsum));
				pgsum=NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),pgsum));
				
				if(b3j.getYj_bz()!=null && b3j.getYj_bz().intValue()==1){//ҹ��ʩ���Ĺ���
					yjjggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),yjjggr);
					yjpggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),yjpggr);
				}
				if(b3j.getDyj_bz()!=null && b3j.getDyj_bz().intValue()==1){//���꼾ʩ���Ĺ���
					dyjggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),dyjggr);
					dypggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),dypggr);
				}
				if(b3j.getGrf_bz()!=null && b3j.getGrf_bz().intValue()==1){//���̸��ŵĹ���
					gcgrjggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),gcgrjggr);
					gcgrpggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),gcgrpggr);
				}
				if(b3j.getTsdq_bz()!=null && b3j.getTsdq_bz().intValue()==1){//��������Ĺ���
					tsbzjggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getJggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),tsbzjggr);
					tsbzpggr = NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(b3j.getPggr().doubleValue(), b3j.getSl().doubleValue()),tzxs),ckxsValue),tsbzpggr);
				}
			}
			tzxs =1.00;
			ckxsValue =1.00;//�����û�1
		}
		jghj = jgsum;//�����ϼ�
		pghj = pgsum;//�չ��ϼ�
		if(dxgc.getB3_sgtj_bz().intValue()==0){// �Ƿ���������
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id",dxgc_id);
			queryBuilder99.eq("gcxm_id",gcxm_id);
			queryBuilder99.eq("fylb",new Integer(1));
			queryBuilder99.eq("bz",new Integer(1));//ȡ��ԭ��
			queryBuilder99.eq("flag", new Integer(1));
			ResultObject ro99 = queryService.search(queryBuilder99);
			Gd10_b3fl data99 = new Gd10_b3fl();
			if(ro99.next()){
				data99 = (Gd10_b3fl)ro99.get(Gd10_b3fl.class.getName());
			}
			if(data99!=null&&data99.getRgfl()!=null){
				jggy = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jghj,data99.getRgfl().doubleValue()),jghj));//���Ը�ԭ��ϵ��
				pggy = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pghj,data99.getRgfl().doubleValue()),pghj));
			}
			
			QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder100.eq("dxgc_id",dxgc_id);
			queryBuilder100.eq("gcxm_id",gcxm_id);
			queryBuilder100.eq("fylb",new Integer(1));
			queryBuilder100.eq("bz",new Integer(2));//ȡɳĮɭ�ֵ�
			queryBuilder100.eq("flag", new Integer(1));
			ResultObject ro100 = queryService.search(queryBuilder100);
			Gd10_b3fl data100 = new Gd10_b3fl();
			if(ro100.next()){
				data100 = (Gd10_b3fl)ro100.get(Gd10_b3fl.class.getName());
			}
			if(data100!=null && data100.getRgfl()!=null){
				jgsm = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jghj, data100.getRgfl().doubleValue()),jghj));//����ɳĮɭ�ֵ�ϵ��
				pgsm = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pghj, data100.getRgfl().doubleValue()),pghj));
			}
		}
		
		zgrSum=NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
				NumberFormatUtil.addToDouble(jghj, jggy),jgsm),pghj),pggy),pgsm);
		if(dxgc.getZy_id().intValue()==1||dxgc.getZy_id().intValue()==2){//����ǹ��߹��̼���С���յ���
			if(dxgc.getXgr_bz()!=null&&dxgc.getXgr_bz().intValue()==0){//0��Ҫ����С���յ���
				if(100<zgrSum&&zgrSum<=250){
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder3 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder3.eq("dxgc_id", dxgc_id);
					queryBuilder3.eq("gcxm_id", gcxm_id);
					queryBuilder3.eq("fylb", new Integer(3));
					queryBuilder3.eq("bz", new Integer(250));
					ResultObject ro3 = queryService.search(queryBuilder3);
					if(ro3.next()){
						xgr = (Gd10_b3fl)ro3.get(Gd10_b3fl.class.getName());
					}
					if(xgr!=null){
						jgxgrtz = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jghj,jggy),jgsm), NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(), 1.0) ));
						pgxgrtz = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(pghj,pggy),pgsm), NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(),1.0)));
					}
				}
				if(zgrSum<=100){
					Gd10_b3fl xgr = new Gd10_b3fl();
					QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd10_b3fl.class);
					queryBuilder2.eq("dxgc_id", dxgc_id);
					queryBuilder2.eq("gcxm_id", gcxm_id);
					queryBuilder2.eq("fylb", new Integer(3));
					queryBuilder2.eq("bz", new Integer(100));
					ResultObject ro2 = queryService.search(queryBuilder2);
					if(ro2.next()){
						xgr = (Gd10_b3fl)ro2.get(Gd10_b3fl.class.getName());
					}
					if(xgr!=null){
						jgxgrtz = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(jghj,jggy),jgsm),  NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(),1.0)));
						pgxgrtz = NumberFormatUtil.roundToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(pghj,pggy),pgsm), NumberFormatUtil.subToDouble(xgr.getRgfl().doubleValue(),1.0)));
					}
				}
			}
		}
		if(dxgc.getGcxz()!=null&&dxgc.getGcxz().intValue()==2){//ȫ���������̹��յ�������
			Gd10_b3fl data99 = new Gd10_b3fl();
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			queryBuilder99.eq("gcxm_id", gcxm_id);
			queryBuilder99.eq("fylb", new Integer(3));
			queryBuilder99.eq("mc", new String("ȫ���������̹��յ�������"));
			ResultObject ro99 = queryService.search(queryBuilder99);
			if(ro99.next()){
				data99 = (Gd10_b3fl)ro99.get(Gd10_b3fl.class.getName());
			}
			if(data99!=null&&data99.getRgfl()!=null){
				jgkc = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(jghj, data99.getRgfl().doubleValue()),jghj));
				pgkc = NumberFormatUtil.roundToDouble(NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(pghj, data99.getRgfl().doubleValue()),pghj));
			}
		}
		/**
		 * ����㼼���ϼƹ��յ���ϵ�� ���չ��ϼƹ��յ���ϵ��
		 */
		double jggr_tzxs = 1.00;// �����ϼƹ��յ���ϵ��
		if(dxgc.getB3_jggr_tzxs()!=null){
			jggr_tzxs=dxgc.getB3_jggr_tzxs().doubleValue();
		}
		double pggr_tzxs = 1.00;//�չ��ϼƹ��յ���ϵ��
		if(dxgc.getB3_pggr_tzxs()!=null){
			pggr_tzxs = dxgc.getB3_pggr_tzxs().doubleValue();
		}
		jgzj = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
				NumberFormatUtil.addToDouble(jghj, jggy),jgsm),jgxgrtz),jgkc),jggr_tzxs);
		pgzj = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(
				NumberFormatUtil.addToDouble(pghj, pggy),pgsm),pgxgrtz),pgkc),pggr_tzxs);
		
		Gd03_gcfysz data9 =new Gd03_gcfysz(); 
		QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder9.eq("dxgc_id", dxgc_id);
		queryBuilder9.eq("gcxm_id", gcxm_id);
		ResultObject ro9 = queryService.search(queryBuilder9);
		while(ro9.next()){
			data9 = (Gd03_gcfysz)ro9.get(Gd03_gcfysz.class.getName());
			if(data9!=null){
				if(data9.getFymc().equals("�����ܹ���")){
					data9.setFyz(new Double(jgzj));
				}else if(data9.getFymc().equals("�չ��ܹ���")){
					data9.setFyz(new Double(pgzj));
				}else if(data9.getFymc().equals("ҹ�似������")){
					data9.setFyz(new Double(yjjggr));
				}else if(data9.getFymc().equals("ҹ���չ�����")){
					data9.setFyz(new Double(yjpggr));
				}else if(data9.getFymc().equals("���꼾ʩ����������")){
					data9.setFyz(new Double(dyjggr));
				}else if(data9.getFymc().equals("���꼾ʩ���չ�����")){
					data9.setFyz(new Double(dypggr));
				}else if(data9.getFymc().equals("���̸��ż�������")){
					data9.setFyz(new Double(gcgrjggr));
				}else if(data9.getFymc().equals("���̸����չ�����")){
					data9.setFyz(new Double(gcgrpggr));
				}else if(data9.getFymc().equals("���������������")){
					data9.setFyz(new Double(tsbzjggr));
				}else if(data9.getFymc().equals("��������չ�����")){
					data9.setFyz(new Double(tsbzpggr));
				}
				saveService.save(data9);
			}
		}
		
	}	
	/**
	 * ����������ɻ�е���Ǳ����ģ��豸�Զ�����
	 * @throws Exception 
	 */
	public void DeAssociated(Integer dxgc_id,Integer gcxm_id,Integer glzc,Integer glsb,Integer gljx,Integer glyb) throws Exception{
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
			Gd02_dxgc dxgc = new Gd02_dxgc();//����̱�
			QueryBuilder queryBuider = new HibernateQueryBuilder(Gd02_dxgc.class);
			queryBuider.eq("id", dxgc_id);
			queryBuider.eq("gcxm_id", gcxm_id);
			ResultObject ro3 =queryService.search(queryBuider);
			if(ro3.next()){
				dxgc = (Gd02_dxgc)ro3.get(Gd02_dxgc.class.getName());
			}
			QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd05_b3j.class);
			queryBuilder.eq("dxgc_id", dxgc_id);
			queryBuilder.eq("gcxm_id", gcxm_id);
			ResultObject ro= queryService.search(queryBuilder);
			while(ro.next()){
				Gd05_b3j b3j = new Gd05_b3j();
				b3j= (Gd05_b3j)ro.get(Gd05_b3j.class.getName());
				if(b3j!=null){
					QueryBuilder queryBuilder1= new HibernateQueryBuilder(Ga03_glcl.class);
					queryBuilder1.eq("de_bh",b3j.getDebh());
					ResultObject ro1 = queryService.search(queryBuilder1);
					while(ro1.next()){
						Ga03_glcl ga03 = new Ga03_glcl();
						if(ga03!=null){
							ga03=(Ga03_glcl)ro1.get(Ga03_glcl.class.getName());
							QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Ga02_clsb.class);
							queryBuilder2.eq("bh",ga03.getCl_bh());
							ResultObject ro2 = queryService.search(queryBuilder2);
							 if(ro2.next()){
								Ga02_clsb ga02 = new Ga02_clsb();
								ga02=(Ga02_clsb)ro2.get(Ga02_clsb.class.getName());
								
								if(ga02.getLb().equals("JX")){//����ǻ�е��
									
									if(gljx.intValue()==1){//���������е�Զ�����
										Gd06_b3y b3y = new Gd06_b3y();
										QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd06_b3y.class);
										queryBuilder9.eq("gcxm_id", gcxm_id);
										queryBuilder9.eq("dxgc_id", dxgc_id);
										queryBuilder9.eq("b3j_id",b3j.getId());
										queryBuilder9.eq("bh",ga02.getBh());
										ResultObject ro9 = queryService.search(queryBuilder9);
										if(ro9.next()){
											b3y = (Gd06_b3y)ro9.get(Gd06_b3y.class.getName());
										}
										if(b3y.getId()!=null){
											b3y.setB3j_id(b3j.getId());
											b3y.setGcxm_id(gcxm_id);
											b3y.setDxgc_id(dxgc_id);
											//�������ڶ����������Բ�������
											b3y.setGlsl(ga03.getClsl());
											b3y.setBh(ga02.getBh());
											b3y.setMc(ga02.getMc());
											b3y.setXhgg(ga02.getXhgg());
											b3y.setDw(ga02.getDw());
											if(dxgc.getB3_jxjg().equals("BDJ")){
												b3y.setDj(ga02.getBdj());
											}else if(dxgc.getB3_jxjg().equals("BSJ")){
												b3y.setDj(ga02.getBsj());
											}else if(dxgc.getB3_jxjg().equals("QGJ")){
												b3y.setDj(ga02.getQgj());
											}else if(dxgc.getB3_jxjg().equals("YSJ")){
												b3y.setDj(ga02.getYsj());
											}			
											b3y.setLb(ga02.getLb());
											if(b3y!=null){
												session.update(b3y);
											}
										}else{
											b3y.setB3j_id(b3j.getId());
											b3y.setGcxm_id(gcxm_id);
											b3y.setDxgc_id(dxgc_id);
											//�������ڶ����������Բ�������
											b3y.setGlsl(ga03.getClsl());
											b3y.setBh(ga02.getBh());
											b3y.setMc(ga02.getMc());
											b3y.setXhgg(ga02.getXhgg());
											b3y.setDw(ga02.getDw());
											if(dxgc.getB3_jxjg().equals("BDJ")){
												b3y.setDj(ga02.getBdj());
											}else if(dxgc.getB3_jxjg().equals("BSJ")){
												b3y.setDj(ga02.getBsj());
											}else if(dxgc.getB3_jxjg().equals("QGJ")){
												b3y.setDj(ga02.getQgj());
											}else if(dxgc.getB3_jxjg().equals("YSJ")){
												b3y.setDj(ga02.getYsj());
											}
											b3y.setTzxs(new Double(1.00));
											b3y.setLb(ga02.getLb());
											if(b3y!=null){
												session.saveOrUpdate(b3y);
											}
										}										
									}
								}
								if(ga02.getLb().equals("YB")){//������Ǳ��						
									if(glyb.intValue()==1){//��������Ǳ��Զ�����
										Gd06_b3y b3y = new Gd06_b3y();
										QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd06_b3y.class);
										queryBuilder9.eq("gcxm_id", gcxm_id);
										queryBuilder9.eq("dxgc_id", dxgc_id);
										queryBuilder9.eq("b3j_id",b3j.getId());
										queryBuilder9.eq("bh",ga02.getBh());
										ResultObject ro9 = queryService.search(queryBuilder9);
										if(ro9.next()){
											b3y = (Gd06_b3y)ro9.get(Gd06_b3y.class.getName());
										}
										if(b3y.getId()!=null){
											b3y.setB3j_id(b3j.getId());
											b3y.setGcxm_id(gcxm_id);
											b3y.setDxgc_id(dxgc_id);
											b3y.setGlsl(ga03.getClsl());
											b3y.setBh(ga02.getBh());
											b3y.setMc(ga02.getMc());
											b3y.setXhgg(ga02.getXhgg());
											b3y.setDw(ga02.getDw());
											if(dxgc.getB3_jxjg().equals("BDJ")){
												b3y.setDj(ga02.getBdj());
											}else if(dxgc.getB3_jxjg().equals("BSJ")){
												b3y.setDj(ga02.getBsj());
											}else if(dxgc.getB3_jxjg().equals("QGJ")){
												b3y.setDj(ga02.getQgj());
											}else if(dxgc.getB3_jxjg().equals("YSJ")){
												b3y.setDj(ga02.getYsj());
											}	
											b3y.setLb(ga02.getLb());
											if(b3y!=null){
												session.update(b3y);
											}
										}else{
											b3y.setB3j_id(b3j.getId());
											b3y.setGcxm_id(gcxm_id);
											b3y.setDxgc_id(dxgc_id);
											//�������ڶ����������Բ�������
											b3y.setGlsl(ga03.getClsl());
											b3y.setBh(ga02.getBh());
											b3y.setMc(ga02.getMc());
											b3y.setXhgg(ga02.getXhgg());
											b3y.setDw(ga02.getDw());
											if(dxgc.getB3_jxjg().equals("BDJ")){
												b3y.setDj(ga02.getBdj());
											}else if(dxgc.getB3_jxjg().equals("BSJ")){
												b3y.setDj(ga02.getBsj());
											}else if(dxgc.getB3_jxjg().equals("QGJ")){
												b3y.setDj(ga02.getQgj());
											}else if(dxgc.getB3_jxjg().equals("YSJ")){
												b3y.setDj(ga02.getYsj());
											}	
											b3y.setTzxs(new Double(1.00));
											b3y.setLb(ga02.getLb());
											if(b3y!=null){
												session.saveOrUpdate(b3y);
											}
										}
									}
								}
								//���������
								/**
								if(ga02.getLb().equals("ZC")){
									if(glzc.intValue()==1){
//										Gd07_b4 b4 = new Gd07_b4();
//										QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd07_b4.class);
//										queryBuilder99.eq("gcxm_id", gcxm_id);
//										queryBuilder99.eq("dxgc_id", dxgc_id);
//										queryBuilder99.eq("bgbh", new String("B4JZC"));
//										ResultObject ro99 = queryService.search(queryBuilder99);
//										while(ro99.next()){
//											b4 = (Gd07_b4)ro99.get(Gd07_b4.class.getName());
//											if(b4.getId()!=null){
//												session.delete(b4);//��ɾ���ٲ���
//											}
//										}
										session.createSQLQuery("delete from Gd07_b4 gd07 where gcxm_id="+gcxm_id+" dxgc_id="+dxgc_id+" bgbh='"+new String("B4JZC")+"'");
										Gd07_b4 b4j = new Gd07_b4();
										b4j.setGcxm_id(gcxm_id);
										b4j.setDxgc_id(dxgc_id);
										b4j.setSl(new Double(NumberFormatUtil.mulToDouble(ga03.getClsl().doubleValue(),b3j.getSl().doubleValue())));
										b4j.setBh(ga02.getBh());
										b4j.setMc(ga02.getMc());
										b4j.setXhgg(ga02.getXhgg());
										b4j.setDw(ga02.getDw());
										if(dxgc.getB4_zcjg()!=null){
											if(dxgc.getB4_zcjg().equals("BDJ")){
												b4j.setDj(ga02.getBdj());
											}else if(dxgc.getB4_zcjg().equals("BSJ")){
												b4j.setDj(ga02.getBsj());
											}else if(dxgc.getB4_zcjg().equals("QGJ")){
												b4j.setDj(ga02.getQgj());
											}else if(dxgc.getB4_zcjg().equals("YSJ")){
												b4j.setDj(ga02.getYsj());
											}
										}
										b4j.setZclb(ga02.getZclb());
										b4j.setTzxs(new Double(1.00));
										b4j.setBgbh(new String("B4JZC"));
										b4j.setXh(null);
										b4j.setId(null);
										session.merge(b4j);
									}
								}
							*/
							/**
								//������豸
								if(ga02.getLb().equals("SB")){
									if(glsb.intValue()==1){
//										Gd07_b4 b4 = new Gd07_b4();
//										QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd07_b4.class);
//										queryBuilder99.eq("gcxm_id", gcxm_id);
//										queryBuilder99.eq("dxgc_id", dxgc_id);
//										queryBuilder99.eq("bgbh", new String("B4JXASB"));
//										ResultObject ro99 = queryService.search(queryBuilder99);
//										while(ro99.next()){
//											b4 = (Gd07_b4)ro99.get(Gd07_b4.class.getName());
//											if(b4.getId()!=null){
//												session.delete(b4);//��ɾ���ٲ���
//											}
//										}
										session.createSQLQuery("delete from Gd07_b4 gd07 where gcxm_id="+gcxm_id+" dxgc_id="+dxgc_id+" bgbh='"+new String("B4JXASB")+"'");
										
										Gd07_b4 b4j = new Gd07_b4();
										b4j.setGcxm_id(gcxm_id);
										b4j.setDxgc_id(dxgc_id);
										b4j.setSl(new Double(NumberFormatUtil.mulToDouble(ga03.getClsl().doubleValue(),b3j.getSl().doubleValue())));
										b4j.setBh(ga02.getBh());
										b4j.setMc(ga02.getMc());
										b4j.setXhgg(ga02.getXhgg());
										b4j.setDw(ga02.getDw());
										if(dxgc.getB4_sbjg()!=null){
											if(dxgc.getB4_sbjg().equals("BDJ")){
												b4j.setDj(ga02.getBdj());
											}else if(dxgc.getB4_sbjg().equals("BSJ")){
												b4j.setDj(ga02.getBsj());
											}else if(dxgc.getB4_sbjg().equals("QGJ")){
												b4j.setDj(ga02.getQgj());
											}else if(dxgc.getB4_sbjg().equals("YSJ")){
												b4j.setDj(ga02.getYsj());
											}
										}
										b4j.setZclb(ga02.getZclb());
										b4j.setTzxs(new Double(1.00));
										b4j.setBgbh(new String("B4JXASB"));
										b4j.setXh(null);
										session.merge(b4j);
									}
								}
								*/
							 }					
						}
					}
				}
			}
			//ɾ����Gd05_b3jû�еĶ��� ������Gd06_b3y�ж���id  (��е,�Ǳ�)
			QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd06_b3y.class);
			queryBuilder99.eq("gcxm_id", gcxm_id);
			queryBuilder99.eq("dxgc_id", dxgc_id);
			ResultObject ro99 =queryService.search(queryBuilder99);
			while(ro99.next()){
				Gd06_b3y data99= new Gd06_b3y();
				data99 = (Gd06_b3y)ro99.get(Gd06_b3y.class.getName());
				if(data99.getId()!=null){
					QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Gd05_b3j.class);
					queryBuilder100.eq("gcxm_id", gcxm_id);
					queryBuilder100.eq("dxgc_id", dxgc_id);
					queryBuilder100.eq("id", data99.getB3j_id());
					ResultObject ro100 = queryService.search(queryBuilder100);
					if(ro100.getLength()==0){
						session.delete(data99);//ɾ������
					}
				}
			}
			//ǰ����õĵط���������ȥ��
//			if(gljx.intValue()==1){//���������е�Զ����ɵ��ñ����Ҽ���
//				B3yCalculate(dxgc_id,gcxm_id);
//			}
//			if(glyb.intValue()==1){//��������Ǳ��Զ����ɵ��ñ���������
//				 B3bCalculate(dxgc_id,gcxm_id);
//			}
			session.flush();
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " �������! ");
		} finally {
			session.close();
		}
	}
	
	/**
	 * �����Ҽ���
	 * @param dxgc_id
	 * @param gcxm_id
	 */
	public void B3yCalculate(Integer dxgc_id,Integer gcxm_id){
		double ckxsValue = 1.00;//����ϵ��
		double tzxs = 1.00;//����ϵ��
		double jxhjtzxs = 1.00;//��еʹ�÷Ѻϼ�ֵ����ϵ��
		double gydqtzxs = 1.00;//��ԭ������е����ϵ��
		double slsmtzxs = 1.00;//ɭ��ɳĮ������е����ϵ��
		double jxsyf = 0.00; //��еʹ�÷�
		double hj = 0.00;//�ϼ�
		double zj = 0.00;//�ܼ�
		double gy = 0.00;//��ԭ����
		double sm = 0.00;//ɳĮ����
		//����̱��ѯ�ϼƵ���ϵ����
		Gd02_dxgc dxgc= new Gd02_dxgc();
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("id", dxgc_id);
		queryBuilder.eq("gcxm_id", gcxm_id);
		ResultObject ro = queryService.search(queryBuilder);
		if(ro.next()){
			dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
		}
		
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id", dxgc_id);
		queryBuilder1.eq("gcxm_id", gcxm_id);
		queryBuilder1.eq("lb", new String("JX"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		Gd06_b3y b3y = new Gd06_b3y();
		while(ro1.next()){
			b3y = (Gd06_b3y)ro1.get(Gd06_b3y.class.getName());
			if(b3y!=null){
				QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd05_b3j.class);
				queryBuilder2.eq("dxgc_id", dxgc_id);
				queryBuilder2.eq("gcxm_id", gcxm_id);
				queryBuilder2.eq("id", b3y.getB3j_id());
				ResultObject ro2 = queryService.search(queryBuilder2);
				Gd05_b3j b3j = new Gd05_b3j();
				if(ro2.next()){
					b3j = (Gd05_b3j)ro2.get(Gd05_b3j.class.getName());
				}
				if(b3y.getTzxs()!=null && b3y.getTzxs().doubleValue()!=0.0){
					tzxs=b3y.getTzxs().doubleValue();
				}
				double sl=0.0;
				if(b3j.getSl()!=null){
					sl=b3j.getSl().doubleValue();
				}
				//-----------------------------------------------------------------------
				if(b3j.getCk_bz()!=null){// ��ѯ����ϵ��
					QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Ga09_kcxs.class);
					queryBuilder99.eq("lb", b3j.getCk_bz());
					queryBuilder99.eq("sort", new Integer(2));//���1���˹��ģ�2�ǻ�е��
					queryBuilder99.ge("jzbh", b3j.getDebh());//������С�ڵ�����ֹ���
					queryBuilder99.le("qsbh", b3j.getDebh());//�����Ŵ��ڵ�����ʼ���
					ResultObject ro99 = queryService.search(queryBuilder99);
					if(ro99.next()){
						Ga09_kcxs ckxs = (Ga09_kcxs)ro99.get(Ga09_kcxs.class.getName());
						if(ckxs!=null){
							ckxsValue=NumberFormatUtil.divToDouble(ckxs.getXs().doubleValue(), 100);//��������ϵ��
						}
					}
				}
				//-----------------------------------------------------------------------
				jxsyf =NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(sl, b3y.getGlsl().doubleValue()),b3y.getDj().doubleValue()),tzxs),ckxsValue),jxsyf);//�����ϲ���ϵ��
			}
			tzxs=1.00;//�����ûأ�
		}
		hj = jxsyf;
		if(dxgc.getB3_jxf_tzxs()!=null){//��еʹ�÷ѺϼƵ���ϵ��
			jxhjtzxs = dxgc.getB3_jxf_tzxs().doubleValue();
		}
		if(dxgc.getB3_sgtj_bz().intValue()==0){// �Ƿ���������
			QueryBuilder queryBuilder12 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder12.eq("gcxm_id",gcxm_id);
			queryBuilder12.eq("dxgc_id",dxgc_id);
			queryBuilder12.eq("fylb",new Integer(1));
			queryBuilder12.eq("bz",new Integer(1));//ȡ��ԭ��
			queryBuilder12.eq("flag", new Integer(1));
			ResultObject ro12= queryService.search(queryBuilder12);
			Gd10_b3fl data12= new Gd10_b3fl();
			if(ro12.next()){
				data12 = (Gd10_b3fl)ro12.get(Gd10_b3fl.class.getName());
			}
			if(data12.getDxgc_id()!=null){
				gydqtzxs = data12.getJxfl().doubleValue();
				gy = NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(hj, gydqtzxs),hj);
			}

			QueryBuilder queryBuilder13 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder13.eq("gcxm_id",gcxm_id);
			queryBuilder13.eq("dxgc_id",dxgc_id);
			queryBuilder13.eq("fylb",new Integer(1));
			queryBuilder13.eq("bz" ,new Integer(2));//ȡɳĮɭ�ֵ�
			queryBuilder13.eq("flag", new Integer(1));
			ResultObject ro13 = queryService.search(queryBuilder13);
			Gd10_b3fl data13 = new Gd10_b3fl();
			if(ro13.next()){
			 	data13 = (Gd10_b3fl)ro13.get(Gd10_b3fl.class.getName());
			}
			if(data13.getDxgc_id()!=null){
				slsmtzxs = data13.getJxfl().doubleValue();
				sm = NumberFormatUtil.subToDouble(NumberFormatUtil.mulToDouble(hj, slsmtzxs),hj);
			}
		}
		zj = NumberFormatUtil.mulToDouble(NumberFormatUtil.addToDouble(NumberFormatUtil.addToDouble(hj,gy),sm),jxhjtzxs);
		
		Gd03_gcfysz data9 =new Gd03_gcfysz(); 
		QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder9.eq("dxgc_id", dxgc_id);
		queryBuilder9.eq("gcxm_id", gcxm_id);
		queryBuilder9.eq("fymc", "��еʹ�÷�");
		ResultObject ro9 = queryService.search(queryBuilder9);
		if(ro9.next()){
			data9 = (Gd03_gcfysz)ro9.get(Gd03_gcfysz.class.getName());
		}
		if(data9.getDxgc_id()!=null){
			data9.setFyz(new Double(zj));
			saveService.save(data9);
		}
	}
	/**
	 * ����������
	 * @param dxgc_id������̣ɣ�
	 * @param gcxm_id��������Ŀ�ɣ�
	 */
	public void B3bCalculate(Integer dxgc_id,Integer gcxm_id){
		double tzxs = 1.00;//����ϵ��
		double ybhjtzxs =1.00;//�Ǳ�ϼƵ���ϵ��
		double ybsyf= 0.00;//�Ǳ�ʹ�÷�
		
		//����̱��ѯ�ϼƵ���ϵ����
		Gd02_dxgc dxgc= new Gd02_dxgc();
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("id", dxgc_id);
		queryBuilder.eq("gcxm_id", gcxm_id);
		ResultObject ro = queryService.search(queryBuilder);
		if(ro.next()){
			dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
		}
		
		QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd06_b3y.class);
		queryBuilder1.eq("dxgc_id", dxgc_id);
		queryBuilder1.eq("gcxm_id", gcxm_id);
		queryBuilder1.eq("lb", new String("YB"));
		ResultObject ro1 = queryService.search(queryBuilder1);
		Gd06_b3y b3y = new Gd06_b3y();
		while(ro1.next()){
			b3y = (Gd06_b3y)ro1.get(Gd06_b3y.class.getName());
			if(b3y!=null){
				QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gd05_b3j.class);
				queryBuilder2.eq("dxgc_id", dxgc_id);
				queryBuilder2.eq("gcxm_id", gcxm_id);
				queryBuilder2.eq("id", b3y.getB3j_id());
				ResultObject ro2 = queryService.search(queryBuilder2);
				Gd05_b3j b3j = new Gd05_b3j();
				if(ro2.next()){
					b3j = (Gd05_b3j)ro2.get(Gd05_b3j.class.getName());
				}
				if(b3y.getTzxs()!=null && b3y.getTzxs().doubleValue()!=0.0){
					tzxs=b3y.getTzxs().doubleValue();
				}
				ybsyf =NumberFormatUtil.addToDouble(NumberFormatUtil.mulToDouble(NumberFormatUtil.mulToDouble(
						NumberFormatUtil.mulToDouble(b3j.getSl().doubleValue(), b3y.getGlsl().doubleValue()),b3y.getDj().doubleValue()),tzxs),ybsyf);
			}
			tzxs=1.00;//�����ûأ�
		}
		
		if(dxgc.getB3_ybf_tzxs()!=null){
			ybhjtzxs = dxgc.getB3_ybf_tzxs().doubleValue();
			ybsyf = NumberFormatUtil.mulToDouble(ybsyf, ybhjtzxs);//���Ե���ϵ��
		}
		
		Gd03_gcfysz data9 =new Gd03_gcfysz(); 
		QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder9.eq("dxgc_id", dxgc_id);
		queryBuilder9.eq("gcxm_id", gcxm_id);
		queryBuilder9.eq("fymc", "�����Ǳ�ʹ�÷�");
		ResultObject ro9 = queryService.search(queryBuilder9);
		if(ro9.next()){
			data9 = (Gd03_gcfysz)ro9.get(Gd03_gcfysz.class.getName());
		}
		if(data9!=null){
			data9.setFyz(new Double(ybsyf));
			saveService.save(data9);
		}
	}
	/**
	 * ��4�׷��ü���-����
	 */
	public void B4CalculateAll(Integer gcxm_id,Integer dxgc_id) {
		ResultObject gd02Rs = queryService.search("select gd02.bgxd from Gd02_dxgc gd02 where id ="+dxgc_id);
      	String bgxd="-1";
        if(gd02Rs.next())
        	bgxd=(String)gd02Rs.get("gd02.bgxd");
        ResultObject bgRs = queryService.search("select gb03.id from Gb03_bgxx gb03 where sxh in ("+bgxd+") and bgbh like 'B4J%'");
        while(bgRs.next())
        	B4Calculate(gcxm_id,dxgc_id,(Integer)bgRs.get("gb03.id"));
	}
	/**
	 * ��4�׷��ü���-����
	 */
	public void B4Calculate(Integer gcxm_id,Integer dxgc_id,Integer bgxx_id){
		HashMap flhj = new HashMap();//��4����ϼ�
		boolean NEEDFL = true;//�Ƿ���Ҫ�������
		double listTotal=0;//��ϸ�ܼ�
		double fyTotal=0;//�����ܼ�
		double nosjTotal=0;//��ȡ˰���ܼ�
		//��ȡ�����Ϣ
		Gb03_bgxx bgbhInfo = null;
		ResultObject bgxxRs = queryService.search("select gb03 from Gb03_bgxx gb03 where id="+bgxx_id);
		bgxxRs.next();
		bgbhInfo = (Gb03_bgxx)bgxxRs.get("gb03");
		//��4����ǿձ�ʾ��ǰ�������(�������̱������豸���������ı�)����3������Ҫ������ط���
		if(bgbhInfo.getBgbh().indexOf("B4J")!=0)
			NEEDFL = false;
		

		//������ϸ�ϼ�
		ResultObject listRs = queryService.search("select gd07 from Gd07_b4 gd07 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'");
		while(listRs.next()){
			Gd07_b4 gd07 = (Gd07_b4)listRs.get("gd07");
			double temphj = NumberFormatUtil.mulToDouble(gd07.getSl().doubleValue(), gd07.getDj().doubleValue());
			if(gd07.getTzxs()!=null)
				temphj = NumberFormatUtil.mulToDouble(temphj, gd07.getTzxs().doubleValue());
			listTotal = NumberFormatUtil.addToDouble(listTotal, temphj);
			if(gd07.getSj_bz()!=null&&gd07.getSj_bz().intValue()==1){
				ResultObject flhjRs = queryService.search("select sum(flz) from Gd04_clfysz where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"' and zclb='"+gd07.getZclb()+"'");
				flhjRs.next();
				double hj = ((Double)flhjRs.get("sum(flz)")).doubleValue();
				nosjTotal = NumberFormatUtil.addToDouble(nosjTotal, NumberFormatUtil.addToDouble(temphj, NumberFormatUtil.mulToDouble(temphj, NumberFormatUtil.divToDouble(hj, 100,4))));
			}	
			if(NEEDFL){
				if(flhj.containsKey(gd07.getZclb()))
					flhj.put(gd07.getZclb(), new Double(NumberFormatUtil.addToDouble(((Double)flhj.get(gd07.getZclb())).doubleValue(), temphj)));
				else
					flhj.put(gd07.getZclb(), new Double(temphj));
			}
		}
		//������ط���
		if(NEEDFL){
			saveService.updateByHSql("update Gd04_clfysz set flhjz=null,fyz=null where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'");
			ResultObject fyRs = queryService.search("select gd04 from Gd04_clfysz gd04 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"' order by zclb,fy_id");
			while(fyRs.next()){
				Gd04_clfysz gd04 = (Gd04_clfysz)fyRs.get("gd04");
				if(flhj.containsKey(gd04.getZclb())){	
					gd04.setFlhjz(new Double(NumberFormatUtil.roundToDouble((Double)flhj.get(gd04.getZclb()))));
					if(gd04.getFlz().doubleValue()>0){
						double tempfyz = NumberFormatUtil.mulToDouble(gd04.getFlhjz().doubleValue(),NumberFormatUtil.divToDouble(gd04.getFlz().doubleValue(),100,4));
						gd04.setFyz(new Double(NumberFormatUtil.roundToDouble(tempfyz)));
						fyTotal = NumberFormatUtil.addToDouble(fyTotal, tempfyz);
					}
					saveService.save(gd04);
				}
			}
		}
		//���¹��̷���
		if(NEEDFL){
			if(bgbhInfo.getBgbh().equals("B4JZC"))
				saveService.updateByHSql("update Gd03_gcfysz set fyz="+NumberFormatUtil.roundToDouble(nosjTotal)+" where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='B4ZCBQSJ'");
			saveService.updateByHSql("update Gd03_gcfysz set fyz="+NumberFormatUtil.roundToDouble(NumberFormatUtil.addToDouble(listTotal, fyTotal))+" where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'");
		}else{
			saveService.updateByHSql("update Gd03_gcfysz set fyz="+NumberFormatUtil.roundToDouble(listTotal)+" where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'");
		}
	}

	/**
	 * ��4�ײ��Ϻϲ�
	 */
	public void B4Merger(Integer gcxm_id, Integer dxgc_id, Integer bgxx_id,String[] fields) {
		// TODO Auto-generated method stub
		Gb03_bgxx bgbhInfo = null;
		ResultObject bgxxRs = queryService.search("select gb03 from Gb03_bgxx gb03 where id="+bgxx_id);
		bgxxRs.next();
		bgbhInfo = (Gb03_bgxx)bgxxRs.get("gb03");
		
		saveService.updateByHSql("update Gd07_b4 set xh=-1 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'");
		
		HashMap term = null;
		String f = "";
		for(int i=0;i<fields.length;i++)
			f+=fields[i]+",";
		f=f.substring(0,f.length()-1);
		
		
		String hsql = "select sum(sl)," + f;
		hsql += " from Gd07_b4 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"'";
		hsql += " group by " + f + " order by " + f;
		ResultObject rs = queryService.search(hsql); 
		Gd07_b4 data = null;
		while(rs.next()){
			term = new HashMap();
			data = new Gd07_b4();
			data.setGcxm_id(gcxm_id);
			data.setDxgc_id(dxgc_id);
			data.setSl((Double)rs.get("sum(sl)"));
			data.setBgbh(bgbhInfo.getBgbh());
			data.setSj_bz(new Integer(0));
			data.setTzxs(new Double(1.0));
			for(int j=0;j<fields.length;j++){
				Object obj = rs.get(fields[j]);
				if(obj==null){
					term.put(fields[j], " is null");
				}else{
					if(obj instanceof Double)
						term.put(fields[j], "="+((Double)obj).toString());
					else
						term.put(fields[j], "='"+(String)obj+"'");
				}

			}
			Gd07_b4 tmp = getClsbInfo(gcxm_id,dxgc_id,bgbhInfo.getBgbh(),term);
			if(tmp.getId()!=null){
				data.setBh(tmp.getBh());
				data.setMc(tmp.getMc());
				data.setXhgg(tmp.getXhgg());
				data.setDw(tmp.getDw());
				data.setDj(tmp.getDj());
				data.setZclb(tmp.getZclb());
			}
			saveService.save(data);
		}
		saveService.updateByHSql("delete from Gd07_b4 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbhInfo.getBgbh()+"' and xh=-1");
	}
	public Gd07_b4 getClsbInfo(Integer gcxm_id, Integer dxgc_id,String bgbh,HashMap term){
		Gd07_b4 result = new Gd07_b4();
		String hsql = "select id,bh,mc,xhgg,dw,dj,zclb from Gd07_b4 where gcxm_id="+gcxm_id+" and dxgc_id="+dxgc_id+" and bgbh='"+bgbh+"'";
		Iterator keys = term.keySet().iterator();
		while(keys.hasNext()){
			String tt = keys.next().toString();
			hsql += " and " + tt + term.get(tt).toString();
		}
		ResultObject rs = queryService.search(hsql);
		if(rs.next()){
			result.setId((Integer)rs.get("id"));
			result.setBh((String)rs.get("bh"));
			result.setMc((String)rs.get("mc"));
			result.setXhgg((String)rs.get("xhgg"));
			result.setDw((String)rs.get("dw"));
			result.setDj((Double)rs.get("dj"));
			result.setZclb((String)rs.get("zclb"));
		}
		return result;
	}
	/**
	 * ���㽨�赥λ�����
	 * @param dxgc_id �����id
	 * @return number �����ܸ���
	 */
	public String JSDWGLFCalculate(Integer dxgc_id,String number){
		if(number==null||number.equals("")){
			number="0.0";
		}
		QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
		queryBuilder.eq("id", dxgc_id);
		ResultObject ro99 = queryService.search(queryBuilder);
		Gd02_dxgc data2= new Gd02_dxgc();
		if(ro99.next()){
			data2 = (Gd02_dxgc)ro99.get(Gd02_dxgc.class.getName());
		}
			
		String flz = "0";
		Ga05_fy ga05;
		Ga08_flmx ga08;
		String HSql = "select ga05,ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.gcflbz = 1 and ga08.flk_id = "
			+ data2.getFlk_id() + " and ga05.id = '" + new Integer(71) + "'";
		ResultObject ro9 = queryService.search(HSql);
		while (ro9.next()) {
			ga05 = (Ga05_fy) ro9.get("ga05");
			ga08 = (Ga08_flmx) ro9.get("ga08");
			/**
			 * ��ʼ��Ĭ�Ϸ���ֵ
			 */
			flz= ga08.getFlz().toString();
			/**
			 * ����רҵ��ط���
			 */
			if (ga08.getZy_id() != null && ga08.getQj_id() == null && ga08.getZclb() == null) {
				HSql = "select ga08 from Ga05_fy ga05,Ga08_flmx ga08 where ga05.id = ga08.fy_id and ga08.flk_id = " + data2.getFlk_id()
						+ " and ga08.zy_id = '" + data2.getZy_id() + "' and ga05.id = " + ga05.getId();
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
			if (ga05.getMc().equals("���赥λ�����")) {
			
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " and ga07.sx is null";
				ResultObject ro2 = queryService.search(HSql);
				ro2.next();
				HSql = "select ga08,ga07 from Ga08_flmx ga08,Ga07_qfqj ga07 where ga08.qj_id = ga07.id and ga08.fy_id = " + ga05.getId()
						+ " order by ga07.xx asc";
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
		return NumberFormatUtil.roundToString(flz, 2);
	}
}
