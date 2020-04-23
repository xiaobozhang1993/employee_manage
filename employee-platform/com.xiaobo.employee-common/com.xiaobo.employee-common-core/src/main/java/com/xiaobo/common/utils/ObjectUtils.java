package com.xiaobo.common.utils;


import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Object转map
 * @author zhangxiaobo
 *
 */
public class ObjectUtils {
  
    private static final String dateFormat = "yyyy-MM-dd" ;

    /**
     * 获取利用反射获取类里面的值和名称
     *
     * @param obj
     * @return
     * @throws IllegalAccessException
     */
    @SuppressWarnings("rawtypes")
	public static Map<String, Object> objectToMap(Object obj) throws IllegalAccessException {
        Map<String, Object> map = new HashMap<>();
        Class<?> clazz = obj.getClass();
       // System.out.println(clazz);
        for (Field field : clazz.getDeclaredFields()) {
            field.setAccessible(true);
            String fieldName = field.getName();
            Object value = field.get(obj);
            if(value != null && value instanceof List) {
            	//是集合 然后递归 
            	List<Object> list = new ArrayList<>();
            	@SuppressWarnings("unchecked")
				List<Object> tmp_ = (List)value;
            	for(Object t : tmp_) {
            		Map<String , Object> tmp_map = objectToMap(t);
            		list.add(tmp_map);
            	}
            	
            	value = list ;
            	
            } else if(value != null && value instanceof Date) {
            	value = new SimpleDateFormat(dateFormat).format(value);
            }
            map.put(fieldName, value);
        }
        return map;
    }
    
     

}
 