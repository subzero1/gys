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
 * EXCEL��Ϣ���� ���÷���
 * 
 * <input type="hidden" name="config" value="import.xml�е���������">
 * 
 * ����������request�еĲ�����д��hidden��
 * 
 * ����·�� <input type="hidden" name="dispatchStr" value="">
 * 
 * ���ز��� <input type="hidden" name="perproty" value="request�в�������">
 */
public class ImportController implements Controller {
	/**
	 * Ĭ�ϳ־û������·��
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
		 * ��ȡ�����ļ���Ϣ
		 */
		String ConfigName = new String(request.getParameter("config").getBytes("iso-8859-1"), "GBK");
		webInfPatch = request.getRealPath("WEB-INF");
		if (ConfigName == null || ConfigName.equals("")) {
			throw new Exception("ȱ��������Ϣ������");
		}

		String ConfigFileName = getConfinFileName(ConfigName);
		if (ConfigFileName == null || ConfigFileName.equals("")) {
			throw new Exception("δ�ҵ���Ӧ�ĵ�����Ϣ" + ConfigName);
		}
		Map configInfo = this.getConfigInfo(ConfigFileName);
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
			 * �����ϴ��ļ�
			 */
			Iterator it = request.getFileNames();
			while (it.hasNext()) {
				String fileDispath = (String) it.next();
				MultipartFile file = request.getFile(fileDispath);
				Workbook wb = Workbook.getWorkbook(file.getInputStream());
				Iterator tableIt = configInfo.keySet().iterator();
				/**
				 * ѭ�����������
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
					 * �����ֶζ�Ӧ����Ϣ
					 */
					Map columnMap;
					if (columnType.equals("byIndex")) {
						/**
						 * ͨ������Ϣ����������Ҫ����
						 */
						columnMap = (Map) tableInfo.get("$columnMap");
					} else {
						/**
						 * ��ͨ����������������ת��Ϊͨ������Ϣ����
						 */
						columnMap = new HashMap();
						int titleRow = ((Integer) tableInfo.get("$titleRow")).intValue();
						Map column = (Map) tableInfo.get("$columnMap");
						Iterator colName = column.keySet().iterator();
						/**
						 * ��ȡ������������
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
						 * ע��request���ڱ���������
						 */
						PropertyInject.injectTransCode(request, o, 0, "iso-8859-1", "GBK");
						/**
						 * ��excelע����Ϣ
						 */
						PropertyInject.injectFromExcel(o, columnMap, st, startRow);

						/**
						 * ��������Ϣ
						 */
						Map fatherMap = (Map) tableInfo.get("$fatherMap");
						if (fatherMap != null) {
							Iterator fatherTableIt = fatherMap.keySet().iterator();
							while (fatherTableIt.hasNext()) {
								Map fatherTable = (Map) fatherMap.get((String) fatherTableIt.next());
								if (((String) fatherTable.get("$type")).equals("db")) {
									/**
									 * �����ݿ��в�ѯ
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
									 * Ŀǰ�޴�����
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
			throw new Exception(e + " �������! ");
		} finally {
			session.close();
		}
		/**
		 * ������·��
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
	 * �������Ʒ��ض�Ӧ�������ļ�����
	 * 
	 * @param ConfigName
	 *            �������ƣ������import.xml
	 * @return �����ļ�����
	 */
	private String getConfinFileName(String ConfigName) throws Exception {
		/**
		 * ��ȡ���������ļ�
		 */
		File f = new File(webInfPatch + configFile);
		if (!f.exists()) {
			throw new Exception("δ�ҵ����������ļ�");
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
	 * ��ȡ������Ϣ
	 * 
	 * @param ConfigFileName
	 *            �����ļ�����
	 * @return ���������Ϣmap
	 * @throws Exception
	 */
	private Map getConfigInfo(String ConfigFileName) throws Exception {
		File f = new File(webInfPatch + ConfigFileName);
		if (!f.exists()) {
			throw new Exception("δ�ҵ��û������ļ�");
		}
		SAXReader reader = new SAXReader();
		Document doc = reader.read(f);
		Element root = doc.getRootElement();
		Element foo;
		Iterator i;
		i = root.elementIterator("tableInfo");
		Map reuslt = new HashMap();
		/**
		 * ����������Ϣ
		 */
		while (i.hasNext()) {
			Map tableMap = new HashMap();
			foo = (Element) i.next();
			/**
			 * �����ƣ���Ӧ�־û���������
			 */
			String tableName = foo.element("tableName").getText();
			tableMap.put("$tableName", tableName);
			/**
			 * �����Ϣ����sheetλ��excel�ļ���λ��
			 */
			Integer sheetNum = Integer.valueOf(foo.element("sheetNum").getText());
			tableMap.put("$sheetNum", sheetNum);
			/**
			 * ���ݿ�ʼ��
			 */
			Integer startRow = Integer.valueOf(foo.element("startRow").getText());
			tableMap.put("$startRow", startRow);
			/**
			 * ���ݽ�����
			 */
			if (foo.element("endRow").getText() != null && !foo.element("endRow").getText().equals("")) {
				Integer endRow = Integer.valueOf(foo.element("endRow").getText());
				tableMap.put("$endRow", endRow);
			}
			/**
			 * ���ݽ�����ʶ
			 */
			String endFlag = foo.element("endFlag").getText();
			tableMap.put("$endFlag", endFlag);
			/**
			 * ��������Ϣ
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
			 * �����ֶ���Ϣ
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
