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
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

import com.netsky.dataObject.Gd07_b4;
import com.netsky.dataObject.Gd04_clfysz;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.baseFormatUtils.StringFormatUtil;

public class SaveB4 implements Controller{
	
	private QueryService queryService;

	private SaveService saveService;
	
	private CalculateService calculateService;

	public CalculateService getCalculateService() {
		return calculateService;
	}

	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

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
	
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("GBK");
		Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		Integer bgxx_id = new Integer(request.getParameter("bgxx_id"));
		
		Gb03_bgxx bgbhInfo = null;
		ResultObject bgxxRs = queryService.search("select gb03 from Gb03_bgxx gb03 where id="+bgxx_id);
		bgxxRs.next();
		bgbhInfo = (Gb03_bgxx)bgxxRs.get("gb03");
		
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
			// 保存主表
			for (int j = 0; j < request.getParameterValues("Gd07_b4.ID").length; j++) {
				Gd07_b4 gd07 = new Gd07_b4();
				if (request.getParameterValues("Gd07_b4.ID")[j] != null
						&& request.getParameterValues("Gd07_b4.ID")[j].length() > 0) {
					/**
					 * 更新时获取数据库中最新信息
					 */
					gd07 = (Gd07_b4) queryService.searchById(gd07.getClass(),Integer.valueOf(request.getParameterValues("Gd07_b4.ID")[j]));
				}
				if (PropertyInject.inject(request, gd07, j)) {
					gd07.setGcxm_id(gcxm_id);
					gd07.setDxgc_id(dxgc_id);
					gd07.setBgbh(bgbhInfo.getBgbh());
					session.saveOrUpdate(gd07);
					
				}else {
					if(gd07.getId()!=null){
						session.delete(gd07);
					}
				}
			}
			//更新材料费用
			if(bgbhInfo.getBgbh().indexOf("B4J")==0){	
				//保存相关设置
				int fynum = Integer.parseInt(request.getParameter("fynum"));
				String[] clt = request.getParameterValues("CLT");
				 
				if(!request.getParameter("price_select").equals("YSJ")){
					for(int i=0;i<clt.length;i++){
						Double yj = formatToDouble(request.getParameter(clt[i]+"_YJ"));
						for(int j=1;j<=fynum;j++){
							String szid = StringFormatUtil.format(request.getParameter(clt[i]+"_SZID_"+j));
							Double fl = formatToDouble(request.getParameter(clt[i]+"_FL_"+j));
							Double fyz = formatToDouble(request.getParameter(clt[i]+"_FYZ_"+j));
							QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd04_clfysz.class);
							queryBuilder1.eq("id", new Integer(szid));
							ResultObject ro1 = queryService.search(queryBuilder1);
							ro1.next();
							Gd04_clfysz data1 = (Gd04_clfysz) ro1.get(Gd04_clfysz.class.getName());
							data1.setFlyj(yj);
							data1.setFlz(fl);
							data1.setFyz(fyz);
							session.merge(data1);
						}
					}
				}else{//如果是预算价，保存相关设置，费用设置费用值和费率值都置null;
					for(int i=0;i<clt.length;i++){
						Double yj = formatToDouble(request.getParameter(clt[i]+"_YJ"));
						for(int j=1;j<=fynum;j++){
							String szid = StringFormatUtil.format(request.getParameter(clt[i]+"_SZID_"+j));
							//Double fl = formatToDouble(request.getParameter(clt[i]+"_FL_"+j));
							//Double fyz = formatToDouble(request.getParameter(clt[i]+"_FYZ_"+j));
							QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd04_clfysz.class);
							queryBuilder1.eq("id", new Integer(szid));
							ResultObject ro1 = queryService.search(queryBuilder1);
							ro1.next();
							Gd04_clfysz data1 = (Gd04_clfysz) ro1.get(Gd04_clfysz.class.getName());
							data1.setFlyj(yj);
							data1.setFlz(new Double(0));//置空
							data1.setFyz(new Double(0));//置空
							session.merge(data1);
						}
					}
				}
			}
			//更新价格设置
			if(!bgbhInfo.getBgbh().equals("JZGCB")){
				String ps = request.getParameter("price_select");
				Gd02_dxgc dxgc = (Gd02_dxgc)session.load(Gd02_dxgc.class, dxgc_id);
				if(StringFormatUtil.format(bgbhInfo.getB4lb()).equals("ZC"))
					dxgc.setB4_zcjg(ps);
				else
					dxgc.setB4_sbjg(ps);	
				session.saveOrUpdate(dxgc);
			}
			
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 保存出错! ");
		} finally {
			session.close();
		}
		
		calculateService.B4Calculate(gcxm_id, dxgc_id, bgxx_id);
		calculateService.Calculate(dxgc_id);
		
		return new ModelAndView("redirect:../dataManage/b4j.jsp?bgxx_id="+bgxx_id+"&dxgc_id="+dxgc_id+"&gcxm_id="+gcxm_id);
	}
	public Double formatToDouble(String str1){
		if(str1==null||str1.equals(""))
			return null;
		else
			return new Double(str1);
	}
}
