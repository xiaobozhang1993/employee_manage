package com.xiaobo.common.utils;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * class反射工具
 * @author zhangxiaobo
 * @date 2018年8月17日 上午10:37:16
 */
public class ReflectUtils {

	/**
	 * 反射得出该实体配置的具体表名
	 * @param c
	 * @return
	 */
	public static <T> String reflectObjectTable(Class<T> c) {
		
		TableName tn = c.getAnnotation(TableName.class);
		
		if(tn != null) {
			return tn.value();
		}
		return null;
		
	}
	

	/**
	 *  通过mybatis反射获取当前字段的数据库字段名称
	 * @param t 实体类型
	 * @param fieldName 字段名称
	 * @return 数据库中该字段的映射
	 */
	public static <T> String reflectFiledTableColumn(Class<T> t , String fieldName) {
		
		 try {
			 
			Field f = t.getDeclaredField(fieldName);
			  
			if(f == null) return null ;
			
			if(f.isAnnotationPresent(TableField.class)) {
				TableField tf = f.getAnnotation(TableField.class);
				
				// 字段不再表中体现
				if(tf != null && !tf.exist()) return null;
				
				if(tf != null && tf.exist()) {
					return tf.value();
				}
				
				
				
			}
			// 没有注解 则将大写转下划线
			
			return com.baomidou.mybatisplus.core.toolkit.StringUtils.camelToUnderline(fieldName);
					
			
		} catch (NoSuchFieldException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public static void main(String[] args) {
		
		String str = "tableName" ;
		
		str = com.baomidou.mybatisplus.core.toolkit.StringUtils.camelToUnderline(str);
		
		System.out.println(str);
		
		
	}
	
	/**
	 * 拿到object中 注解TableId的值
	 * @param t 实体
	 * @return 实体中���解了tableId的字段的值,如果没有注解tableid,或者没有get方法 返回null
	 */
	public static <T> Object reflectObjectId(T t) {
		
		//Field[] fs = t.getClass().getDeclaredFields();
		List<Field> fs = getAllFields(t);
		for(Field f : fs) {
			 
			if(f.isAnnotationPresent(TableId.class)) {
				//拿到get方法 获取值
				String getMethodName = "get" + StringUtils.capitalize(f.getName());
				
				try {
					Method m = t.getClass().getMethod(getMethodName, null);
					
					if(m != null) {
						return m.invoke(t, null);
					}
					
				} catch (NoSuchMethodException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SecurityException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
			}
			 
		}
		 return null;
	}
	
	/**
	 * 获取包含父类在内的所有字段Field
	 * @param t
	 * @return
	 */
	private static List<Field> getAllFields(Object t){
		  List<Field> fieldList = new ArrayList<>() ;
		  Class tempClass = t.getClass();
		  while (tempClass != null) {//当父类为null的时候说明到达了最上层的父类(Object类).
		        fieldList.addAll(Arrays.asList(tempClass .getDeclaredFields()));
		        tempClass = tempClass.getSuperclass(); //得到父类,然后赋给自己
		  }
		  
		  return fieldList;
		 
		 }
	
}
