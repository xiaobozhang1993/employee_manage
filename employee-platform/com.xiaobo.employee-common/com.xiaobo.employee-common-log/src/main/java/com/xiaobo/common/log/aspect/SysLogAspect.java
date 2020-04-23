package com.xiaobo.common.log.aspect;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.log.entity.SysLogEntity;
import com.xiaobo.common.log.service.SysLogService;
import com.xiaobo.common.utils.HttpContextUtils;
import com.xiaobo.common.utils.IPUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * 系统日志，切面处理类
 * 
 * @author zhangxiaobo
 * @email  
 * @date 2017年3月8日 上午11:07:35
 */
@Aspect
@Component
public class SysLogAspect {
	@Autowired
	private SysLogService sysLogService;
	
	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils;

	@Pointcut("@annotation(com.xiaobo.common.log.annotation.SysLog)")
	public void logPointCut() { 
		
	}

	@Around("logPointCut()")
	public Object around(ProceedingJoinPoint point) throws Throwable {
		long beginTime = System.currentTimeMillis();
		//执行方法
		Object result = point.proceed();
		//执行时长(毫秒)
		long time = System.currentTimeMillis() - beginTime;

		//保存日志
		saveSysLog(point, time);

		return result;
	}

	private void saveSysLog(ProceedingJoinPoint joinPoint, long time) {
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Method method = signature.getMethod();

		SysLogEntity sysLog = new SysLogEntity();
		SysLog syslog = method.getAnnotation(SysLog.class);
		if(syslog != null){
			//注解上的描述
			sysLog.setOperation(syslog.value());
//			if(syslog.system() != null)
//				sysLog.setSystem(syslog.system().getName());
			
		}

		//请求的方法名
		String className = joinPoint.getTarget().getClass().getName();
		String methodName = signature.getName();
		sysLog.setMethod(className + "." + methodName + "()");
		
		// 回填模块
		

		//请求的参数
		Object[] args = joinPoint.getArgs();
		String[] paramNames = signature.getParameterNames();
		try{
			
//			String params = "" ;
 			JSONObject jo = new JSONObject();
			for(int i = 0 ; i < paramNames.length && i < args.length ; i++) {
				String pname = paramNames[i];
				Object value = args[i];
				
				if(value instanceof MultipartFile) {
					Map<String, Object> p_map = new HashMap<>();
					MultipartFile file = (MultipartFile)value;
					p_map.put("filename", file.getOriginalFilename());
					p_map.put("file_size", file.getSize());
					
					value = p_map;
				}
				String tempValue = JSON.toJSONString(value) ;//value.toString();
				value = tempValue.length()>2000?tempValue.substring(0,2000):tempValue;
				jo.put(pname, value);
			}
		
			
			String params = jo.toJSONString();
			sysLog.setParams(params);
		}catch (Exception e){

		}

		//获取request
		HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
		//设置IP地址
		sysLog.setIp(IPUtils.getIpAddr(request));

		SysUser user = securityUtils.getCurrentUser();
		
		//用户名
		String username = user != null ? user.getUserNo() : "unknow";
		sysLog.setUsername(username);

		sysLog.setTime(time);
		sysLog.setCreateDate(new Date());
		//保存系统日志
		sysLogService.save(sysLog);
	}
}
