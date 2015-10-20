package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga05_fy;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.dataObject.Gd05_b3j;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.CalculateService;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * �����3
 * @author CT
 * @create 2009-05-04
 */
public class SaveB3 implements Controller {

	private QueryService queryService;

	private SaveService saveService;
	
	private CalculateService calculateService;
	
	private ExpenseService expenseService;

	private Gd02_dxgc data1 = new Gd02_dxgc();

	private Gd10_b3fl data2 = new Gd10_b3fl();

	private Gd10_b3fl data3 = new Gd10_b3fl();

	public SaveService getSaveService() {
		return saveService;
	}
	public void setExpenseService(ExpenseService expenseService) {
		this.expenseService = expenseService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public QueryService getQueryService() {
		return queryService;
	}

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
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
			// TODO Auto-generated method stub
			request.setCharacterEncoding("GBK");
			Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
			Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
			QueryBuilder queryBuilder1 = new HibernateQueryBuilder(
					Gd02_dxgc.class);// ��ѯ�ۺ���Ϣ����ʩ�������Ƿ�������
			queryBuilder1.eq("gcxm_id", gcxm_id);
			queryBuilder1.eq("id", dxgc_id);
			ResultObject ro1 = queryService.search(queryBuilder1);
			if (ro1.next()) {
				data1 = (Gd02_dxgc) ro1.get(Gd02_dxgc.class.getName());
			}
			if (request.getParameter("xgr_bz") != null) {
				data1.setXgr_bz(new Integer(request.getParameter("xgr_bz")));
			} else {
				data1.setXgr_bz(new Integer(0));
			}
			
			if (!request.getParameter("jghj").equals("")) {
				data1.setB3_jggr_tzxs(new Double(request.getParameter("jghj")));
			}
			if (!request.getParameter("pghj").equals("")) {
				data1.setB3_pggr_tzxs(new Double(request.getParameter("pghj")));
			}
			if(request.getParameter("B4_ZCJG")!=null &&!request.getParameter("B4_ZCJG").equals("")){
				data1.setB4_zcjg(request.getParameter("B4_ZCJG"));
			}
			if(request.getParameter("B4_SBJG")!=null && !request.getParameter("B4_SBJG").equals("")){
				data1.setB4_sbjg(request.getParameter("B4_SBJG"));
			}
			if(request.getParameter("B4_JXJG")!=null && !request.getParameter("B4_JXJG").equals("")){
				data1.setB3_jxjg(request.getParameter("B4_JXJG"));
			}
			if(request.getParameter("B4_YBJG")!=null && !request.getParameter("B4_YBJG").equals("")){
				data1.setB3_ybjg(request.getParameter("B4_YBJG"));
			}
			session.saveOrUpdate(data1);// ��GD02
			
			Gd10_b3fl data99 = new Gd10_b3fl();//ȫ���������̹��յ�������
			if(data1.getGcxz()!=null&&data1.getGcxz().intValue()==2){
				QueryBuilder queryBuilder99  = new HibernateQueryBuilder(Gd10_b3fl.class);
				queryBuilder99.eq("gcxm_id", gcxm_id);
				queryBuilder99.eq("dxgc_id", dxgc_id);
				queryBuilder99.eq("mc", new String("ȫ���������̹��յ�������"));
				queryBuilder99.eq("fylb", new Integer(3));
				ResultObject ro99 = queryService.search(queryBuilder99);
				if(ro99.next()){
					data99 = (Gd10_b3fl)ro99.get(Gd10_b3fl.class.getName());
				}
				if(data99!=null){
					if(request.getParameter("qbkjgc")!=null){
						data99.setRgfl(new Double(request.getParameter("qbkjgc")));
					}
					session.saveOrUpdate(data99);
				}
			}
			
			Gd10_b3fl data9 = new Gd10_b3fl();//100��������С����
			QueryBuilder queryBuilder9 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder9.eq("gcxm_id", gcxm_id);
			queryBuilder9.eq("dxgc_id", dxgc_id);
			queryBuilder9.eq("fylb", new Integer(3));
			queryBuilder9.eq("bz", new Integer(100));
			ResultObject ro9 = queryService.search(queryBuilder9);
			if(ro9.next()){
				data9 = (Gd10_b3fl)ro9.get(Gd10_b3fl.class.getName());
			}
			if(data9 != null){
				if(request.getParameter("100xgr_tz")!=null&&!request.getParameter("100xgr_tz").equals("") ){
					data9.setRgfl(new Double(request.getParameter("100xgr_tz")));
				}
				session.saveOrUpdate(data9);
			}
			
			Gd10_b3fl data10 = new Gd10_b3fl();
			QueryBuilder queryBuilder10 = new HibernateQueryBuilder(Gd10_b3fl.class);
			queryBuilder10.eq("gcxm_id", gcxm_id);
			queryBuilder10.eq("dxgc_id", dxgc_id);
			queryBuilder10.eq("fylb", new Integer(3));
			queryBuilder10.eq("bz", new Integer(250));
			ResultObject ro10 = queryService.search(queryBuilder10);
			if(ro10.next()){
				data10=(Gd10_b3fl)ro10.get(Gd10_b3fl.class.getName());
			}
			if(data10 != null){
				if(request.getParameter("250xgr_tz")!=null&&!request.getParameter("250xgr_tz").equals("")){
					data10.setRgfl(new Double(request.getParameter("250xgr_tz")));
				}
				session.saveOrUpdate(data10);
			}
			
			if ((new Integer(request.getParameter("biaozhi"))).intValue() == 0) {
				Integer gy = new Integer(request.getParameter("B3_GYDQ_BZ"));
				if (gy != null) {
					QueryBuilder queryBuilder2 = new HibernateQueryBuilder(
							Gd10_b3fl.class);
					queryBuilder2.eq("gcxm_id", gcxm_id);
					queryBuilder2.eq("dxgc_id", dxgc_id);
					queryBuilder2.eq("fylb", new Integer(1));
					queryBuilder2.eq("bz", new Integer(1));// ȡ��ԭ��

					ResultObject ro2 = queryService.search(queryBuilder2);
					while (ro2.next()) {
						data2 = (Gd10_b3fl) ro2.get(Gd10_b3fl.class.getName());
						if (data2 != null) {
							if (data2.getId().intValue() == gy.intValue()) {
								Double value = null;
								int i = gy.intValue();
								value = new Double(request
										.getParameter(new String("gy" + i)));
								data2.setRgfl(value);
								data2.setFylb(new Integer(1));
								data2.setFlag(new Integer(1));
								session.saveOrUpdate(data2);
							} else {
								data2.setFlag(new Integer(0));
								session.saveOrUpdate(data2);
							}
						}

					}
				}
			}
			Integer gy1 =null;
			if(request.getParameter("B3_SLSM_BZ")!=null){
				gy1 = new Integer(request.getParameter("B3_SLSM_BZ"));
			}
			if (gy1 != null) {
				QueryBuilder queryBuilder3 = new HibernateQueryBuilder(
						Gd10_b3fl.class);
				queryBuilder3.eq("gcxm_id", gcxm_id);
				queryBuilder3.eq("dxgc_id", dxgc_id);
				queryBuilder3.eq("fylb", new Integer(1));
				queryBuilder3.eq("bz", new Integer(2));// ȡɭ��ɳĮ��
				ResultObject ro3 = queryService.search(queryBuilder3);

				while (ro3.next()) {
					data3 = (Gd10_b3fl) ro3.get(Gd10_b3fl.class.getName());
					if (data3 != null) {
						if (data3.getId().intValue() == gy1.intValue()) {
							Double value1 = null;
							int i = gy1.intValue();
							value1 = new Double(request
									.getParameter(new String("sl" + i)));
							data3.setRgfl(value1);
							data3.setFylb(new Integer(1));
							data3.setFlag(new Integer(1));
							session.saveOrUpdate(data3);
						} else {
							data3.setFlag(new Integer(0));
							session.saveOrUpdate(data3);
						}
					}
				}
			}

			// ��������
			for (int j = 0; j < request.getParameterValues("Gd05_b3j.ID").length; j++) {
				Gd05_b3j gd05 = new Gd05_b3j();
				if (!request.getParameterValues("Gd05_b3j.ID")[j].equals("") && request.getParameterValues("Gd05_b3j.ID")[j] != null
						&& request.getParameterValues("Gd05_b3j.ID")[j].length() > 0) {
					/**
					 * ����ʱ��ȡ���ݿ���������Ϣ
					 */
					gd05 = (Gd05_b3j) queryService.searchById(gd05.getClass(),Integer.valueOf(request.getParameterValues("Gd05_b3j.ID")[j]));
				}
				if (PropertyInject.inject(request, gd05, j)) {
					if(gd05.getDebh()!=null&&!gd05.getDebh().equals("")){
						if(gd05.getTzxs()==null){
							gd05.setTzxs(new Double(1.00));
						}
						gd05.setDxgc_id(dxgc_id);
						gd05.setGcxm_id(gcxm_id);
						session.saveOrUpdate(gd05);
					}		
				}else {
					if(gd05.getId()!=null){
						session.delete(gd05);
					}
				}
			}

			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " �������! ");
		} finally {
			session.close();
		}
		Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		Integer glzc = new Integer(0);//��������
		if (request.getParameter("ZCSC_BZ") != null) {
			glzc = new Integer(request.getParameter("ZCSC_BZ"));
		}
		Integer glsb = new Integer(0);//�����豸
		if (request.getParameter("SBSC_BZ") != null) {
			glsb = new Integer(request.getParameter("SBSC_BZ"));
		}
		Integer gljx = new Integer(0);//������е
		if (request.getParameter("JXSC_BZ") != null) {
			gljx = new Integer(request.getParameter("JXSC_BZ"));
		} 
		Integer glyb = new Integer(0);//�����Ǳ�
		if (request.getParameter("YBSC_BZ") != null) {
			glyb=new Integer(request.getParameter("YBSC_BZ"));
		}
		calculateService.B3Calculate(dxgc_id, gcxm_id);//�����ļ���
		//���ڼ��������޸�Ӱ�쵽ʩ�������ǲ�����������--------------------
		QueryBuilder queryBuilder99 = new HibernateQueryBuilder(Gd03_gcfysz.class);
		queryBuilder99.eq("gcxm_id", gcxm_id);
		queryBuilder99.eq("dxgc_id", dxgc_id);
		queryBuilder99.eq("fymc", "ʩ�������ǲ�ѵ�ǲ����");
		ResultObject ro99 = queryService.search(queryBuilder99);
		if(ro99.next()){
			Gd03_gcfysz data99 = (Gd03_gcfysz)ro99.get(Gd03_gcfysz.class.getName());
			if(data99.getId()!=null){
				if(expenseService.getFlz(dxgc_id, data99.getFy_id())!=null){
					QueryBuilder queryBuilder100 = new HibernateQueryBuilder(Ga05_fy.class);
					queryBuilder100.eq("mc", "ʩ�������ǲ�ѵ�ǲ����");
					ResultObject ro100 = queryService.search(queryBuilder100);
					Ga05_fy data100 = new Ga05_fy();
					if(ro100.next()){
						data100 = (Ga05_fy)ro100.get(Ga05_fy.class.getName());
					}
					if(data100.getId()!=null){
						data99.setJsgs(data100.getJsgs().replaceAll("\\[����\\]", new String(expenseService.getFlz(dxgc_id, data99.getFy_id()))));
						data99.setGsbds(data100.getGsbds().replaceAll("\\[����\\]", new String(expenseService.getFlz(dxgc_id, data99.getFy_id()))));
						saveService.save(data99);
					}
					
				}
			}
		}
		//----------------------------------------------------------
		
		calculateService.DeAssociated(dxgc_id, gcxm_id,glzc,glsb,gljx,glyb);//��������Զ�����
		if(glzc.intValue()==1){//���������Զ����ɣ����ü���ϲ�
			String []fields = {"bh"};
			calculateService.B4Merger(gcxm_id, dxgc_id, new Integer(11), fields);
			calculateService.B4Calculate(gcxm_id, dxgc_id, new Integer(11));
		}
		if(glsb.intValue()==1){//�����豸�Զ����ɣ����ü���ϲ�
			String []fields = {"bh"};
			calculateService.B4Merger(gcxm_id, dxgc_id, new Integer(7), fields);
			calculateService.B4Calculate(gcxm_id, dxgc_id, new Integer(7));
		}
		if(gljx.intValue()==1){//������е�Զ����ɣ����û�е����
			calculateService.B3yCalculate(dxgc_id, gcxm_id);
		}
		if(glyb.intValue()==1){//�����Ǳ��Զ�����,�����Ǳ����
			calculateService.B3bCalculate(dxgc_id, gcxm_id);
		}		
		
		calculateService.Calculate(dxgc_id);
		StringBuffer buffer = new StringBuffer("../dataManage/b3j.jsp?dxgc_id=");
		buffer.append(dxgc_id).append("&gcxm_id=");
		buffer.append(gcxm_id);
		String URL = new String(buffer);
		return new ModelAndView("redirect:"+URL);
	}

	public CalculateService getCalculateService() {
		return calculateService;
	}

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}
	
	

}
