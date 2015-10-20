package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga07_qfqj;
import com.netsky.dataObject.Ga08_flmx;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * 用于取费区间维护
 * @author CT
 * @create 2009-06-02
 */
public class Qfqj implements Controller {
	
	private QueryService queryService;
	
	private SaveService saveService;

	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String D1Value="";
		if(request.getParameter("D1")==null){
			D1Value=new String("ZCSBYJ");
		}else{
			D1Value=request.getParameter("D1");
		}
		// TODO Auto-generated method stub
		for(int i=0;i<request.getParameterValues("Ga07_qfqj.ID").length;i++){
			Ga07_qfqj gd07 = new Ga07_qfqj();
			if(!request.getParameterValues("Ga07_qfqj.ID")[i].equals("") && request.getParameterValues("Ga07_qfqj.ID")[i] != null &&
					request.getParameterValues("Ga07_qfqj.ID").length>0){
				gd07 = (Ga07_qfqj)queryService.searchById(gd07.getClass(), Integer.valueOf(request.getParameterValues("Ga07_qfqj.ID")[i]));
			}			
			if (PropertyInject.inject(request, gd07, i)) {
				gd07.setQjlb(D1Value);
				saveService.save(gd07);
			}else {
				if(gd07.getId()!=null){
					QueryBuilder queryBuilder = new HibernateQueryBuilder(Ga08_flmx.class);
					queryBuilder.eq("qj_id", gd07.getId());
					ResultObject ro= queryService.search(queryBuilder);
					while(ro.next()){
						Ga08_flmx ga08 = (Ga08_flmx)ro.get(Ga08_flmx.class.getName());
						if(ga08!=null){
							saveService.removeObject(ga08);
						}
					}
					saveService.removeObject(gd07);
				}
			}			
		}		
		return new ModelAndView("redirect:../system/qfqjwh.jsp?D1="+D1Value);
	}

}
