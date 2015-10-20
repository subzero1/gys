package com.netsky.servlet;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.netsky.baseFormatUtils.DateFormatUtil;
import com.netsky.baseObject.HibernateQueryBuilder;
import com.netsky.baseObject.PropertyInject;
import com.netsky.baseObject.QueryBuilder;
import com.netsky.baseObject.ResultObject;
import com.netsky.service.QueryService;
import com.netsky.service.SaveService;

/**
 * @author Chiang 2009-08-20
 * 
 * EXCEL信息导入 配置方法
 * 
 * <input type="hidden" name="config" value="import.xml中的配置名称">
 * 
 * 其他存在于request中的参数均写在hidden中
 * 
 * 返回路径 <input type="hidden" name="dispatchStr" value="">
 * 
 * 返回参数 <input type="hidden" name="perproty" value="request中参数名称">
 */
public class ImportController implements Controller {
	/**
	 * 默认持久化对象包路径
	 */
	private static String packgePath = "com.netsky.dataObject";

	private static String configFile = "/importConfig/import.xml";

	private String webInfPatch = "";

	private SaveService saveService;

	private QueryService queryService;

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

	public ModelAndView handleRequest(HttpServletRequest HttpRequest, HttpServletResponse response) throws Exception {
		MultipartHttpServletRequest request = (MultipartHttpServletRequest) HttpRequest;
		/**
		 * 获取配置文件信息
		 */
		String ConfigName = new String(request.getParameter("config").getBytes("iso-8859-1"), "GBK");
		webInfPatch = request.getRealPath("WEB-INF");
		if (ConfigName == null || ConfigName.equals("")) {
			throw new Exception("缺少配置信息参数！");
		}

		String ConfigFileName = getConfinFileName(ConfigName);
		if (ConfigFileName == null || ConfigFileName.equals("")) {
			throw new Exception("未找到对应的导入信息" + ConfigName);
		}
		Map configInfo = this.getConfigInfo(ConfigFileName);
		Session session = null;
		Transaction tx = null;
		try {
			session = saveService.getHiberbateSession();
			tx = session.beginTransaction();
			tx.begin();
		} catch (Exception e) {
			throw new Exception("不能获取session" + e);
		}
		try {
			/**
			 * 处理上传文件
			 */
			Iterator it = request.getFileNames();
			while (it.hasNext()) {
				String fileDispath = (String) it.next();
				MultipartFile file = request.getFile(fileDispath);
				Workbook wb = Workbook.getWorkbook(file.getInputStream());
				Iterator tableIt = configInfo.keySet().iterator();
				/**
				 * 循环处理单个表格
				 */
				while (tableIt.hasNext()) {
					Map tableInfo = (Map) configInfo.get((String) tableIt.next());
					String tableName = (String) tableInfo.get("$tableName");
					int startRow = ((Integer) tableInfo.get("$startRow")).intValue();
					int endRow = -1;
					if (tableInfo.get("$endRow") != null) {
						endRow = ((Integer) tableInfo.get("$endRow")).intValue();
					}
					String endFlag = (String) tableInfo.get("$endFlag");
					String columnType = (String) tableInfo.get("$columnType");

					Sheet st = wb.getSheet(((Integer) tableInfo.get("$sheetNum")).intValue());

					/**
					 * 处理字段对应列信息
					 */
					Map columnMap;
					if (columnType.equals("byIndex")) {
						/**
						 * 通过列信息索引，不需要处理
						 */
						columnMap = (Map) tableInfo.get("$columnMap");
					} else {
						/**
						 * 将通过标题行名称索引转换为通过列信息索引
						 */
						columnMap = new HashMap();
						int titleRow = ((Integer) tableInfo.get("$titleRow")).intValue();
						Map column = (Map) tableInfo.get("$columnMap");
						Iterator colName = column.keySet().iterator();
						/**
						 * 获取标题行所有列
						 */
						Cell cell[] = st.getRow(titleRow);
						while (colName.hasNext()) {
							String name = (String) colName.next();
							Map col = (Map) column.get(name);
							String title = (String) col.get("$name");
							for (int i = 0; i < cell.length; i++) {
								if (cell[i].getContents() != null && cell[i].getContents().equals(title)) {
									col.put("$index", new Integer(cell[i].getColumn()));
									columnMap.put(name, col);
								}
							}
						}
					}
					int totalRows = st.getRows();
					while (startRow < totalRows) {
						if (endRow != -1 && endRow == startRow) {
							break;
						}
						if (st.getCell(0, startRow).getContents() != null && st.getCell(0, startRow).getContents().equals(endFlag)) {
							break;
						}
						Object o = Class.forName(packgePath + "." + tableName).newInstance();
						/**
						 * 注入request中于表格相关内容
						 */
						PropertyInject.injectTransCode(request, o, 0, "iso-8859-1", "GBK");
						/**
						 * 从excel注入信息
						 */
						PropertyInject.injectFromExcel(o, columnMap, st, startRow);

						/**
						 * 处理父表信息
						 */
						Map fatherMap = (Map) tableInfo.get("$fatherMap");
						if (fatherMap != null) {
							Iterator fatherTableIt = fatherMap.keySet().iterator();
							while (fatherTableIt.hasNext()) {
								Map fatherTable = (Map) fatherMap.get((String) fatherTableIt.next());
								if (((String) fatherTable.get("$type")).equals("db")) {
									/**
									 * 从数据库中查询
									 */
									Object fatherObject = Class.forName(packgePath + "." + (String) fatherTable.get("$tableName")).newInstance();
									Class clazz = fatherObject.getClass();
									Class fieldClazz = PropertyInject.getPropertyType(clazz, (String) fatherTable.get("$searchColumn"));
									Object searchvalue = null;
									if (fieldClazz.getName().equals("java.lang.Integer")) {
										searchvalue = Integer.valueOf(st.getCell(Integer.parseInt((String) fatherTable.get("$index")), startRow)
												.getContents());
									} else if (fieldClazz.getName().equals("java.lang.String")) {
										searchvalue = st.getCell(Integer.parseInt((String) fatherTable.get("$index")), startRow).getContents();
									} else if (fieldClazz.getName().equals("java.lang.Double")) {
										searchvalue = Double.valueOf(st.getCell(Integer.parseInt((String) fatherTable.get("$index")), startRow)
												.getContents());
									} else if (fieldClazz.getName().equals("java.util.Date")) {
										searchvalue = DateFormatUtil.FormatDateString(st.getCell(
												Integer.parseInt((String) fatherTable.get("$index")), startRow).getContents());
									}
									if (searchvalue != null && !searchvalue.equals("")) {
										QueryBuilder queryBuilder = new HibernateQueryBuilder(clazz);
										queryBuilder.eq((String) fatherTable.get("$searchColumn"), searchvalue);
										ResultObject ro = queryService.search(queryBuilder);
										if (ro.next()) {
											fatherObject = ro.get(clazz.getName());
											PropertyInject.injectNexus(fatherObject, ((String) fatherTable.get("$columnForSet")).toUpperCase(), o,
													((String) fatherTable.get("$columnToSet")).toUpperCase());
										}
									}

								} else {
									/**
									 * 目前无此类型
									 */
								}
							}
						}
						session.saveOrUpdate(o);
						startRow++;
					}
				}
			}
			session.flush();
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			throw new Exception(e + " 保存出错! ");
		} finally {
			session.close();
		}
		/**
		 * 处理返回路径
		 */
		String dispatchStr = request.getParameter("dispatchStr");
		if (request.getParameter("perproty") != null && request.getParameter("perproty").length() > 0) {
			String perprotys[] = request.getParameter("perproty").split("/");
			for (int i = 0; i < perprotys.length; i++) {
				if (dispatchStr.indexOf("?") != -1) {
					dispatchStr += "&" + perprotys[i] + "=" + request.getParameter(perprotys[i]);
				} else {
					dispatchStr += "?" + perprotys[i] + "=" + request.getParameter(perprotys[i]);
				}
			}
		}
		return new ModelAndView("redirect:" + dispatchStr);
	}

