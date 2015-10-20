package com.netsky.baseFormatUtils;

/**
 * 格式化字符串
 * 
 * @author Chiang
 */
public class StringFormatUtil {

	/**
	 * 格式化字符串,默认返回""
	 * 
	 * @param str
	 */
	public static String format(String str) {
		if (str == null) {
			return "";
		} else {
			return str;
		}
	}

	/**
	 * 格式化字符串,默认返回""
	 * 
	 * @param str
	 */
	public static String format(Integer str) {
		if (str == null) {
			return "";
		} else {
			return str.toString();
		}
	}

	/**
	 * 格式化字符串,默认返回""
	 * 
	 * @param str
	 */
	public static String format(Double str) {
		if (str == null) {
			return "";
		} else {
			return str.toString();
		}
	}

	/**
	 * 格式化字符串,默认返回defaultStr
	 * 
	 * @param str
	 * @param defaultStr
	 */
	public static String format(Integer str, String defaultStr) {
		if (str == null) {
			return defaultStr;
		} else {
			return str.toString();
		}
	}

	/**
	 * 格式化字符串,默认返回defaultStr
	 * 
	 * @param str
	 * @param defaultStr
	 */
	public static String format(Double str, String defaultStr) {
		if (str == null) {
			return defaultStr;
		} else {
			return str.toString();
		}
	}

	/**
	 * 格式化字符串,默认返回defaultStr
	 * 
	 * @param str
	 * @param defaultStr
	 */
	public static String format(String str, String defaultStr) {
		if (str == null) {
			return defaultStr;
		} else {
			return str;
		}
	}
	
	/**
	 * 格式化字符串,默认返回str
	 * 
	 * @param str
	 */
	public static String nullstring(String str) {
		if ("0.00".equals(str)||"0.0".equals(str)||"0".equals(str)) {
			return "";
		} else {
			return str;
		}
	}
	/**
	 * 格式化字符串,默认返回str
	 * 
	 * @param str
	 */
	public static String cdstring(String str,int n) {
		String a="";
		if (str == null) {
			return "";
		} else {
			if(str.length()>n)
			{
				a=str.substring(0,n)+"...";
			}else{
				a=str;
			}
			return a;
		}
	}
}
