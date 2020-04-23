
package com.xiaobo.modules.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.code.kaptcha.Producer;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.DateUtils;
import com.xiaobo.modules.sys.dao.SysCaptchaDao;
import com.xiaobo.modules.sys.entity.SysCaptchaEntity;
import com.xiaobo.modules.sys.service.SysCaptchaService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.util.Date;

/**
 * 验证码
 *
 * @author Mark sunlightcs@gmail.com
 * @since 2.0.0 2018-02-10
 */
@Service
public class SysCaptchaServiceImpl extends ServiceImpl<SysCaptchaDao, SysCaptchaEntity> implements SysCaptchaService {
    @Autowired
    private Producer producer;
    
    @Autowired
    private RedisUtils redisUtils;
    
    @Value("${spring.redis.open:false}")
    private boolean openRedis;

    @Override
    public BufferedImage nextCaptcha(String uuid) {
        if(StringUtils.isBlank(uuid)){
            throw new RRException("uuid不能为空");
        }
        //生成文字验证码
        String code = producer.createText();
        
        SysCaptchaEntity captchaEntity = new SysCaptchaEntity();
        captchaEntity.setUuid(uuid);
        captchaEntity.setCode(code);
        //5分钟后过期
        captchaEntity.setExpireTime(DateUtils.addDateMinutes(new Date(), 5));
        
        if(openRedis) {
        	//开始redis 则只在redis中进行验证码的缓存 不走数据库
        	redisUtils.set(getClass().getSimpleName() + "-" + uuid, captchaEntity ,   5 * 60);
        	 
        } else {
        	
            this.save(captchaEntity);
        }
         

        return producer.createImage(code);
    }

    @Override
    public boolean validate(String uuid, String code) {
    	 SysCaptchaEntity captchaEntity = null;
    	if(openRedis) {
    		//从redis取
    		captchaEntity = redisUtils.get(getClass().getSimpleName() + "-" + uuid , SysCaptchaEntity.class);
    	} else {
    		captchaEntity = this.getOne(new QueryWrapper<SysCaptchaEntity>().eq("uuid", uuid));
    		//删除验证码
            this.removeById(uuid);
    	}
    	
        if(captchaEntity == null){
            return false;
        }
 

        if(captchaEntity.getCode().equalsIgnoreCase(code) && captchaEntity.getExpireTime().getTime() >= System.currentTimeMillis()){
            return true;
        }

        return false;
    }
}
