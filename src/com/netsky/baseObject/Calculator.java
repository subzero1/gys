package com.netsky.baseObject;

import java.util.*;
import com.netsky.baseFormatUtils.NumberFormatUtil;

/**
 * 
 * ����ѧ���ʽ������ ���뻷����JDK 1.4 ���÷����� String Calculator.exec(String exp, Map data)
 * throws Exception ������ exp ����Ϊ��Ч���ʽ data [����]��"0.12" ֧�֣� 1.��Ч����� + - / * ( )
 * 2.Ƕ������ 3.������Ϊ���Ч�� 4.����data��ֵΪ���� ��֧�֣� 1.û�ж�����ı��ʽ������Ч��Ч��
 * 2.exp�в�֧�ִ����Ų��������磺4/-2��-0.21*3�� 3.û�жԼ�����С��λ���о��ȴ���
 * 
 * ���ߣ����� ���ڣ�2009-4-24
 * 
 */
public class Calculator {

	/**
	 * ����� + * - / �����������ţ������ȼ� 0:�� 1:��
	 */
	private static HashMap operator = new HashMap();
	static {
		operator.put("+", new Integer(0));
		operator.put("-", new Integer(0));
		operator.put("*", new Integer(1));
		operator.put("/", new Integer(1));
	}

	/**
	 * �����ʽ�в�������������𿪴洢 ���磺 ���ʽ��1+2-3*4/5 ���Ϊ��[1,+,2,-,3,*,4,/,5]
	 */
	private static List parse(String exp) throws Exception {

		List result = new ArrayList();

		String opStr = exp.replaceAll("\\d", "").replaceAll("\\.", "");// ������ʽ�����е������
		String curOp = null;// ��¼��ǰ�������
		int loc = 0;// ��¼��ǰ��������ڱ��ʽ�е�λ��

		try {
			for (int i = 0; i < opStr.length(); i++) {
				curOp = opStr.substring(i, i + 1);
				loc = exp.indexOf(curOp);
				// �����ǰ��������ǣ���
				if (!exp.substring(0, loc).trim().equals(""))
					result.add(exp.substring(0, loc).trim());
				result.add(exp.substring(loc, loc + 1));
				exp = exp.substring(loc + 1);
			}
			if (exp.length() > 0)
				result.add(exp.trim());
		} catch (Exception e) {
			throw new Exception("����������������ʱ�쳣��" + e.getMessage());
		}
		return result;
	}

