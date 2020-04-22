package com.xiaobo.common.redis;

/**
 * Redis切面处理类
 *
 * @author zhangxiaobo
 * 
 * @date 2017-07-17 23:30
 */
//@Aspect
//@Configuration
public class RedisAspect {
   /* private Logger logger = LoggerFactory.getLogger(getClass());
    // 是否开启redis缓存  true开启   false关闭
    @Value("${spring.redis.open: false}")
    private boolean open;
    
    public RedisAspect() {
		// TODO Auto-generated constructor stub
    	System.out.println("###############");
	}
    
     
       // 定义一个切入点
      
    // @Pointcut("execution (* findById*(..))")
    @Pointcut("@annotation(com.tr.common.annotation.TrCache)")
    public void excudeRedis(){
    	
    }

    @Around("excudeRedis()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        Object result = null;
        if(open){
        	
            try{
                result = point.proceed();
            }catch (Exception e){
                logger.error("redis error", e);
                throw new RRException("Redis服务异常");
            }
            System.out.println("redis open ....: " + result);
        }
        return result;
    } */
}
