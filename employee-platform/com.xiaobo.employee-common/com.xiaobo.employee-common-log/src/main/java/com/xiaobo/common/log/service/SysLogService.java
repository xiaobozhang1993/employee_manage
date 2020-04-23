
package com.xiaobo.common.log.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaobo.common.log.entity.SysLogEntity;
import com.xiaobo.common.utils.PageUtils;

import java.util.List;
import java.util.Map;


/**
 * 系统日志
 * 
 * @author zhangxiaobo
 * 
 * @date 2017-03-08 10:40:56
 */
public interface SysLogService extends IService<SysLogEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<SysLogEntity> queryLog(String username);

}
