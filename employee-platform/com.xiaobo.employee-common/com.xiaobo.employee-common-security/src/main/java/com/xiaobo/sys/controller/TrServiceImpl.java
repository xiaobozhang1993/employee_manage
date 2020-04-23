package com.xiaobo.sys.controller;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

public class TrServiceImpl<M extends BaseMapper<T>, T>  extends ServiceImpl<M , T> implements IService<T>{

	@Override
	public boolean save(T entity) {
		// TODO Auto-generated method stub
		return super.save(entity);
	}

	@Override
	public boolean saveBatch(Collection<T> entityList, int batchSize) {
		// TODO Auto-generated method stub
		return super.saveBatch(entityList,batchSize);
	}

	@Override
	public boolean saveOrUpdateBatch(Collection<T> entityList, int batchSize) {
		// TODO Auto-generated method stub
		return super.saveOrUpdateBatch(entityList, batchSize);
	}

	@Override
	public boolean removeById(Serializable id) {
		// TODO Auto-generated method stub
		return super.removeById(id);
	}

	@Override
	public boolean removeByMap(Map<String, Object> columnMap) {
		// TODO Auto-generated method stub
		return super.removeByMap(columnMap);
	}

	@Override
	public boolean remove(Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.remove(queryWrapper);
	}

	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		// TODO Auto-generated method stub
		return super.removeByIds(idList);
	}

	@Override
	public boolean updateById(T entity) {
		// TODO Auto-generated method stub
		return super.updateById(entity);
	}

	@Override
	public boolean update(T entity, Wrapper<T> updateWrapper) {
		// TODO Auto-generated method stub
		return super.update(entity,updateWrapper);
	}

	@Override
	public boolean updateBatchById(Collection<T> entityList, int batchSize) {
		// TODO Auto-generated method stub
		return super.updateBatchById(entityList, batchSize);
	}

	@Override
	public boolean saveOrUpdate(T entity) {
		// TODO Auto-generated method stub
		return super.saveOrUpdate(entity);
	}

	@Override
	public T getById(Serializable id) {
		// TODO Auto-generated method stub
		return super.getById(id);
	}

	@Override
	public Collection<T> listByIds(Collection<? extends Serializable> idList) {
		// TODO Auto-generated method stub
		return super.listByIds(idList);
	}

	@Override
	public Collection<T> listByMap(Map<String, Object> columnMap) {
		// TODO Auto-generated method stub
		return super.listByMap(columnMap);
	}

	@Override
	public T getOne(Wrapper<T> queryWrapper, boolean throwEx) {
		// TODO Auto-generated method stub
		return super.getOne(queryWrapper,throwEx);
	}

	@Override
	public Map<String, Object> getMap(Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.getMap(queryWrapper);
	}

	@Override
	public <V> V getObj(Wrapper<T> queryWrapper, Function<? super Object, V> mapper) {
		// TODO Auto-generated method stub
		return super.getObj(queryWrapper, mapper);
	}

	@Override
	public int count(Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.count(queryWrapper);
	}

	@Override
	public List<T> list(Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.list(queryWrapper);
	}

	@Override
	public IPage<T> page(IPage<T> page, Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.page(page,queryWrapper);
	}

	@Override
	public List<Map<String, Object>> listMaps(Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.listMaps(queryWrapper);
	}

	@Override
	public <V> List<V> listObjs(Wrapper<T> queryWrapper, Function<? super Object, V> mapper) {
		// TODO Auto-generated method stub
		return super.listObjs(queryWrapper, mapper);
	}

	@Override
	public IPage<Map<String, Object>> pageMaps(IPage<T> page, Wrapper<T> queryWrapper) {
		// TODO Auto-generated method stub
		return super.pageMaps(page, queryWrapper);
	}
 

	@Override
	public M getBaseMapper() {
		return super.getBaseMapper();
	}

}
