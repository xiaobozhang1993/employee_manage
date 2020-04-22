package com.xiaobo.common.redis;

import com.xiaobo.common.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;


/**
 * Redis工具类
 *
 * @author zhangxiaobo
 * 
 * @date 2017-07-17 21:12
 */
@Component
public class RedisUtils {
	
    //是否开启redis缓存  true开启   false关闭
    @Value("${spring.redis.open: false}")
    private boolean open = false;
	
    @Autowired(required=false)
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired(required=false)
    private ValueOperations<String, String> valueOperations;
    
    Map<String, Object> cache = new ConcurrentHashMap<>();
    /**
     * 缓存过期配置
     * key- 过期时间
     */
    Map<String, Long> cache_expire = new ConcurrentHashMap<>();
    
//    @Autowired
//    private HashOperations<String, String, Object> hashOperations;
//    @Autowired
//    private ListOperations<String, Object> listOperations;
//    @Autowired
//    private SetOperations<String, Object> setOperations;
//    @Autowired
//    private ZSetOperations<String, Object> zSetOperations;
    /**  默认过期时长，单位：秒 */
    public final static long DEFAULT_EXPIRE = 10  ;
    /**  不设置过期时长 */
    public final static long NOT_EXPIRE = -1;
    
    public void set(String key, Object value, long expire){
    	if(key == null || value == null) {
			return ;
		}
    	if(!open) {
    		//System.out.println("key : " + key + ",value:" + value );
    		
    		cache.put(key, value);
    		if(expire < 0) {
    			expire = DEFAULT_EXPIRE;
    		}
    		cache_expire.put(key, System.currentTimeMillis() + expire * 1000);
    		return ;
    	}
    	
    	String v = objectToString(value);
    	if(v == null)
    		return  ;
    	
    	 valueOperations.set(key, v);
         if(expire != NOT_EXPIRE){
             redisTemplate.expire(key, expire, TimeUnit.SECONDS);
         }
    }

    public void set(String key, Object value){
    	if(!open) {
    		set(key, value, DEFAULT_EXPIRE);
    		return ;
    	}
        set(key, value, DEFAULT_EXPIRE);
    }
 
	public <T> T get(String key, Class<T> clazz, long expire) {
    	if(!open) {
    		clearExpire();
    		cache.get(key);
    		return null;
    	}
    	  String value = valueOperations.get(key);
          if(expire != NOT_EXPIRE){
              redisTemplate.expire(key, expire, TimeUnit.SECONDS);
          }
        return value == null ? null : stringToObject(value, clazz);
    	
    //\	return null;
    }

    @SuppressWarnings("unchecked")
	public <T> T get(String key, Class<T> clazz) {
    	if(!open) {
    		clearExpire();
    		return (T) cache.get(key);
    		//return null;
    	}
        return get(key, clazz, NOT_EXPIRE);
    }
    
    public boolean containKey(String key) {
    	if(!open) {
    		 
    		clearExpire();
    		return cache.containsKey(key);
    	}
    	
    	return redisTemplate.hasKey(key);
    	//return false;
    }

  /*  private String get(String key, long expire  ) {
    	if(!open) {
    		clearExpire();
    		return (String) cache.get(key);
    		//return null;
    	}
    	String value = valueOperations.get(key);
        if(expire != NOT_EXPIRE){
            redisTemplate.expire(key, expire, TimeUnit.SECONDS);
        } 
        return  value;
    }
*/
    public String get(String key) {
    	if(!open) {
    		clearExpire();
    		return (String) cache.get(key);
    	}
        return get(key , String.class, NOT_EXPIRE);
    }

    public void delete(String key) {
    	if(!open) {
    		cache.remove(key);
    		cache_expire.remove(key);
    		return ;
    	}
         redisTemplate.delete(key);
    }
    
    public Set<String> patternKeys(String pattern){ 
    	if(!open) {
    		clearExpire();
    		
    		Set<String> keys = new HashSet<>();
    		for(String key : cache.keySet()) {
    			if(key.matches(pattern)) {
    				keys.add(key);
    			}
    		}
    		
    	 
    		return keys;
    	}
    	 return redisTemplate.keys(pattern);
    	
    	 
    }
    
    public void deleteCollections(Collection<String> keys) {
    	if(!open) {
    		clearExpire();
    		for(String key : keys) {
    			cache.remove(key);
    		}
    		
    		return ;
    	}
    	 redisTemplate.delete(keys);
    }
    
    public void deletePattern(String pattern) {
    	if(!open) {
    		clearExpire();
    		Set<String> keys = cache.keySet();
    		if(keys != null)
    		for(String key : keys) {
    			if(key.matches(pattern)) {
    				cache.remove(key);
    			}
    		}
    		
    		return ;
    	}
    	Set<String> keys = patternKeys(pattern);
    	if(keys != null && !keys.isEmpty()) {
    		deleteCollections(keys);
    	}
    	
    }

    public synchronized void clearExpire() {
     	
    	long ct = System.currentTimeMillis();
    	
    	String[] keys = cache_expire.keySet().toArray(new String[0]);
    	
    	for(String key : keys) {
    		Long time = cache_expire.get(key);
    		if(time != null && time < ct) {
    			cache.remove(key);
    			cache_expire.remove(key);
    		}
    	}
    	
    	 
    	
    }
    
    private String objectToString(Object object) {
    	
    	if(object  == null) return null;
     
    		return  IOUtils.getObjectStr(object);
     
    	
    }
    
    private <T> T stringToObject(String str, Class<T> clazz){ 
    	
    	if(str == null) return null ;
    	
    	return IOUtils.parseObject(str, clazz);
    }
}
