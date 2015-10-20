package com.netsky.baseObject;

import java.util.*;
import com.netsky.baseFormatUtils.NumberFormatUtil;

/**
 * 
 * 简单数学表达式计算器 编译环境：JDK 1.4 调用方法： String Calculator.exec(String exp, Map data)
 * throws Exception 参数： exp 必须为有效表达式 data [费率]，"0.12" 支持： 1.有效运算符 + - / * ( )
 * 2.嵌套括号 3.被除数为零的效验 4.允许data中值为负数 不支持： 1.没有对输入的表达式进行有效性效验
 * 2.exp中不支持带符号操作数，如：4/-2、-0.21*3等 3.没有对计算结果小数位进行精度处理
 * 
 * 作者：马瑞 日期：2009-4-24
 * 
 */
public class Calculator {

	/**
	 * 运算符 + * - / （不包括括号）及优先级 0:低 1:高
	 */
	private static HashMap operator = new HashMap();
	static {
		operator.put("+", new Integer(0));
		operator.put("-", new Integer(0));
		operator.put("*", new Integer(1));
		operator.put("/", new Integer(1));
	}

	/**
	 * 将表达式中操作数与运算符拆开存储 例如： 表达式：1+2-3*4/5 结果为：[1,+,2,-,3,*,4,/,5]
	 */
	private static List parse(String exp) throws Exception {

		List result = new ArrayList();

		String opStr = exp.replaceAll("\\d", "").replaceAll("\\.", "");// 提出表达式中所有的运算符
		String curOp = null;// 记录当前的运算符
		int loc = 0;// 记录当前的运算符在表达式中的位置

		try {
			for (int i = 0; i < opStr.length(); i++) {
				curOp = opStr.substring(i, i + 1);
				loc = exp.indexOf(curOp);
				// 如果当前的运算符是（或）
				if (!exp.substring(0, loc).trim().equals(""))
					result.add(exp.substring(0, loc).trim());
				result.add(exp.substring(loc, loc + 1));
				exp = exp.substring(loc + 1);
			}
			if (exp.length() > 0)
				result.add(exp.trim());
		} catch (Exception e) {
			throw new Exception("操作数与运算符拆分时异常：" + e.getMessage());
		}
		return result;
	}

	/**
	 * 根据运算符优先级将表达式从中缀表达式转换为后缀表达式(逆波兰表达式) 例如： 中缀表达式：1+2*3-4/5*6+7-8/9
	 * 后缀表达式：123*45/6*7+89/--+
	 */
	private static String[] getSuffixExp(List infixExp) throws Exception {
		Stack result = new Stack();
		Stack tmpOp = new Stack();// 存储临时中转的运算符

		Iterator it = infixExp.iterator();
		String curContent = null;
		try {
			while (it.hasNext()) {
				curContent = (String) it.next();
				/*
				 * 如果是运算符则与上一个(栈顶)运算符的优先级进行比较： 当前 >上一个：把当前的入tmpOp栈 当前<=上一个：把上一个从tmpOp栈出,再入result栈；把当前的入tmpOp栈
				 * 如果是操作数则直接入result栈
				 */
				if (operator.containsKey(curContent)) {
					if (tmpOp.size() == 0) {
						tmpOp.push(curContent);
					} else {
						int p1 = ((Integer) operator.get(curContent)).intValue();
						int p2 = ((Integer) operator.get(tmpOp.peek())).intValue();
						if (p1 > p2) {
							tmpOp.push(curContent);
						} else {
							result.push(tmpOp.pop());
							tmpOp.push(curContent);
						}
					}
				} else {
					result.push(curContent);
				}
			}
			// 将tmpOp栈中剩余的运算符入result栈
			while (tmpOp.size() > 0)
				result.push(tmpOp.pop());
		} catch (Exception e) {
			tmpOp = null;
			result = null;
			throw new Exception("转换为后缀表达式时异常：" + e.getMessage());
		}
		// 将result栈中的数据转成String[]
		int len = result.size();
		String[] suffixExp = new String[len];
		for (int i = 0; i < len; i++)
			suffixExp[len - i - 1] = (String) result.pop();
		tmpOp = null;
		result = null;
		return suffixExp;
	}

