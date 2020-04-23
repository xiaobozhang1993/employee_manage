package com.xiaobo.modules.sys.controller;


import com.xiaobo.common.utils.R;
import com.xiaobo.common.utils.RsaUtils;
import com.xiaobo.modules.sys.entity.SysUserEntity;
import com.xiaobo.modules.sys.entity.SysUserTokenEntity;
import com.xiaobo.modules.sys.form.SysLoginForm;
import com.xiaobo.modules.sys.service.SysCaptchaService;
import com.xiaobo.modules.sys.service.SysUserService;
import com.xiaobo.modules.sys.service.SysUserTokenService;
import com.xiaobo.sys.controller.AbstractController;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Set;

/**
 * 登录相关
 * 
 * zhangxiaobo
 * @date 2017年11月10日 下午1:15:31
 */
@RestController
public class SysLoginController extends AbstractController {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserTokenService sysUserTokenService;
	@Autowired
	private SysCaptchaService sysCaptchaService;

	/**
	 * 验证码
	 */
	@GetMapping("captcha.jpg")
	public void captcha(HttpServletResponse response, String uuid)throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-store, no-cache");
		response.setContentType("image/jpeg");

		//获取图片验证码
		BufferedImage image = sysCaptchaService.nextCaptcha(uuid);

		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(image, "jpg", out);
		IOUtils.closeQuietly(out);
	}

	/**
	 * 登录
	 */
	@PostMapping("/sys/login")
	public Map<String, Object> login(@RequestBody SysLoginForm form)throws IOException {
		boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
		if(!captcha){
			return R.error("验证码不正确");
		}

		//用户信息
		SysUserEntity user = sysUserService.queryByUserNo(form.getUserNo());

		//密码还原
		String dePass = RsaUtils.decryptByPrivateKey(form.getPassword());
		if(dePass == null) {
			return R.error("密码不正确");
		}
		
		//账号不存在、密码错误
		if(user == null || !user.getPassword().equals(new Sha256Hash(dePass, user.getSalt()).toHex())) {
			return R.error("账号或密码不正确");
		}

		//账号锁定
		if(user.getStatus() == 0){
			return R.error("账号已被锁定,请联系管理员");
		}

		//生成token，并保存到数据库
		R r = sysUserTokenService.createToken(user.getUserId(),form.getBrowser(),form.getOs());

        user.setLastLoginTime(new Date());
        //更新最后一次登录时间
        sysUserService.updateLastDate(user);

		// 查询用户所有权限码 带上
		Set<String> perms = sysUserService.queryAllPerms(user.getUserId()); 
		r.put("perms", perms);
		
		// 用户信息
		user.setPassword(null);
		user.setSalt(null);
		user.setContext(null);
		r.put("user", user);
		
		
		return r;
	}


	/**
	 * 退出
	 */
	@PostMapping("/sys/logout")
	public R logout() {
		sysUserTokenService.logout(getUserId());
		sysUserTokenService.updateLogoutTime(getUserId());
		return R.ok();
	}

	/**
	 * 强制退出
	 */
	@PostMapping("/forceToExit")
	@ApiOperation("强制退出")
	public R forceToExit(@RequestBody String[] ids){
		SysUserTokenEntity token = new SysUserTokenEntity();
		for (String userId : ids) {
			sysUserTokenService.logout(userId);
			sysUserTokenService.updateLogoutTime(userId);
		}
		return R.ok();
	}

}
