package com.xiaobo.common.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.ReflectUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;


public class AltServiceImpl<M extends BaseMapper<T>, T> extends ServiceImpl<M, T> {
 
	
	@Autowired
	protected RedisUtils redisUtils;
	 
	protected String simpleRedisName ;
	 
	@Override
	public boolean updateById(T entity) {
		// TODO Auto-generated method stub
		boolean update = super.updateById(entity);
		
		if(update) { 
			//从泛型中拿到tableid
			Object id = ReflectUtils.reflectObjectId(entity);
			if(id != null) {
				redisUtils.delete(entity.getClass().getSimpleName() + "." + id.toString());
				//redisUtils.set(entity.getClass().getSimpleName() + "." + id.toString(), entity);
			} 
		}
		
		return update ;
	}
	
	/**
	 * 获取当前类下的通用redis缓存key , 这样清空的时候可以统一清空
	 * @param name
	 * @return
	 */
	public String getRedisKey(String name) {
		if(simpleRedisName == null) {
			simpleRedisName = getClass().getSimpleName();
		}
		
		return simpleRedisName + "." + name ;
	}
	
	@Override
	public boolean removeById(Serializable id) {
		// TODO Auto-generated method stub
		boolean delete = super.removeById(id);
		 
		if(delete && simpleRedisName != null) { 
			redisUtils.delete(simpleRedisName + "." + id.toString());
		}
		return delete ;
	}
	
	@Override
	public T getById(Serializable id) {
		// TODO Auto-generated method stub
		
		if(simpleRedisName != null) {
			System.out.println(simpleRedisName + " , " + id);
			String key = simpleRedisName + "." + id;
			 
			T value = redisUtils.get(key, currentModelClass());
			if(value != null)
				return value;
		}
		
		
		
		T t = super.getById(id);
		if(t != null) {  
			if(id != null) {
				redisUtils.set(t.getClass().getSimpleName() + "." + id.toString(), t);
				
			}  
			if(simpleRedisName == null) {
				simpleRedisName =  getClass().getSimpleName();
			}
		}
		return t ;
	}
	
	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		// TODO Auto-generated method stub
		boolean delete = super.removeByIds(idList);
		if(delete && simpleRedisName != null) {
			for(Serializable id : idList) {
				redisUtils.delete(simpleRedisName + "." + id.toString());
			}
		}
		
		return delete ;
	}
	
	@Override
	public boolean removeByMap(Map<String, Object> columnMap) {
		
		//这种搞不清到底删了什么数据,把该类型的缓存全部删了
		 
		boolean delete = super.removeByMap(columnMap);
		if(delete && simpleRedisName != null) {
			redisUtils.deletePattern(simpleRedisName + "*");
		}
		return delete ;
	}
	
	 @Override
	public boolean remove(Wrapper<T> wrapper) {
		// TODO Auto-generated method stub
		 boolean delete =  super.remove(wrapper);
		if(delete && simpleRedisName != null) {
			redisUtils.deletePattern(simpleRedisName + "*");
		}
		return delete ;
	}
	
	@Override
	public boolean update(T entity, Wrapper<T> wrapper) {
		// TODO Auto-generated method stub
		boolean update = super.update(entity, wrapper);
		if(update) {
			Object id = ReflectUtils.reflectObjectId(entity);
			if(id != null) {
				redisUtils.delete(entity.getClass().getSimpleName() + "." + id.toString());
				
				//redisUtils.set(entity.getClass().getSimpleName() + "." + id.toString(), entity);
			}
			
		}
		return update ;
	}
	
	 
	
	@Override
	public boolean updateBatchById(Collection<T> entityList, int batchSize) {
		// TODO Auto-generated method stub
		boolean update = super.updateBatchById(entityList, batchSize);
		if(update) {
			for(T t : entityList) {
				Object id = ReflectUtils.reflectObjectId(t);
				if(id == null) continue ;
				redisUtils.delete(t.getClass().getSimpleName() + "." + id.toString());
				//redisUtils.set(t.getClass().getSimpleName() + "." + id.toString(), t);
				 
			}
			
		}
		
		return update ;
	}
 
}