	/**
	 * ������������ȼ������ʽ����׺���ʽת��Ϊ��׺���ʽ(�沨�����ʽ) ���磺 ��׺���ʽ��1+2*3-4/5*6+7-8/9
	 * ��׺���ʽ��123*45/6*7+89/--+
	 */
	private static String[] getSuffixExp(List infixExp) throws Exception {
		Stack result = new Stack();
		Stack tmpOp = new Stack();// �洢��ʱ��ת�������

		Iterator it = infixExp.iterator();
		String curContent = null;
		try {
			while (it.hasNext()) {
				curContent = (String) it.next();
				/*
				 * ����������������һ��(ջ��)����������ȼ����бȽϣ� ��ǰ >��һ�����ѵ�ǰ����tmpOpջ ��ǰ<=��һ��������һ����tmpOpջ��,����resultջ���ѵ�ǰ����tmpOpջ
				 * ����ǲ�������ֱ����resultջ
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
			// ��tmpOpջ��ʣ����������resultջ
			while (tmpOp.size() > 0)
				result.push(tmpOp.pop());
		} catch (Exception e) {
			tmpOp = null;
			result = null;
			throw new Exception("ת��Ϊ��׺���ʽʱ�쳣��" + e.getMessage());
		}
		// ��resultջ�е�����ת��String[]
		int len = result.size();
		String[] suffixExp = new String[len];
		for (int i = 0; i < len; i++)
			suffixExp[len - i - 1] = (String) result.pop();
		tmpOp = null;
		result = null;
		return suffixExp;
	}

	/**
	 * ��׺���ʽ����
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
			throw new Exception("��׺���ʽ����ȷ����ʱ�쳣");
	}

	/**
	 * ��������
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
					throw new Exception("������Ϊ�� " + (numA + operator + numB));
				return NumberFormatUtil.roundToString(NumberFormatUtil.divToString(numA, numB, 4));
			default:
				return numA;
			}
		} catch (Exception e) {
			throw new Exception("��������ʱ�쳣��" + e.getMessage());
		}
	}

	/**
	 * ������ʽ��ֵ
	 */
	private static String calculate(List infixExp) throws Exception {
		String curContent = null;
		List mainExp = new ArrayList();// ���������ŵ�������Ҫ����ı��ʽ
		List subExp = new ArrayList();// ��������Ҫ���ȼ���ı��ʽ
		Iterator it = infixExp.iterator();
		int leftStart = 0;// ��ͬһ�������������Ÿ���
		int rightEnd = 0;// ��ͬһ�������������Ÿ���
		while (it.hasNext()) {
			curContent = (String) it.next();
			if (curContent.equals("(")) {
				++leftStart;
				subExp.add(curContent);
			} else if (curContent.equals(")")) {
				++rightEnd;
				subExp.add(curContent);
				// ����ҵ���һ����������ݹ飨Ƕ�����ţ�������
				if (rightEnd == leftStart) {
					subExp.remove(0);// ȥ����ͷ�ģ�
					subExp.remove(subExp.size() - 1);// ȥ����β�ģ�
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
			throw new Exception("���� " + exp + " ��ʽʱ�쳣: " + e.getMessage());
		}
	}

	/**
	 * ɾ����ʽ��ĳ����
	 * 
	 * @param jsgs
	 *            ���㹫ʽ
	 * @param fy
	 *            ��Ҫɾ���ķ���
	 * @return ������
	 */
	public static String deleteFy(String jsgs, String fy) throws Exception {
		jsgs = jsgs.replaceAll(" ", "");
		/**
		 * �����㹫ʽת��Ϊlist��ʽ
		 */
		List list = jsgsToList(jsgs);
		/**
		 * �����ڹ�ʽ��λ��list
		 */
		List indexList = new ArrayList();
		/**
		 * ��ɾ������list��λ�ô洢list
		 */
		Map delMap = new HashMap();
		/**
		 * ��ȡ�����ַ����ڹ�ʽ����λ��
		 */
		for (int i = 0; i < list.size(); i++) {
			if (((String) list.get(i)).equals(fy)) {
				indexList.add(new Integer(i));
			}
		}
		/**
		 * ��ʽ��δ�ҵ���ط��ã�����ԭ��ʽ
		 */
		if (indexList.size() == 0) {
			return jsgs;
		}

		/**
		 * ѭ���������й�ʽ�г��ֵ��账�����
		 */
		for (int i = 0; i < indexList.size(); i++) {
			int index = ((Integer) indexList.get(i)).intValue();
			delMap.put(new Integer(index), "true");
			if (index > 0 && !(((String) list.get(index - 1)).equals("(") || ((String) list.get(index - 1)).equals(")"))) {
				delMap.put(new Integer(index - 1), "true");
			}
			/**
			 * ������ú���������ͣ������ú����������Ϊ*��/����Ҫ��˷���һ��ɾ��
			 */
			for (int j = index; j < list.size(); j++) {
				if (((String) list.get(j)).equals("*") || ((String) list.get(j)).equals("/")) {
					delMap.put(new Integer(j), "true");
					if (((String) list.get(j + 1)).equals("(")) {
						/**
						 * ������j+1ƥ���(,��ɾ����������
						 */
						int place = 0;// Ĭ��ƥ���һ���ҵ���)
						int now_place = 0;// ��ǰ��ȷƥ���)λ��
						for (int k = j + 2; k < list.size(); k++) {
							if (((String) list.get(k)).equals("(")) {
								place++;
							}
							if (((String) list.get(k)).equals(")") && now_place == place) {
								/**
								 * ɾ����ʽ�дӣ�j+1��-k��λ��
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
			 * �������ǰ��������ͣ������ú����������Ϊ*��/����Ҫ��˷���һ��ɾ��
			 */
			for (int j = index; j >= 0; j--) {
				if (((String) list.get(j)).equals("*") || ((String) list.get(j)).equals("/")) {
					delMap.put(new Integer(j), "true");
					if (((String) list.get(j - 1)).equals(")")) {
						/**
						 * ������j-1ƥ���(,��ɾ����������
						 */
						int place = 0;// Ĭ��ƥ���һ���ҵ���(
						int now_place = 0;// ��ǰ��ȷƥ���(λ��
						for (int k = j - 2; k >= 0; k--) {
							if (((String) list.get(k)).equals(")")) {
								place++;
							}
							if (((String) list.get(k)).equals("(") && now_place == place) {
								/**
								 * ɾ����ʽ�д�k-��j-1����λ��
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
		 * ɾ����Ŀ
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
	 * �����㹫ʽ�洢Ϊlist�ṹ���������Ϊ�ָ� ��([��Ҫ���Ϸ�]+[������豸��])*[����]%�洢Ϊ
	 * (,[��Ҫ���Ϸ�],+,[������豸��],),*,[����]%
	 * 
	 * @param jsgs
	 *            ����Ĺ�ʽ
	 * @return List ������
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
	 * ȥ�����������
	 * 
	 * @param jsgs
	 *            ����Ĺ�ʽ
	 * @return String ������
	 * @throws Exception
	 */
	private static String removeParentheses(String jsgs) throws Exception {
		/**
		 * ��ɾ������list��λ�ô洢list
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
		 * ɾ����Ŀ
		 */
		String str = "";
		for (int i = 0; i < list.size(); i++) {
			if (delMap.get(new Integer(i)) == null) {
				str += list.get(i);
			}
		}
		/**
		 * �����ʽ��λ�����
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
