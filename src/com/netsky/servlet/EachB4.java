package com.netsky.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.dataObject.Gb03_bgxx;
import com.netsky.dataObject.Gd02_dxgc;
import com.netsky.dataObject.Gd07_b4;
import com.netsky.service.CalculateService;
import com.netsky.service.ExpenseService;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;
/**
 * 用于表四数据互导
 * @author CT
 * @create 2009-08-06
 */
public class EachB4 implements Controller {
	/**
	 * 费率Service
	 */
	private ExpenseService expenseService;
	/**
	 * 查寻Service
	 */
	private QueryService queryService;
	/**
	 * 保存Service
	 */
	private SaveService saveService;
	/**
	 * 计算类
	 */
	private CalculateService calculateService;
	
	
	public void setExpenseService(ExpenseService expenseService) {
		this.expenseService = expenseService;
	}

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
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("GBK");
		
		String gcxm_id = request.getParameter("gcxm_id");
		String dxgc_id = request.getParameter("dxgc_id");
		
		String lyb = "";
		if(request.getParameter("lyb")==null||request.getParameter("lyb").equals("")){
			lyb = "B4JXASB";
		}else{
			lyb = request.getParameter("lyb");
		}
		
		String flag="0";
		if(lyb.equals("B4JXASB")||lyb.equals("B4JBXASB")||lyb.equals("B4JBPBJ")||lyb.equals("B4JWHQJ")){
			flag ="0";
		}else{
			flag="1";
		}
		
		String mbb = "";
		if(request.getParameter("mbb")==null||request.getParameter("mbb").equals("")){
			mbb = "B4JXASB";
		}else{
			mbb = request.getParameter("mbb");
		}	
		
		Integer targetId =null;
		QueryBuilder queryBuilder2 = new HibernateQueryBuilder(Gb03_bgxx.class);
		queryBuilder2.eq("bgbh", mbb);
		ResultObject ro2 = queryService.search(queryBuilder2);
		Gb03_bgxx bgxx=new Gb03_bgxx();
		if(ro2.next()){
			bgxx = (Gb03_bgxx)ro2.get(Gb03_bgxx.class.getName());
			targetId = bgxx.getId();
		}
		
		//判断目标表格是否为选定表格，如果不是，则增加（UPDATE GD02.BGXD）
	    QueryBuilder queryBuilder = new HibernateQueryBuilder(Gd02_dxgc.class);
	    queryBuilder.eq("id",new Integer(dxgc_id));
	    ResultObject ro = queryService.search(queryBuilder);
	    Gd02_dxgc dxgc = new Gd02_dxgc();
	    int temp=0;
	    if(ro.next()){
	    	
	  		dxgc = (Gd02_dxgc)ro.get(Gd02_dxgc.class.getName());
	  		String []bgxd=dxgc.getBgxd().split(",");
	  		for(int i=0;i<bgxd.length;i++){
	  			if(bgxd[i].equals(String.valueOf(targetId))){
	  				temp=1;
	  			}
	  		}	  		
	    }
	    if(temp==0){
	    	dxgc.setBgxd(dxgc.getBgxd()+","+String.valueOf(targetId));
	    	saveService.save(dxgc);
	    }
	    //更改所选材料或设备的表格编号（GD07.BGBH）；
		for(int i=0;i<request.getParameterValues("ids").length;i++){
			QueryBuilder queryBuilder1 = new HibernateQueryBuilder(Gd07_b4.class);
			queryBuilder1.eq("id", new Integer(request.getParameterValues("ids")[i]));
			ResultObject ro1= queryService.search(queryBuilder1);
			Gd07_b4 data = new Gd07_b4();
			if(ro1.next()){
				data = (Gd07_b4)ro1.get(Gd07_b4.class.getName());
				if(data!=null){
					data.setBgbh(mbb);
					saveService.save(data);
					expenseService.updateJsgc(dxgc, targetId, new String("add"));
				}
			}
		}
		/**
		 * 计算表4
		 */
		calculateService.B4CalculateAll(new Integer(gcxm_id), new Integer(dxgc_id));

		/**
		 * 计算表1,表2,表5
		 */
		calculateService.Calculate(new Integer(dxgc_id));

		return new ModelAndView("redirect:../dataManage/eachB4.jsp?gcxm_id="+gcxm_id+"&dxgc_id="+dxgc_id+"&lyb="+lyb+"&flag="+flag+"&mbb1="+mbb);//
	}
	
	
}
