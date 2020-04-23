package com.xiaobo.common.utils.lbs;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.GetMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.*;

public class GisUtils {

	static Logger logger = LoggerFactory.getLogger(GisUtils.class);

	static double pi = Math.PI;
	static double a = 6378245.0;
	static double ee = 0.00669342162296594323;
	public static double x_pi = pi * 3000.0 / 180.0;

	static double[] wgs2gcj(double lat, double lon) {
		double dLat = transformLat(lon - 105.0, lat - 35.0);
		double dLon = transformLon(lon - 105.0, lat - 35.0);
		double radLat = lat / 180.0 * pi;
		double magic = Math.sin(radLat);
		magic = 1 - ee * magic * magic;
		double sqrtMagic = Math.sqrt(magic);
		dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
		dLon = (dLon * 180.0) / (a / sqrtMagic * Math.cos(radLat) * pi);
		double mgLat = lat + dLat;
		double mgLon = lon + dLon;
		double[] loc = { mgLat, mgLon };
		return loc;
	}

	static double[] wgs2bd(double lat, double lon) {
		double[] wgs_gcj = wgs2gcj(lat, lon);
		double[] gcj_bd = gcj2bd(wgs_gcj[0], wgs_gcj[1]);
		return gcj_bd;
	}

	public static double[] gcj2bd(double lat, double lon) {
		double x = lon, y = lat;
		double z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * x_pi);
		double theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * x_pi);
		double bd_lon = z * Math.cos(theta) + 0.0065;
		double bd_lat = z * Math.sin(theta) + 0.006;
		return new double[] { bd_lat, bd_lon };
	}

	public static double[] bd2gcj(double lat, double lon) {
		double x = lon - 0.0065, y = lat - 0.006;
		double z = Math.sqrt(x * x + y * y) - 0.00002 * Math.sin(y * x_pi);
		double theta = Math.atan2(y, x) - 0.000003 * Math.cos(x * x_pi);
		double gg_lon = z * Math.cos(theta);
		double gg_lat = z * Math.sin(theta);
		return new double[] { gg_lat, gg_lon };
	}

	private static double transformLat(double lat, double lon) {
		double ret = -100.0 + 2.0 * lat + 3.0 * lon + 0.2 * lon * lon + 0.1 * lat * lon
				+ 0.2 * Math.sqrt(Math.abs(lat));
		ret += (20.0 * Math.sin(6.0 * lat * pi) + 20.0 * Math.sin(2.0 * lat * pi)) * 2.0 / 3.0;
		ret += (20.0 * Math.sin(lon * pi) + 40.0 * Math.sin(lon / 3.0 * pi)) * 2.0 / 3.0;
		ret += (160.0 * Math.sin(lon / 12.0 * pi) + 320 * Math.sin(lon * pi / 30.0)) * 2.0 / 3.0;
		return ret;
	}

	private static double transformLon(double lat, double lon) {
		double ret = 300.0 + lat + 2.0 * lon + 0.1 * lat * lat + 0.1 * lat * lon + 0.1 * Math.sqrt(Math.abs(lat));
		ret += (20.0 * Math.sin(6.0 * lat * pi) + 20.0 * Math.sin(2.0 * lat * pi)) * 2.0 / 3.0;
		ret += (20.0 * Math.sin(lat * pi) + 40.0 * Math.sin(lat / 3.0 * pi)) * 2.0 / 3.0;
		ret += (150.0 * Math.sin(lat / 12.0 * pi) + 300.0 * Math.sin(lat / 30.0 * pi)) * 2.0 / 3.0;
		return ret;
	}

	public static double distance(double lon1, double lat1, double lon2, double lat2) {
		double x, y, outx;
		x = (lon2 - lon1) * Math.PI * 6371229 * Math.cos(((lat1 + lat2) / 2) * Math.PI / 180) / 180;
		y = (lat2 - lat1) * Math.PI * 6371229 / 180;
		outx = Math.sqrt(x * x + y * y);
		return outx;
	}

	/**
	 * 坐标转换
	 * 
	 * @param points 点信息
	 * @param iv     T转point
	 * @param tend   point回填
	 */
	public static <T> void translateWgs84ToBD09(List<T> points, TPointValue<T> iv, TTransEnd<T> tend) {

		Map<Point, List<T>> point_cells = new HashMap<Point, List<T>>();
		for (T t : points) {
			Point p = iv.getPoint(t);

			List<T> ts = point_cells.get(p);
			if (ts == null) {
				ts = new LinkedList<T>();
				point_cells.put(p, ts);
			}
			ts.add(t);

		}

		//
		List<Point> list_points = new LinkedList<Point>();
		list_points.addAll(point_cells.keySet());

		int psize = list_points.size();

		int limit = 100;

		int retry = 0;

		for (int i = 0; i < psize; i += limit) {

			List<Point> ps = list_points.subList(i, i + limit >= psize ? psize : i + limit);

			String url = url(ps, 0);

			// 解析
			String result = null;
			try {
				result = getHttpGetResponseStream(url);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				logger.error("parse baidu url error ", e);
				// continue ;
			}

			/*
			 * if(result == null) { throw new RuntimeException("解析异常,url未返回正常数据.url:" +
			 * url); }
			 */

			List<Point> rets = result != null ? translate(result) : null;

			if (rets == null) {
				// 重新请求一次

				if (retry > 3) {
					System.out.println("解析异常, 转换中第:" + i + " ~ " + (i + limit) + " 条请求三次未能从webservice服务中解析转换");
					// throw new RuntimeException("重试3次以上请求无响应");
				}
				i -= limit;
				retry++;
				continue;
			} else {
				retry = 0;
			}

			if (rets != null && rets.size() == ps.size()) {

				// 回填
				int index = 0;
				for (Point p : ps) {

					List<T> ts = point_cells.get(p);
					Point trans_p = rets.get(index);
					for (T t : ts) {
						tend.transEnd(t, trans_p);
					}

					index++;
				}

			} else {

				System.out.println("解析异常,转换中第:" + i + " ~ " + (i + limit) + " 条未能解析转换");

			}

		}

	}

	private static List<Point> translate(String result) {
		List<Point> points = new LinkedList<Point>();
		JSONObject jsonObject = JSON.parseObject(result);
		Integer status = jsonObject.getInteger("status");
		if (status.equals(0)) {
			JSONArray as = jsonObject.getJSONArray("result");

			int size = as.size();
			for (int i = 0; i < size; i++) {

				Point _point = as.getObject(i, Point.class);
				points.add(_point);
			}

		}
		return points;
	}

	private static String url(List<Point> points, int souse) {
		int type = 0;
		if (souse == 0) {
			type = 1;
		} else if (souse == 4) {
			type = 2;
		} else {
			type = 6;
		}

		StringBuilder sb = new StringBuilder(
				"http://api.map.baidu.com/geoconv/v1/?from=" + type + "&to=5&ak=" + getBdAk() + "&coords=");

		for (Point p : points) {
			// Point p = getPoint(cd);
			BigDecimal bny = new BigDecimal(p.getY() + "");
			BigDecimal bnx = new BigDecimal(p.getX() + "");
			sb.append(bnx + "," + bny + ";");
		}

		sb.deleteCharAt(sb.length() - 1);

		return sb.toString();
	}

	// 经纬度转地址
	private static String transadd(String result) {
		JSONObject jsonObject = JSON.parseObject(result);
		Integer status = jsonObject.getInteger("status");
		String cityname = null;
		if (status.equals(0)) {
			JSONObject as = jsonObject.getJSONObject("result");
			cityname = as.getString("formatted_address");

		}
		return cityname;
	}

	private static String urladd(List<Point> points) {

		StringBuilder sb = new StringBuilder(
				"http://api.map.baidu.com/geocoder/v2/?coordtype=wgs84ll&output=json&ak=" + getBdAk() + "&location=");

		for (Point p : points) {
			// Point p = getPoint(cd);
			sb.append(p.getY() + "," + p.getX());
		}

		return sb.toString();
	}

	// 地址转经纬度

	// 经纬度转地址
	private static Point transaddtolona(String result) {
		JSONObject jsonObject = JSON.parseObject(result);
		Point point = new Point();
		Integer status = jsonObject.getInteger("status");
		if (status.equals(0)) {
			JSONObject as = jsonObject.getJSONObject("result");
			JSONObject obj = as.getJSONObject("location");
			Double lon = obj.getDouble("lng");
			Double lat = obj.getDouble("lat");
			if (lon > 0 && lat > 0) {
				point.setX(lon);
				point.setY(lat);
			}

		}
		return point;
	}

	private static String urladdtolona(List<String> str) {

		StringBuilder sb = new StringBuilder(
				"http://api.map.baidu.com/geocoder/v2/?output=json&ak=" + getBdAk() + "&address=");

		for (String p : str) {
			// Point p = getPoint(cd);
			if (p != null && !p.contains("null") && !p.equals("") && p != "null") {
				try {
					p = java.net.URLEncoder.encode(p, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				p = "";
			}

			sb.append(p);
		}

		return sb.toString();
	}

	public static List<Point> translateWgs84ToBD09(List<Point> points) {

		List<Point> list = new LinkedList<Point>();

		int psize = points.size();

		StringBuilder sb = new StringBuilder();
		sb.append("http://api.map.baidu.com/geoconv/v1/?from=1&to=5&ak=" + getBdAk() + "&coords=");
		int index = 0;
		for (Point p : points) {
			index++;

			sb.append(p.getX() + "," + p.getY() + ";");

			if (index % 100 == 0 || index == psize) {
				// index = 0;
				sb.deleteCharAt(sb.length() - 1);

				String result = null;
				try {
					result = getHttpGetResponseStream(sb.toString());

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					continue;
				}

				if (result == null) {
					// return Collections.emptyList();
					continue;
				}

				JSONObject jsonObject = JSON.parseObject(result);
				Integer status = jsonObject.getInteger("status");
				if (status.equals(0)) {
					JSONArray as = jsonObject.getJSONArray("result");

					int size = as.size();
					for (int i = 0; i < size; i++) {

						Point _point = as.getObject(i, Point.class);
						list.add(_point);
					}

				}
				sb.delete(0, sb.length());
				sb.append("http://api.map.baidu.com/geoconv/v1/?from=1&to=5&ak=" + getBdAk() + "&coords=");

			}

		}

		return list;
	}

	public static String getHttpGetResponseStream(String url) throws HttpException, IOException {
		GetMethod getMethod = new GetMethod(url);

		HttpClient client = new HttpClient();

		int code = client.executeMethod(getMethod);
		if (code == 200) {
			String result = getMethod.getResponseBodyAsString();
			return result;
		}

		return null;
	}

	private static final String[] BDMAP_KEYS = { "xWwc3nnZVb4TWBn7VkM5MRhtbdIUujiq", "IUOTZKGuU8BbcQ6pusKWEBCGxLhFUxeg",
			"6idHf6VmSoyv8EmWTGVhRoMB1HvSuA0L", "t18fPL0KALklMnOf8KmIy81mFvefIEGk", "lgNEUZ9PHOv7xoNgVIgSHcY0dQEFFzN8",
			"YAihj2u4Mcb0EaRLnUDXVnbyusZBWFcX", "8ZPaeOza0HKOPAwMNs3FAUYY0s2LORvP",
			"slKE3dAa4FZaGLFBKGbbLSbjRjIL5enO" };

	/**
	 * 返回一个百度地图的ak
	 * 
	 * @return
	 */
	private static String getBdAk() {

		int random = (int) (Math.random() * BDMAP_KEYS.length);

		return BDMAP_KEYS[random];
	}

	/**
	 * 根据经纬度返回当前位置的城市名称
	 * 
	 * @param lon 经度
	 * @param lat 纬度
	 * @return 传递的位置所处的城市和区
	 */
	public static String getLocationCity(double lon, double lat) {

		String url = "http://api.map.baidu.com/geocoder/v2/?location=" + lat + "," + lon + "&output=json&batch=true&ak="
				+ getBdAk();

		String result = null;
		try {
			result = getHttpGetResponseStream(url);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}

		if (result == null) {
			// return Collections.emptyList();
			return null;
		}

		JSONObject jsonObject = JSON.parseObject(result);
		Integer status = jsonObject.getInteger("status");
		if (status.equals(0)) {
			JSONArray as = jsonObject.getJSONArray("areas");

			int size = as.size();
			if (size > 0) {
				JSONObject obj = as.getJSONObject(0);
				return obj.getString("city") + "_" + obj.getString("district");
			}

		}

		return null;
	}

	public static void main(String[] args) {

		Double lon = 120.01;
		Double lat = 30.03;
		
		double[] t1  = wgs2bd(lat, lon);
		
		List<Point> list = new ArrayList<>();
		list.add(new Point(lon , lat));
		
		List<Point> ps = translateWgs84ToBD09(list);
		
		System.out.println(t1[0] + "_" + t1[1]);
		System.out.println(ps.get(0)); 
	}

}