	/**
	 * 根据名称返回对应的配置文件名称
	 * 
	 * @param ConfigName
	 *            配置名称，存放于import.xml
	 * @return 配置文件名称
	 */
	private String getConfinFileName(String ConfigName) throws Exception {
		/**
		 * 获取基本配置文件
		 */
		File f = new File(webInfPatch + configFile);
		if (!f.exists()) {
			throw new Exception("未找到基础配置文件");
		}
		SAXReader reader = new SAXReader();
		Document doc = reader.read(f);
		Element root = doc.getRootElement();
		Element foo;
		Iterator i;
		for (i = root.elementIterator("config"); i.hasNext();) {
			foo = (Element) i.next();
			String configName = foo.elementText("name");
			if (configName.equals(ConfigName)) {
				return foo.elementText("fileName");
			}
		}
		return null;
	}

	/**
	 * 获取配置信息
	 * 
	 * @param ConfigFileName
	 *            配置文件名称
	 * @return 存放配置信息map
	 * @throws Exception
	 */
	private Map getConfigInfo(String ConfigFileName) throws Exception {
		File f = new File(webInfPatch + ConfigFileName);
		if (!f.exists()) {
			throw new Exception("未找到用户配置文件");
		}
		SAXReader reader = new SAXReader();
		Document doc = reader.read(f);
		Element root = doc.getRootElement();
		Element foo;
		Iterator i;
		i = root.elementIterator("tableInfo");
		Map reuslt = new HashMap();
		/**
		 * 处理配置信息
		 */
		while (i.hasNext()) {
			Map tableMap = new HashMap();
			foo = (Element) i.next();
			/**
			 * 表名称，对应持久化对象名称
			 */
			String tableName = foo.element("tableName").getText();
			tableMap.put("$tableName", tableName);
			/**
			 * 表格信息所在sheet位于excel文件中位置
			 */
			Integer sheetNum = Integer.valueOf(foo.element("sheetNum").getText());
			tableMap.put("$sheetNum", sheetNum);
			/**
			 * 数据开始行
			 */
			Integer startRow = Integer.valueOf(foo.element("startRow").getText());
			tableMap.put("$startRow", startRow);
			/**
			 * 数据结束行
			 */
			if (foo.element("endRow").getText() != null && !foo.element("endRow").getText().equals("")) {
				Integer endRow = Integer.valueOf(foo.element("endRow").getText());
				tableMap.put("$endRow", endRow);
			}
			/**
			 * 数据结束标识
			 */
			String endFlag = foo.element("endFlag").getText();
			tableMap.put("$endFlag", endFlag);
			/**
			 * 处理父表信息
			 */
			Map fatherMap = new HashMap();
			Iterator fatherIt = foo.element("fatherTables").elementIterator("fatherTable");
			while (fatherIt.hasNext()) {
				Element element = (Element) fatherIt.next();
				Map fathertable = new HashMap();
				fathertable.put("$type", element.element("type").getText());
				fathertable.put("$tableName", element.element("tableName").getText());
				fathertable.put("$searchColumn", element.element("searchColumn").getText());
				fathertable.put("$index", element.element("index").getText());
				fathertable.put("$columnForSet", element.element("columnForSet").getText());
				fathertable.put("$columnToSet", element.element("columnToSet").getText());
				fatherMap.put(element.element("tableName").getText(), fathertable);
			}
			tableMap.put("$fatherMap", fatherMap);
			/**
			 * 处理字段信息
			 */
			Iterator columns = foo.element("columns").elementIterator("column");
			tableMap.put("$columnType", foo.element("columns").element("type").getText());
			tableMap.put("$titleRow", Integer.valueOf(foo.element("columns").element("titleRow").getText()));
			Map columnMap = new HashMap();
			while (columns.hasNext()) {
				Element element = (Element) columns.next();
				Map column = new HashMap();
				column.put("$index", element.element("index").getText());
				column.put("$name", element.element("name").getText());
				columnMap.put(element.element("columnName").getText(), column);
			}
			tableMap.put("$columnMap", columnMap);

			reuslt.put(tableName, tableMap);
		}
		return reuslt;
	}
}
