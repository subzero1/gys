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
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd06_b3y;
import com.netsky.dataObject.Gd10_b3fl;
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * 表三乙丙保存
 * @author CT
 * @create 2009-05-18
 */
public class SaveB3yb implements Controller {
	
	private QueryService queryService;

	private SaveService saveService;
	
	private CalculateService calculateService;
	
	private Gd10_b3fl data2 = new Gd10_b3fl();

	private Gd10_b3fl data3 = new Gd10_b3fl();

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}
	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("GBK");
		
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		if(request.getParameter("renew")!=null){//由定额重新生成
			Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
			Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
			String bgxx_id = new String(request.getParameter("bgxx_id"));
			Integer renew = new Integer(0);
			if(request.getParameter("renew")!=null){
				 renew = new Integer(request.getParameter("renew"));
				 if(renew.intValue()==1){
					 if(bgxx_id.equals("5")){
						 calculateService.DeAssociated(dxgc_id, gcxm_id, new Integer(0), new Integer(0), new Integer(1), new Integer(0));
						 calculateService.B3yCalculate(dxgc_id, gcxm_id);//调用表三乙计算
						 calculateService.Calculate(dxgc_id);
					}else if(bgxx_id.equals("6")){
						calculateService.DeAssociated(dxgc_id, gcxm_id, new Integer(0), new Integer(0), new Integer(0), new Integer(1));
						calculateService.B3bCalculate(dxgc_id, gcxm_id); //调用表三丙计算
						calculateService.Calculate(dxgc_id);
					}
				 }
				 renew = null;
			}
		}else{
			try {//一般的保存
				Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
				Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
				String bgxx_id = new String(request.getParameter("bgxx_id"));
				
				if(bgxx_id.equals("5")){//如果是机械的
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);
					queryBuilder1.eq("id",dxgc_id);
					queryBuilder1.eq("gcxm_id", gcxm_id);
					ResultObject ro1 = queryService.search(queryBuilder1);
					Gd02_dxgc dxgc = new Gd02_dxgc();
					if(ro1.next()){
						dxgc = (Gd02_dxgc)ro1.get(Gd02_dxgc.class.getName());
					}
					if(request.getParameter("B3_JXF_TZXS")!=null){
						dxgc.setB3_jxf_tzxs(new Double(request.getParameter("B3_JXF_TZXS")));
					}else{
						dxgc.setB3_jxf_tzxs(new Double(1.0));
					}
					dxgc.setB3_jxjg(request.getParameter("B4_JXJG"));
					session.saveOrUpdate(dxgc);
					
					if ((new Integer(request.getParameter("biaozhi"))).intValue() == 0) {
						Integer gy = new Integer(request.getParameter("B3_GYDQ_BZ"));
						if (gy != null) {
							QueryBuilder queryBuilder2 = new HibernateQueryBuilder(
									Gd10_b3fl.class);
							queryBuilder2.eq("gcxm_id", gcxm_id);
							queryBuilder2.eq("dxgc_id", dxgc_id);
							queryBuilder2.eq("fylb", new Integer(1));
							queryBuilder2.eq("bz", new Integer(1));// 取高原的

							ResultObject ro2 = queryService.search(queryBuilder2);
							while (ro2.next()) {
								data2 = (Gd10_b3fl) ro2.get(Gd10_b3fl.class.getName());
								if (data2 != null) {
									if (data2.getId().intValue() == gy.intValue()) {
										Double value = null;
										int i = gy.intValue();
										value = new Double(request
												.getParameter(new String("gy" + i)));
										data2.setJxfl(value);
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
						queryBuilder3.eq("bz", new Integer(2));// 取森林沙漠的
						ResultObject ro3 = queryService.search(queryBuilder3);

						while (ro3.next()) {
							data3 = (Gd10_b3fl) ro3.get(Gd10_b3fl.class.getName());
							if (data3 != null) {
								if (data3.getId().intValue() == gy1.intValue()) {
									Double value1 = null;
									int i = gy1.intValue();
									value1 = new Double(request
											.getParameter(new String("sl" + i)));
									data3.setJxfl(value1);
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
					
					//保存主表
					for(int i=0;i<request.getParameterValues("Gd06_b3y.ID").length;i++){
						Gd06_b3y gd06 = new Gd06_b3y();
						if(!request.getParameterValues("Gd06_b3y.ID")[i].equals("") && request.getParameterValues("Gd06_b3y.ID")[i] != null &&
								request.getParameterValues("Gd06_b3y.ID").length>0){
							gd06 = (Gd06_b3y)queryService.searchById(gd06.getClass(), 
									Integer.valueOf(request.getParameterValues("Gd06_b3y.ID")[i]));
						}
						if (PropertyInject.inject(request, gd06, i)) {
							if(gd06.getBh()!=null&&!gd06.getBh().equals("")){
								if(gd06.getTzxs()==null){
									gd06.setTzxs(new Double(1.00));
								}
								gd06.setDxgc_id(dxgc_id);
								gd06.setGcxm_id(gcxm_id);
								gd06.setLb("JX");
								session.saveOrUpdate(gd06);
							}	
						}else {
							if(gd06.getId()!=null){
								session.delete(gd06);
							}
						}					
					}
					session.flush();
					tx.commit();
					calculateService.B3yCalculate(dxgc_id, gcxm_id);//调用表三乙计算
					calculateService.Calculate(dxgc_id);//调用总计算
				}else{//如果是仪表的
					QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd02_dxgc.class);
					queryBuilder1.eq("id",dxgc_id);
					queryBuilder1.eq("gcxm_id", gcxm_id);
					ResultObject ro1 = queryService.search(queryBuilder1);
					Gd02_dxgc dxgc = new Gd02_dxgc();
					if(ro1.next()){
						dxgc = (Gd02_dxgc)ro1.get(Gd02_dxgc.class.getName());
					}
					if(request.getParameter("B3_YBF_TZXS")!=null){
						dxgc.setB3_ybf_tzxs(new Double(request.getParameter("B3_YBF_TZXS")));
					}else{
						dxgc.setB3_ybf_tzxs(new Double(1.0));
					}
					dxgc.setB3_ybjg(request.getParameter("B4_YBJG"));
					session.saveOrUpdate(dxgc);
					
					//保存主表
					for(int i=0;i<request.getParameterValues("Gd06_b3y.ID").length;i++){
						Gd06_b3y gd06 = new Gd06_b3y();
						if(!request.getParameterValues("Gd06_b3y.ID")[i].equals("") && request.getParameterValues("Gd06_b3y.ID")[i] != null &&
								request.getParameterValues("Gd06_b3y.ID").length>0){
							gd06 = (Gd06_b3y)queryService.searchById(gd06.getClass(), Integer.valueOf(request.getParameterValues("Gd06_b3y.ID")[i]));
						}
						if (PropertyInject.inject(request, gd06, i)) {
							if(!gd06.getBh().equals("")&&gd06.getBh()!=null){
								if(gd06.getTzxs()==null){
									gd06.setTzxs(new Double(1.00));
								}
								gd06.setDxgc_id(dxgc_id);
								gd06.setGcxm_id(gcxm_id);
								gd06.setLb(new String("YB"));
								session.saveOrUpdate(gd06);
							}	
						}else {
							if(gd06.getId()!=null){
								session.delete(gd06);
							}
						}
					}	
					session.flush();
					tx.commit();
					calculateService.B3bCalculate(dxgc_id, gcxm_id);
					calculateService.Calculate(dxgc_id);//调用总计算
				}
			} catch (Exception e) {
				tx.rollback();
				throw new Exception(e + " 保存出错! ");
			} finally {
				session.close();
			}
		
		}	
		Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		String bgxx_id = new String(request.getParameter("bgxx_id"));
		
		StringBuffer buffer = new StringBuffer("../dataManage/b3yb.jsp?bgxx_id=");
		buffer.append(bgxx_id).append("&dxgc_id=");
		buffer.append(dxgc_id).append("&gcxm_id=");
		buffer.append(gcxm_id);
		String URL = new String(buffer);
		return new ModelAndView("redirect:"+URL);
	}

}