	/**
	 * 后缀表达式计算
	 */
	private static String calculateSuffixExp(String[] suffixExp) throws Exception {
		int len = suffixExp.length;
		Stack result = new Stack();
		String numa = null, numb = null;
		for (int i = 0; i < len; i++) {
			if (operator.containsKey(suffixExp[i])) {
				numb = (String) result.pop();
				numa = (String) result.pop();
				result.push(compute(numa, numb, suffixExp[i]));
			} else {
				result.push(suffixExp[i]);
			}
		}
		if (result.size() == 1)
			return (String) result.pop();
		else
			throw new Exception("后缀表达式不正确计算时异常");
	}

	/**
	 * 四则运算
	 */
	public static String compute(String numA, String numB, String operator) throws Exception {
		try {
			switch (operator.charAt(0)) {
			case '+':
				return NumberFormatUtil.addToString(numA, numB);
			case '-':
				return NumberFormatUtil.subToString(numA, numB);
			case '*':
				return NumberFormatUtil.mulToString(numA, numB);
			case '/':
				if ((new Double(numB)).doubleValue() == 0)
					throw new Exception("被除数为零 " + (numA + operator + numB));
				return NumberFormatUtil.roundToString(NumberFormatUtil.divToString(numA, numB, 4));
			default:
				return numA;
			}
		} catch (Exception e) {
			throw new Exception("四则运算时异常：" + e.getMessage());
		}
	}

	/**
	 * 计算表达式的值
	 */
	private static String calculate(List infixExp) throws Exception {
		String curContent = null;
		List mainExp = new ArrayList();// 不包含括号的最终需要计算的表达式
		List subExp = new ArrayList();// 括号中需要优先计算的表达式
		Iterator it = infixExp.iterator();
		int leftStart = 0;// 在同一括号组中左括号个数
		int rightEnd = 0;// 在同一括号组中右括号个数
		while (it.hasNext()) {
			curContent = (String) it.next();
			if (curContent.equals("(")) {
				++leftStart;
				subExp.add(curContent);
			} else if (curContent.equals(")")) {
				++rightEnd;
				subExp.add(curContent);
				// 如果找到了一个括号组则递归（嵌套括号）计算它
				if (rightEnd == leftStart) {
					subExp.remove(0);// 去掉开头的（
					subExp.remove(subExp.size() - 1);// 去掉结尾的）
					mainExp.add(calculate(subExp));
					leftStart = 0;
					rightEnd = 0;
					subExp.clear();
				}
			} else {
				if (leftStart > 0)
					subExp.add(curContent);
				else
					mainExp.add(curContent);
			}
		}
		return calculateSuffixExp(getSuffixExp(mainExp));
	}

	public static String exec(String exp, Map data) throws Exception {
		String key = null, num = null;
		Set keys = data.keySet();
		Iterator it = keys.iterator();
		try {
			while (it.hasNext()) {
				key = it.next().toString();
				num = data.get(key).toString();
				if (num.indexOf("-") != -1)
					num = "(0" + num + ")";
				exp = exp.replaceAll("\\" + key, num);
			}
			exp = exp.replaceAll("%", "/100");
			List dataList = parse(exp);
			return calculate(dataList);
		} catch (Exception e) {
			throw new Exception("计算 " + exp + " 公式时异常: " + e.getMessage());
		}
	}

