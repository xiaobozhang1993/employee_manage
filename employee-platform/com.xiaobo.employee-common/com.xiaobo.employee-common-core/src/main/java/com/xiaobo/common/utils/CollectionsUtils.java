package com.xiaobo.common.utils;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class CollectionsUtils {

	public static Set<String> transletPerms(List<String> perms) {
		
		Set<String> set = new HashSet<>();
		
		for(String p : perms) {
			if(p == null || p.isEmpty()) continue;
			
			String[] ps = p.split(",");
			for(String s : ps) {
				set.add(s);
			}
		}
		
		return set ;
		
	}
	
	public static <T> Set<String> transletPerms(List<T> perms ,   TValue<T> tv) {
		
		Set<String> set = new HashSet<>();
		
		for(T p : perms) {
			if(p == null ) continue;
			Object v = tv.getValue(p);
			if(v == null || v.equals("")) continue ;
			
			String[] ps = v.toString().split(",");
			for(String s : ps) {
				set.add(s);
			}
		}
		
		return set ;
		
	}
	
	
	public static String collectionsToString(Collection<String> colls) {
		
		StringBuffer sb = new StringBuffer();
		for(String s : colls) {
			sb.append(s + ",");
		}
		
		if(sb.length() > 1) {
			sb.deleteCharAt(sb.length() - 1 ) ;
		}
		
		return sb.toString();
	}
	
}
