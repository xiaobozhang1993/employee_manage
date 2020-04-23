package com.xiaobo.common.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class StringUtils {
	
	public static String listToString(List<String> list) {
		StringBuffer sb = new StringBuffer();
		for(String s : list) {
			sb.append(s + ",");
		}
		
		if(sb.length() > 0) {
			sb.deleteCharAt(sb.length() - 1);
		}
		return sb.toString();
		
	}

	public static String[] regexp(String context , String regex) {
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(context);
		if(m.find()) {
			List<String> list = new LinkedList<>();
			
			for(int i = 1 ; i <= m.groupCount() ; i++) {
				list.add(m.group(i));
			}
			
			return list.toArray(new String[0]);
		}
		
		return null;
	}
	
	public static String trim(String str , String c) {
		if(str.startsWith(c)) {
			str = str.substring(str.indexOf(c) + 1);
		}
		if(str.endsWith(c)) {
			str = str.substring(0, str.lastIndexOf(c));
		}
		
		return str ;
	}
	
	 
	
/*	
	public static String[] maches(String str , String regex) {
		
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(str);
		List<String> list = new ArrayList<String>();
		
//		while(m.find()) {
//			
//			int cnt = m.groupCount();
//			for(int i = 0 ; i< cnt ; i++) {
//				list.add(m.group(i + 1));
//			}
//		}
		
		while(m.find()) {
			list.add(m.group());
		}
		
		return list.toArray(new String[0]);
	}*/
	
	/**
	 *  获取文件后缀名称
	 * @param filename 文件名称
	 * @return
	 */
	public static String getSuffixName(String filename) {
		String suffix = "unknow" ;
		
		//获取后缀
		int index = filename.lastIndexOf(".");
		if(index >= 0) {
			suffix = filename.substring(index + 1);
		}
		return suffix;
	}
	
	/**
	   *

	   *  去掉指定字符串的开头和结尾的指定字符
	   * 

	   *
	   * @param stream 要处理的字符串
	   * @param trimstr 要去掉的字符串
	   * @return 处理后的字符串
	   */
	  public static String sideTrim(String stream, String trimstr) {
	    // null或者空字符串的时候不处理
	    if (stream == null || stream.length() == 0 || trimstr == null || trimstr.length() == 0) {
	      return stream;
	    }
	 
	    // 结束位置
	    int epos = 0;
	 
	    // 正规表达式
	    String regpattern = "[" + trimstr + "]*+";
	    Pattern pattern = Pattern.compile(regpattern, Pattern.CASE_INSENSITIVE);
	 
	    // 去掉结尾的指定字符 
	    StringBuffer buffer = new StringBuffer(stream).reverse();
	    Matcher matcher = pattern.matcher(buffer);
	    if (matcher.lookingAt()) {
	      epos = matcher.end();
	      stream = new StringBuffer(buffer.substring(epos)).reverse().toString();
	    }
	 
	    // 去掉开头的指定字符 
	    matcher = pattern.matcher(stream);
	    if (matcher.lookingAt()) {
	      epos = matcher.end();
	      stream = stream.substring(epos);
	    }
	 
	    // 返回处理后的字符串
	    return stream;
	  }
	  
	  /**
	   * 返回 #{} 或者 ${} 中包含的值
	   * @param str
	   * @param type
	   * @return eg:#{name} ${ages} 
	   */
	  public static String[] getWildcard(String str ) {
		  
		 List<String> list = new ArrayList<String>();
		 
		 int start = 0;
		 while(start < str.length() && start >= 0) {
			 
			 start = str.indexOf("{", start);
			 
			 int end = str.indexOf("}", start);
			 if(start > 0) {
				 String wc = str.substring(start - 1 , end + 1);
				 
				 list.add(wc);
			 }
			
			 if(start < 0) break ;
			 
			 start = end + 1;
			 
		 }
		 
		 return list.toArray(new String[0]);
		  
	  }
	  
	  /**
	   * 判断是否是手机�����
	   * @param phone
	   * @return
	   */
	  public static boolean isTelNum(String phone) {
		  
		 // Pattern p = Pattern.compile("1[34578]\\d{9}");
		  
		  return phone != null && phone.trim().matches("^\\d{3,4}-?\\d+$") ;
		  
	  }
	  
	  /**
	   * 判断是否是手机号
	   * @param phone
	   * @return
	   */
	  public static boolean isPhoneNum(String phone) {
		  
		 // Pattern p = Pattern.compile("1[34578]\\d{9}");
		  
		  return phone != null && phone.trim().matches("^1[3456789]\\d{9}$") ;
		  
	  }

	  public static boolean validPass(String pass) {
		  
		  if(pass == null || pass.trim().length() < 10 || pass.trim().length() > 12) {
			  return false ;
		  }
		  
		  // 10～12字符，必须以大写字母开头，包含至少一个数字的组合。 
		  if(pass.matches("^[A-Z].*(?=\\d+).*$")) {
			  return true ;
		  }
		  
		  
		  return false ;
		  
	  }
	  
	  public static void main(String[] args) {
		
			String str = ",1212,2121," ;
			
			System.out.println(trim(str, ","));
		  
	}
	  
	  
	/**
	 * 判断邮箱格式
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email){
	  	return email !=null && email.matches("^[A-Za-z\\d]+([-_.][A-Za-z\\d]+)*@([A-Za-z\\d]+[-.])+[A-Za-z\\d]{2,4}$");
	  }
	 
	  
	  /**
	   * 判断是否为数字
	   * @param v
	   * @return
	   */
	  public static boolean isNumber(Object v) {
		  
		  if(v == null) return false; 
		  
		  if(v instanceof Number) {
			  return true ;
		  } else if(v.toString().matches("^\\d+$")) {
			  return true ;
		  } else if(v.toString().matches("^-?\\d+\\.?\\d+$")) {
			  return true ;
		  } else {
			  try{
				  Double.parseDouble(v.toString());
				  return true ;
			  }catch(Exception e) {
				  return false;
			  }
			 
			  
		  }
		  
	  }
	  
	  /**
	   * 判断是否为数字
	   * @param v
	   * @return
	   */
	  public static boolean isInt(Object v) {
		  
		  if(v == null) return false; 
		  
		  if(v instanceof Integer || v instanceof Long) {
			  return true ;
		  } else if(v.toString().matches("^\\d+$")) {
			  return true ;
		  }  
		  return false;
		  
	  }

	  
	  
	  @SuppressWarnings("unchecked")
	public static <T> T format(Object v , Class<T> type) {
		  if(v == null) return null;
		  
		  if(type == Integer.class) {
			  if(v instanceof Number) {
				  return (T) Integer.valueOf( ((Number)v).intValue());
			  } else if(v.toString().matches("^-?\\d+$")){
				  return (T) Integer.valueOf(v.toString());
			  }
		  } else if(type == Double.class) {
			  if(v instanceof Number) {
				  return (T) Double.valueOf( ((Number)v).doubleValue());
			  } else if(v.toString().matches("^-?\\d+(\\.\\d+)?$")) {
				  return (T) Double.valueOf(v.toString());
			  }
		  } else if(type == String.class) {
			  
				return (T) v.toString();
			  
		  }
		  
		  return null;
	  }
	  
	  public static String formatDate(Date date , String pattern){
		  
		  SimpleDateFormat f = new SimpleDateFormat(pattern);
		  return f.format(date);
		  
	  }
	  
	  @SuppressWarnings("unchecked")
	public static <T> T format(String v , Class<T> type) {
		  
		  if(type == Integer.class) {
			 
			  //正则匹配 
			  Double d = format(v, Double.class);
			  if(d != null) {
				  return (T) Integer.valueOf(d.intValue());
			  } 
		  } else if(type == Double.class) {
			//正则匹配 
			  if(v.matches("^-?\\d+(\\.\\d+)?$")) {
				  return (T)Double.valueOf(v);
			  }
		  } else if(type == Boolean.class) {
			  if(v.equalsIgnoreCase("true")) return (T)Boolean.TRUE;
			  else if (v.equalsIgnoreCase("false")) {
				  return (T)Boolean.FALSE;
			}
				
			  
		  }
		  
		  return null;
	  }
	  
	 
	  /** 
	     * @param str：正常的字符串 
	     * @return 压缩字符串 类型为：  ³)°K,NIc i£_`Çe#  c¦%ÂXHòjyIÅÖ` 
	     * @throws IOException 
	     */  
	    public static String compress(String str) throws IOException {     
	      if (str == null || str.length() == 0) {     
	        return str;     
	      }     
	      ByteArrayOutputStream out = new ByteArrayOutputStream();     
	      GZIPOutputStream gzip = new GZIPOutputStream(out);     
	      gzip.write(str.getBytes());     
	      gzip.close();     
	      return out.toString("ISO-8859-1");     
	    }     
	  
	     
	    /** 
	     * @param str：类型为：  ³)°K,NIc i£_`Çe#  c¦%ÂXHòjyIÅÖ` 
	     * @return 解压字符串  生成正常字符串。 
	     * @throws IOException 
	     */  
	    public static String uncompress(String str) throws IOException {     
	      if (str == null || str.length() == 0) {     
	        return str;     
	      }     
	      ByteArrayOutputStream out = new ByteArrayOutputStream();     
	      ByteArrayInputStream in = new ByteArrayInputStream(str     
	          .getBytes("ISO-8859-1"));   
	      GZIPInputStream gunzip = new GZIPInputStream(in);     
	      byte[] buffer = new byte[256];     
	      int n;     
	      while ((n = gunzip.read(buffer)) >= 0) {     
	        out.write(buffer, 0, n);     
	      }     
	      // toString()使用平台默认编码，也可以显式的指定如toString("GBK")     
	      return out.toString();     
	    }     
	  
	    /** 
	     * @param jsUriStr :字符串类型为：%1F%C2%8B%08%00%00%00%00%00%00%03%C2%B3)%C2%B0K%2CNI%03c%20i%C2%A3_%60%C3%87e%03%11%23%C2%82%0Dc%C2%A6%25%C3%82XH%C3%B2jyI%C3%85%05%C3%96%60%1E%00%17%C2%8E%3Dvf%00%00%00 
	     * @return 生成正常字符串 
	     * @throws IOException  
	     */  
	    public static String  unCompressURI(String jsUriStr) throws IOException {  
	        String decodeJSUri=URLDecoder.decode(jsUriStr,"UTF-8");  
	        String gzipCompress=uncompress(decodeJSUri);  
	        return gzipCompress;  
	    }  
	    /** 
	     * @param strData :字符串类型为： 正常字符串 
	     * @return 生成字符串类型为：%1F%C2%8B%08%00%00%00%00%00%00%03%C2%B3)%C2%B0K%2CNI%03c%20i%C2%A3_%60%C3%87e%03%11%23%C2%82%0Dc%C2%A6%25%C3%82XH%C3%B2jyI%C3%85%05%C3%96%60%1E%00%17%C2%8E%3Dvf%00%00%00 
	     * @throws IOException  
	     */  
	    public static String  compress2URI(String strData) throws IOException {  
	        String encodeGzip=compress(strData);  
	        String jsUriStr=URLEncoder.encode(encodeGzip,"UTF-8");  
	        return jsUriStr;  
	    }
}
