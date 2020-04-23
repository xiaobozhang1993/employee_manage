package com.xiaobo.modules.sys.service.impl;


import com.xiaobo.common.service.AltServiceImpl;
import com.xiaobo.modules.sys.dao.SysFileDao;
import com.xiaobo.modules.sys.entity.SysFileEntity;
import com.xiaobo.modules.sys.service.SysFileService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("sysFileService")
public class SysFileServiceImpl extends AltServiceImpl<SysFileDao, SysFileEntity> implements SysFileService {

    @Override
    public List<SysFileEntity> queryFileList(String resId,Integer state) {
        return baseMapper.queryFileList(resId,state);
    }

    @Override
    public void deleteByResId(String resId,Integer state){ baseMapper.deleteByResId(resId,state); }
}
