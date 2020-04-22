package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xiaobo.common.entity.SysUser;
import com.xiaobo.common.service.AltServiceImpl;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.Query;
import com.xiaobo.modules.sys.dao.SysDictDao;
import com.xiaobo.modules.sys.entity.SysDictEntity;
import com.xiaobo.modules.sys.service.SysDictService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service("sysDictService")
public class SysDictServiceImpl extends AltServiceImpl<SysDictDao, SysDictEntity> implements SysDictService {

	@Autowired
	private com.xiaobo.common.security.SecurityUtils securityUtils ;

	@Override
	public List<SysDictEntity> selectByTypeValue(String type, List<String> value) {

		QueryWrapper<SysDictEntity> wrapper = new QueryWrapper<>();
		wrapper.eq("type", type);
		wrapper.in("value", value);


		return this.list(wrapper);
	}

	@Override
    public PageUtils queryPage(SysDictEntity entity , PageUtils page) {

    	String key = entity.getDictName();

    	QueryWrapper<SysDictEntity> wrapper = new QueryWrapper<>();

    	if(StringUtils.isNotBlank(key)) {
    		wrapper.like( "type" , key).or().like("dict_name", key).or().like("description", key);
    	}

        IPage<SysDictEntity> ipage = this.page(
                new Query<SysDictEntity>(page).getPage(),
                wrapper

        );

        return new PageUtils(ipage);
    }


    @Override
    public SysDictEntity byTypeDictName(String type, String dictName) {
    	QueryWrapper<SysDictEntity> skuEntityWrappers = new QueryWrapper<>();
        skuEntityWrappers.eq("type",type).eq("dict_name",dictName);
        SysDictEntity sysDictEntity = this.getOne(skuEntityWrappers);
        return sysDictEntity;
    }

	@Override
	public SysDictEntity byTypeDictValue(String type, String value) {

		String key = getRedisKey("byTypeDictValue." + type + "." + value);
		if(redisUtils.containKey(key)) {
			return redisUtils.get(key, SysDictEntity.class);
		}

		QueryWrapper<SysDictEntity> skuEntityWrappers = new QueryWrapper<>();
	     skuEntityWrappers.eq("type",type).eq("value",value);
	     SysDictEntity sysDictEntity = this.getOne(skuEntityWrappers);

	     redisUtils.set(key, sysDictEntity);

	     return sysDictEntity;
	}

	@Override
	public boolean save(SysDictEntity entity) {
		// TODO Auto-generated method stub
		if(entity.getCreateDate() == null) {
			entity.setCreateDate(new Date());
			entity.setUpdateDate(new Date());
		}

		if(entity.getCreateBy() == null) {

			SysUser user = securityUtils.getCurrentUser();

			entity.setCreateBy(user.getUserId());
			entity.setUpdateBy(user.getUserId());
		}

		return super.save(entity);
	}

	@Override
	public boolean updateById(SysDictEntity entity) {

		entity.setUpdateDate(new Date());


		SysUser user = securityUtils.getCurrentUser();

		entity.setUpdateBy(user.getUserId());

		return super.updateById(entity);
	}

	@Override
	public List<String> getTableTitle(String[] values){
		return baseMapper.getTableTitle(values);
	}

	public List<String> getByType(String type){ return baseMapper.getByType(type);}

}

