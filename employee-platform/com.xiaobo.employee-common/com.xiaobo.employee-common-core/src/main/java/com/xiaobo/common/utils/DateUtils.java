
package com.xiaobo.common.utils;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期处理
 *
 * @author zhangxiaobo
 *
 * @date 2016年12月21日 下午12:53:33
 */
public class DateUtils {
	/** 时间格式(yyyy-MM-dd) */
	public final static String DATE_PATTERN = "yyyy-MM-dd";
	/** 时间格式(yyyy-MM-dd HH:mm:ss) */
	public final static String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    /**
     * 日期格式化 日期格式为：yyyy-MM-dd
     * @param date  日期
     * @return  返回yyyy-MM-dd格式日期
     */
	public static String format(Date date) {
        return format(date, DATE_PATTERN);
    }

    /**
     * 日期格式化 日期格式为：yyyy-MM-dd
     * @param date  日期
     * @param pattern  格式，如：DateUtils.DATE_TIME_PATTERN
     * @return  返回yyyy-MM-dd格式日期
     */
    public static String format(Date date, String pattern) {
        if(date != null){
            SimpleDateFormat df = new SimpleDateFormat(pattern);
            return df.format(date);
        }
        return null;
    }



    public static String formatMineDate(Date date) {

        Calendar curr = Calendar.getInstance();

        int date_id = DateUtils.getDateId(date);
        int curr_id = DateUtils.getDateId(curr.getTime());
        //判断是否是今天
        if(date_id == curr_id) {
            return DateUtils.format(date , "HH:mm");
        }

        // 判断是否本周 或许当前周的周一
        curr.set(Calendar.DAY_OF_WEEK , 1);

        if(curr.getTime().before(date)) {
            // 本周
            String[] weeks = {"天","一","二","三","四","五","六"} ;
            curr.setTime(date);
            int dayOfWeek = curr.get(Calendar.DAY_OF_WEEK);
            return "星期" + weeks[dayOfWeek - 1] ;
        }

        return DateUtils.format(date , "yyyy-MM-dd HH:mm:ss");

    }

    public static void main(String[] args) {



    	Date date = stringToDate("2019-01-20 00:01:11", "yyyy-MM-dd HH:mm:ss");

    	String str = formatMineDate(date);

    	System.out.println(str);


	}

    public static Integer getDateId(Date date) {

    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(date);

    	int year = calendar.get(Calendar.YEAR) * 10000;
    	int month = (calendar.get(Calendar.MONTH) + 1) * 100 ;
    	int day =  calendar.get(Calendar.DAY_OF_MONTH);

    	if(month < 10) {
    		year = year * 10;
    	}


    	return year + month + day ;

    }

    /**
     * 字符串转换成日期
     * @param strDate 日期字符串
     * @param pattern 日期的格式，如：DateUtils.DATE_TIME_PATTERN
     */
    public static Date stringToDate(String strDate, String pattern) {
        if (StringUtils.isBlank(strDate)){
            return null;
        }

        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        return fmt.parseLocalDateTime(strDate).toDate();
    }

    /**
     * 根据周数，获取开始日期、结束日期
     * @param week  周期  0本周，-1上周，-2上上周，1下周，2下下周
     * @return  返回date[0]开始日期、date[1]结束日期
     */
    public static Date[] getWeekStartAndEnd(int week) {
        DateTime dateTime = new DateTime();
        LocalDate date = new LocalDate(dateTime.plusWeeks(week));

        date = date.dayOfWeek().withMinimumValue();
        Date beginDate = date.toDate();
        Date endDate = date.plusDays(6).toDate();
        return new Date[]{beginDate, endDate};
    }

    /**
     * 对日期的【秒】进行加/减
     *
     * @param date 日期
     * @param seconds 秒数，负数为减
     * @return 加/减几秒后的日期
     */
    public static Date addDateSeconds(Date date, int seconds) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusSeconds(seconds).toDate();
    }

    /**
     * 对日期的【分钟】进行加/减
     *
     * @param date 日期
     * @param minutes 分钟数，负数为减
     * @return 加/减几分钟后的日期
     */
    public static Date addDateMinutes(Date date, int minutes) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusMinutes(minutes).toDate();
    }

    /**
     * 对日期的【小时】进行加/减
     *
     * @param date 日期
     * @param hours 小时数，负数为减
     * @return 加/减几小时后的日期
     */
    public static Date addDateHours(Date date, double hours) {
        DateTime dateTime = new DateTime(date);

        long duration = (long) (hours * 60 * 60 * 1000) ;

        // 判断是否有小数
        return dateTime.plus(duration).toDate();

    }

    /**
     * 对日期的【小时】进行加/减
     *
     * @param date 日期
     * @param hours 小时数，负数为减
     * @return 加/减几小时后的日期
     */
    public static Date addDateHours(Date date, int hours) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusHours(hours).toDate();
    }

    /**
     * 对日期的【天】进行加/减
     *
     * @param date 日期
     * @param days 天数，负数为减
     * @return 加/减几天后的日期
     */
    public static Date addDateDays(Date date, int days) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusDays(days).toDate();
    }

    /**
     * 对日期的【周】进行加/减
     *
     * @param date 日期
     * @param weeks 周数，负数为减
     * @return 加/减几周后的日期
     */
    public static Date addDateWeeks(Date date, int weeks) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusWeeks(weeks).toDate();
    }

    /**
     * 对日期��������月】进行加/减
     *
     * @param date 日期
     * @param months 月数，负数为减
     * @return 加/减几月后的日期
     */
    public static Date addDateMonths(Date date, int months) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusMonths(months).toDate();
    }

    /**
     * 对日期的【年】进行加/减
     *
     * @param date 日期
     * @param years 年数，负数为减
     * @return 加/减几年后的日期
     */
    public static Date addDateYears(Date date, int years) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusYears(years).toDate();
    }

    // 将一个字符串（格式化）日期转化为Date日期
    public static Date fomatDate(String dateTime){
         Date date1900 = new Date(0,0,0);
        if(dateTime!=null){
            //设置属性值
            dateTime=dateTime.replaceAll("\\.","-").replaceAll("/","-").replaceAll("年","-").replaceAll("月","-").replaceAll("日", "").replaceAll("[\\u4e00-\\u9fa5]", "").trim();
            //System.out.println("date:"+dateTime);
            String[] temps=dateTime.split("-");
            if(temps.length==1){
                try {
                    Integer days = Integer.parseInt(temps[0]);
                    if(days > 2200) {

                        long newdays = date1900.getTime() + (days-1)*24*3600*1000L;
                        return new Date(newdays);
                    }
                }catch (Exception e) {

                }

                dateTime=temps[0]+"-01-01";
            }
            if(temps.length==2){
                dateTime=temps[0]+"-"+temps[1]+"-01";
            }
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return sdf.parse(dateTime);
        }catch (Exception e) {
            return null;
        }

    }
}