	/**
	 * 删除公式中某费用
	 * 
	 * @param jsgs
	 *            计算公式
	 * @param fy
	 *            需要删除的费用
	 * @return 处理结果
	 */
	public static String deleteFy(String jsgs, String fy) throws Exception {
		jsgs = jsgs.replaceAll(" ", "");
		/**
		 * 将计算公式转存为list格式
		 */
		List list = jsgsToList(jsgs);
		/**
		 * 费用在公式中位置list
		 */
		List indexList = new ArrayList();
		/**
		 * 须删除项在list中位置存储list
		 */
		Map delMap = new HashMap();
		/**
		 * 获取费用字符串在公式中首位置
		 */
		for (int i = 0; i < list.size(); i++) {
			if (((String) list.get(i)).equals(fy)) {
				indexList.add(new Integer(i));
			}
		}
		/**
		 * 公式中未找到相关费用，返回原公式
		 */
		if (indexList.size() == 0) {
			return jsgs;
		}

		/**
		 * 循环处理所有公式中出现的需处理费用
		 */
		for (int i = 0; i < indexList.size(); i++) {
			int index = ((Integer) indexList.get(i)).intValue();
			delMap.put(new Integer(index), "true");
			if (index > 0 && !(((String) list.get(index - 1)).equals("(") || ((String) list.get(index - 1)).equals(")"))) {
				delMap.put(new Integer(index - 1), "true");
			}
			/**
			 * 处理费用后运算符类型，当费用后运算符类型为*或/，需要与此费用一起删除
			 */
			for (int j = index; j < list.size(); j++) {
				if (((String) list.get(j)).equals("*") || ((String) list.get(j)).equals("/")) {
					delMap.put(new Integer(j), "true");
					if (((String) list.get(j + 1)).equals("(")) {
						/**
						 * 查找与j+1匹配的(,并删除括号内容
						 */
						int place = 0;// 默认匹配第一个找到的)
						int now_place = 0;// 当前正确匹配的)位置
						for (int k = j + 2; k < list.size(); k++) {
							if (((String) list.get(k)).equals("(")) {
								place++;
							}
							if (((String) list.get(k)).equals(")") && now_place == place) {
								/**
								 * 删除公式中从（j+1）-k的位置
								 */
								for (int p = j + 1; p <= k; p++) {
									delMap.put(new Integer(p), "true");
								}
								break;
							} else if (((String) list.get(k)).equals(")") && now_place != place) {
								now_place++;
							}
						}
					} else {
						delMap.put(new Integer(j + 1), "true");
						j++;
					}
				} else if (((String) list.get(j)).equals("+") || ((String) list.get(j)).equals("-") || ((String) list.get(j)).equals("(")
						|| ((String) list.get(j)).equals(")")) {
					if (index == 0 || ((String) list.get(index - 1)).equals("(")) {
						delMap.put(new Integer(j), "true");
					}
					break;
				}
			}
			/**
			 * 处理费用前运算符类型，当费用后运算符类型为*或/，需要与此费用一起删除
			 */
			for (int j = index; j >= 0; j--) {
				if (((String) list.get(j)).equals("*") || ((String) list.get(j)).equals("/")) {
					delMap.put(new Integer(j), "true");
					if (((String) list.get(j - 1)).equals(")")) {
						/**
						 * 查找与j-1匹配的(,并删除括号内容
						 */
						int place = 0;// 默认匹配第一个找到的(
						int now_place = 0;// 当前正确匹配的(位置
						for (int k = j - 2; k >= 0; k--) {
							if (((String) list.get(k)).equals(")")) {
								place++;
							}
							if (((String) list.get(k)).equals("(") && now_place == place) {
								/**
								 * 删除公式中从k-（j-1）的位置
								 */
								for (int p = k; p < j; p++) {
									delMap.put(new Integer(p), "true");
								}
								break;
							} else if (((String) list.get(k)).equals("(") && now_place != place) {
								now_place++;
							}
						}
					} else {
						delMap.put(new Integer(j - 1), "true");
						j--;
					}
				} else if (((String) list.get(j)).equals("+") || ((String) list.get(j)).equals("-") || ((String) list.get(j)).equals("(")
						|| ((String) list.get(j)).equals(")")) {
					break;
				}
			}
		}

		/**
		 * 删除项目
		 */
		String str = "";
		for (int i = 0; i < list.size(); i++) {
			if (delMap.get(new Integer(i)) == null) {
				str += list.get(i);
			}
		}
		return removeParentheses(str);
	}

