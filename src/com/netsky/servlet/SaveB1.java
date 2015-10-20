package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Ga06_zy;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd03_gcfysz;
import com.netsky.service.CalculateService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * 保存表一
 * @author CT
 * @create 2009-05-21
 */
public class SaveB1 implements Controller {
	/**
	 * 查询service
	 */
	private QueryService queryService;
	/**
	 * 保存service
	 */
	private SaveService saveService;
	
	private CalculateService calculateService;
	
	public void setQueryService(QueryService queryService) {
		this.queryService = queryService;
	}

	public void setSaveService(SaveService saveService) {
		this.saveService = saveService;
	}
	
	public void setCalculateService(CalculateService calculateService) {
		this.calculateService = calculateService;
	}

	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("GBK");
		Integer dxgc_id = new Integer(request.getParameter("dxgc_id"));
		Integer gcxm_id = new Integer(request.getParameter("gcxm_id"));
		
		Integer B1_QZBZ = new Integer(request.getParameter("B1_QZBZ")); 
		Double B1_TZXS = new Double(request.getParameter("B1_TZXS"));
		Integer B1_YBF_BZ = new Integer(request.getParameter("B1_YBF_BZ"));
		
		String HSql4="select gd02 from Gd02_dxgc gd02 where id="+dxgc_id;
        ResultObject ro4 = queryService.search(HSql4);
        Gd02_dxgc gd02=null;
        while(ro4.next())
        {
           gd02=(Gd02_dxgc)ro4.get("gd02");
        }
        gd02.setB1_qzbz(B1_QZBZ);
        gd02.setB1_tzxs(B1_TZXS);
        gd02.setB1_ybf_bz(B1_YBF_BZ);
        saveService.save(gd02);
		
		for(int i=0;i<request.getParameterValues("Gd03_gcfysz.ID").length;i++){
			Gd03_gcfysz gd03 = new Gd03_gcfysz();
			if(!request.getParameterValues("Gd03_gcfysz.ID")[i].equals("") && request.getParameterValues("Gd03_gcfysz.ID")[i] != null &&
					request.getParameterValues("Gd03_gcfysz.ID").length>0){
				gd03 = (Gd03_gcfysz)queryService.searchById(gd03.getClass(), Integer.valueOf(request.getParameterValues("Gd03_gcfysz.ID")[i]));
			}
			
			if (PropertyInject.inject(request, gd03, i)) {
				gd03.setGcxm_id(gcxm_id);
				gd03.setDxgc_id(dxgc_id);
				gd03.setBz(new String("用户自己录入其他费用"));
				gd03.setBgbh(new String("B1"));
				saveService.save(gd03);
			}else {
				if(gd03.getId()!=null){
					saveService.removeObject(gd03);
				}
			}
			
		}
		
		calculateService.Calculate(dxgc_id);
		
		return new ModelAndView("redirect:../dataManage/b1.jsp?dxgc_id="+dxgc_id+"&gcxm_id="+gcxm_id);
	}


	
}
