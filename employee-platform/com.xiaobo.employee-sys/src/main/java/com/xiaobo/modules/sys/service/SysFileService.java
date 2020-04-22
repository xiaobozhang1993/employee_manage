package com.xiaobo.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.modules.sys.entity.SysFileEntity;

import java.util.List;

public interface SysFileService extends IService<SysFileEntity> {

    List<SysFileEntity> queryFileList(String resId, Integer state);

    void deleteByResId(String resId, Integer state);
}
