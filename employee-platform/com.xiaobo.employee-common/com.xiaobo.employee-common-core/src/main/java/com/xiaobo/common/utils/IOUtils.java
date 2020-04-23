package com.xiaobo.common.utils;

import java.io.*;
import java.util.Base64;

public class IOUtils {
	
	public static String getObjectStr(Object obj) {
		
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		
		ObjectOutputStream out = null;
		
		try {
			 out = new ObjectOutputStream(bout);
			out.writeObject(obj);
			out.flush();
			byte[] bs = bout.toByteArray();
			
			return Base64.getEncoder().encodeToString(bs);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
		
		
		return null ;
		
		
	}
	 
	@SuppressWarnings({ "hiding", "unchecked" })
	public static <T>  T  parseObject(String s , Class<T> clazz) {
		
		byte[] bs = Base64.getDecoder().decode(s);
		
		ObjectInputStream in;
		try {
			in = new ObjectInputStream(new ByteArrayInputStream(bs));
			Object obj = in.readObject();
			return  (T) obj ;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		return null ;
		
	
	}

}
