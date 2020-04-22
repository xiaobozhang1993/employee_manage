package com.xiaobo.common.utils;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.Map.Entry;

public class HttpUtils {
	
	private static Logger logger = LoggerFactory.getLogger(HttpUtils.class);

	/*private static HttpClient client = null;
	 
	
	private static HttpClient getHttpClient() {
		if(client == null){
			client = new HttpClient();
			client.getParams().setContentCharset("UTF-8");
		}
			
 
		return client ;
	}*/
	
	/**
	 * 通过get请求获取数据
	 * @param url
	 * @param cnt 链接失败尝试最多请求的次数
	 * @return
	 */
	public static String getHttpGetResponseStream(String url , int cnt)  {
		GetMethod getMethod = new GetMethod(url);
		HttpClient client = new HttpClient();
		client.getParams().setContentCharset("UTF-8");
		//HttpClient client = getHttpClient();

		int code;
		try {
			code = client.executeMethod(getMethod);
			if(code == 200) {
				String result = getMethod.getResponseBodyAsString();
				return result;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			logger.error("http client get execute error , test cnt : " + cnt , e);
			//如果是连接不能打开,则尝试再连一次
			if(e.getMessage() != null && e.getMessage().contains("Connection is not open") && cnt < 3) {
				return getHttpGetResponseStream(url , cnt+1);
			}
			
			
		}
		

		return null;
	}
	
	/**
	 * http post 请求
	 * @param url
	 * @param params
	 * @return
	 */
	public static String getHttpPostResponseStream(String url , java.util.Map<String, Object> params)  {
		PostMethod post = new PostMethod(url);
		NameValuePair[] parts = new NameValuePair[params.size()];
		
		int index = 0;
		for(Entry<String, Object> entry : params.entrySet()) {
			parts[index] = new Header(entry.getKey(), String.valueOf(entry.getValue()));
			index++ ;
		}
		
		post.setRequestBody(parts);
		
		HttpClient client = new HttpClient();
		client.getParams().setContentCharset("UTF-8");
		
		try {
			int status = client.executeMethod(post);
			if(status == 200) {
				return post.getResponseBodyAsString();
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			logger.error("http client post execute error . " , e);
		}

		return null;
	}
	
}
