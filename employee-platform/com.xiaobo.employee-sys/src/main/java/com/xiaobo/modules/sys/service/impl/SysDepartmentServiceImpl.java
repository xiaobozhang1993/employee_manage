package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaobo.common.utils.PageUtils;
import com.xiaobo.modules.sys.dao.SysDepartmentDao;
import com.xiaobo.modules.sys.entity.SysDepartmentEntity;
import com.xiaobo.modules.sys.service.SysDepartmentService;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("sysDepartmentService")
public class SysDepartmentServiceImpl extends ServiceImpl<SysDepartmentDao, SysDepartmentEntity> implements SysDepartmentService {

    @Override
    public PageUtils queryPage(SysDepartmentEntity SysDepartment , PageUtils page ) {
        
        IPage<SysDepartmentEntity> ipage = this.page(
                page.getPage(SysDepartmentEntity.class),
                new QueryWrapper<SysDepartmentEntity>()
                        .eq("org_id",SysDepartment.getOrgId())
        );

        return new PageUtils(ipage);
    }

    @Override
    public List<SysDepartmentEntity> childList(String orgid){
        return baseMapper.childList(orgid);
    }

    @Override
    public SysDepartmentEntity queryDeptById(String depid){
        return baseMapper.queryDeptById(depid);
    }

    @Override
    public List<String> queryName(String orgId){return baseMapper.queryName(orgId);}
}
