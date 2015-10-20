package com.netsky.dataObject;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class MethodTest {

	public static void main(String args[]) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		TestObject t = new TestObject();
		Class clazz = t.getClass();
		Method method[] = clazz.getDeclaredMethods();
		for (int i = 0; i < method.length; i++) {
			Class clazz1[] = method[i].getParameterTypes();
			for (int j = 0; j < clazz1.length; j++) {
				System.out.println(clazz.getName().substring(clazz.getName().lastIndexOf(".") + 1, clazz.getName().length()) + " :: "
						+ method[i].getName().replaceFirst("set", "").toUpperCase() + " :: " + clazz1[j].getName());
				// clazz1[j].getClass();
				// method[i].invoke(t, new String[]{"1"});
			}
		}
	}
}
