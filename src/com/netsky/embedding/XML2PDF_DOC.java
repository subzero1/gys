package com.netsky.embedding;

import java.io.File;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

/**
 * xml文件生成pdf或者doc文档
 * 
 * @author Chiang 2009-05-11
 */
public class XML2PDF_DOC {

	private static final String xsl = "/fopConfig/PrintPdf.xsl";

	private static final String fopConfig = "/fopConfig/fop.xconf";

	/**
	 * 使用xsl文件将xml文件转换为fop格式,生成pdf或doc文档
	 * 
	 * @param type
	 *            转换输出文件类型,"pdf"或"doc"
	 * @param xml
	 *            需要修饰的xml文件
	 * @param WebInfPath
	 *            WEB-INF目录绝对路径
	 * @param out
	 *            输出流
	 * @throws Exception
	 */
	public void transformer(String type, InputStream xml, String WebInfPath, OutputStream out) throws Exception {

		/**
		 * 设置fop.xconf中<font-base>为系统WEB-INF目录绝对路径
		 */
		this.setFopConfigPath(WebInfPath);
		// Setup output
		out = new java.io.BufferedOutputStream(out);
		try {

			FopFactory fopFactory = FopFactory.newInstance();
			// 设置用户字体文件路径
			fopFactory.setUserConfig(WebInfPath + fopConfig);
			FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
			// Construct fop with desired output format
			Fop fop = null;
			if (type == null || type.equals("pdf"))
				fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
			else
				fop = fopFactory.newFop(MimeConstants.MIME_RTF, foUserAgent, out);
			// Setup XSLT
			TransformerFactory factory = TransformerFactory.newInstance();
			Transformer transformer = factory.newTransformer(new StreamSource(new File(WebInfPath + xsl)));
			// Set the value of a <param> in the stylesheet
			transformer.setParameter("versionParam", "2.0");
			// Setup input for XSLT transformation
			Source src = new StreamSource(xml);
			// Resulting SAX events (the generated FO) must be piped through
			// to FOP
			Result res = new SAXResult(fop.getDefaultHandler());
			// Start XSLT transformation and FOP processing
			transformer.transform(src, res);
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			out.close();
		}

	}

	/**
	 * 设置fop.xconf中<font-base>为系统WEB-INF目录绝对路径
	 * 
	 * @param String
	 *            WebInfPath 系统WEB-INF目录绝对路径
	 * @throws Exception
	 */
	public void setFopConfigPath(String WebInfPath) throws Exception {
		try {
			File f = new File(WebInfPath + fopConfig);
			SAXReader reader = new SAXReader();
			Document doc = reader.read(f);
			Element root = doc.getRootElement();
			Element foo;
			Iterator i;
			for (i = root.elementIterator("font-base"); i.hasNext();) {
				foo = (Element) i.next();
				foo.setText(WebInfPath + "/fopConfig");
			}
			XMLWriter writer = new XMLWriter(new FileWriter(new File(WebInfPath + fopConfig)));
			writer.write(doc);
			writer.close();
		} catch (Exception e) {
			throw new Exception(e + "修改fopConfig文件出错!");
		}
	}
}