	/**
	 * 将计算公式存储为list结构，以运算符为分隔 例([主要材料费]+[光电缆设备费])*[费率]%存储为
	 * (,[主要材料费],+,[光电缆设备费],),*,[费率]%
	 * 
	 * @param jsgs
	 *            处理的公式
	 * @return List 处理结果
	 */
	private static List jsgsToList(String jsgs) {
		List resultList = new ArrayList();
		char jsgsChar[] = jsgs.toCharArray();
		String temp = "";
		for (int i = 0; i < jsgsChar.length; i++) {
			if ((String.valueOf(jsgsChar[i])).equals("(") || (String.valueOf(jsgsChar[i])).equals(")") || (String.valueOf(jsgsChar[i])).equals("+")
					|| (String.valueOf(jsgsChar[i])).equals("-") || (String.valueOf(jsgsChar[i])).equals("*")
					|| (String.valueOf(jsgsChar[i])).equals("/")) {
				if (!temp.equals("")) {
					resultList.add(temp);
					temp = "";
				}
				resultList.add(String.valueOf(jsgsChar[i]));
			} else {
				temp += String.valueOf(jsgsChar[i]);
			}
		}
		if (!temp.equals("")) {
			resultList.add(temp);
		}
		return resultList;
	}

	/**
	 * 去除多余的括号
	 * 
	 * @param jsgs
	 *            处理的公式
	 * @return String 处理结果
	 * @throws Exception
	 */
	private static String removeParentheses(String jsgs) throws Exception {
		/**
		 * 须删除项在list中位置存储list
		 */
		Map delMap = new HashMap();
		List list = jsgsToList(jsgs);
		int ParenthesesIndex = -1;
		for (int i = 0; i < list.size(); i++) {
			if (((String) list.get(i)).equals("(")) {
				ParenthesesIndex = i;
			} else if (((String) list.get(i)).equals(")")) {
				if (i - ParenthesesIndex == 1) {
					String jsgs2 = jsgs.substring(0, ParenthesesIndex) + "[]" + jsgs.substring(i + 1);
					return removeParentheses(deleteFy(jsgs2, "[]"));
				} else if (i - ParenthesesIndex <= 3) {
					delMap.put(new Integer(i), "true");
					delMap.put(new Integer(ParenthesesIndex), "true");
				}
			}
		}
		/**
		 * 删除项目
		 */
		String str = "";
		for (int i = 0; i < list.size(); i++) {
			if (delMap.get(new Integer(i)) == null) {
				str += list.get(i);
			}
		}
		/**
		 * 清除公式首位运算符
		 */
		list = jsgsToList(str);
		if (list.size() > 0) {
			if (((String) list.get(0)).equals("+") || ((String) list.get(0)).equals("-")) {
				str = "";
				for (int i = 1; i < list.size(); i++) {
					str += list.get(i);
				}
			}
		}
		if (delMap.size() > 0) {
			return removeParentheses(str);
		} else {
			return str;
		}
	}

	public static void main(String[] args){
		
		try{
			System.out.println("xxx");
		String[] suffixExp = {"0.0","0.1","*"};
		int len = suffixExp.length;
		Stack result = new Stack();
		String numa = null, numb = null;
		for (int i = 0; i < len; i++) {
			if (operator.containsKey(suffixExp[i])) {
				numb = (String) result.pop();
				numa = (String) result.pop();
				result.push(compute(numa, numb, suffixExp[i]));
			} else {
				result.push(suffixExp[i]);
			}
		}
		if (result.size() == 1)
			 result.pop();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}
