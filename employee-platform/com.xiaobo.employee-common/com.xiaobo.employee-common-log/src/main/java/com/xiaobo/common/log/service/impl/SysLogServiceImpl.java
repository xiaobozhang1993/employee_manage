
package com.xiaobo.common.log.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.log.entity.SysLogEntity;
import com.xiaobo.common.log.dao.SysLogDao;
import com.xiaobo.common.log.service.SysLogService;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.common.utils.Query;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogDao, SysLogEntity> implements SysLogService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String)params.get("key");
 
         
        
        IPage<SysLogEntity> page = this.page(
            new Query<SysLogEntity>(params).getPage(),
           // pageI,
            new QueryWrapper<SysLogEntity>().like(StringUtils.isNotBlank(key),"username", key)
            
            .orderByDesc("create_date")
        );

        return new PageUtils(page);
    }

    public List<SysLogEntity> queryLog(String username){
        return this.baseMapper.queryLog(username);
    }
}
