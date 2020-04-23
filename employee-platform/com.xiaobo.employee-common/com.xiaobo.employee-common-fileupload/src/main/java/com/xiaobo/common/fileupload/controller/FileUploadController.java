package com.xiaobo.common.fileupload.controller;

import com.xiaobo.common.fileupload.AltFileUtils;
import com.xiaobo.common.fileupload.entity.UploadFileInfoEntity;
import com.xiaobo.common.fileupload.service.UploadFileInfoService;
import com.xiaobo.common.log.annotation.SysLog;
import com.xiaobo.common.log.annotation.SysModule;
import com.xiaobo.common.redis.RedisUtils;
import com.xiaobo.common.utils.R;
import org.apache.commons.lang.StringUtils;
import org.csource.common.MyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;


@Controller
@RequestMapping("/file")
public class FileUploadController {

  @Autowired
  private UploadFileInfoService  uploadService;


  @Autowired
  private RedisUtils redisUtils ;

  /*
   * 允许被上传得文件类型
   */
  @SuppressWarnings("unchecked")
private Set<String> uploadTypes() {
	  String key = "upload_allow_types" ;
	  if(redisUtils.containKey(key)) {
		  return redisUtils.get(key, Set.class);
	  }

	  Set<String> types = new HashSet<>();

	  String ts = "bmp,jpg,jpeg,png,xls,xlsx,doc,docx,pdf,mp4,wmv,zip,txt,csv" ;



	  String[] ss = ts.split(",");

	  types.addAll(Arrays.asList(ss));

	  redisUtils.set(key, types , 30 * 60);

	  return types ;
  }



	@SysLog(value="上传文件",system = SysModule.sys)
	@PostMapping("/upload")
	@ResponseBody
	public R fileUpload(MultipartFile  file) throws Exception {

		// 获取文件名后缀 ,判断���件类型
		String filename = file.getOriginalFilename();

		String suffix = com.xiaobo.common.utils.StringUtils.getSuffixName(filename);

		// 判断是否再要求得范围内
		Set<String> types = uploadTypes();
		if(!types.contains(suffix.toLowerCase())) {
			return   R.error("该上传文件类型不支持.");
		}


		AltFileUtils altFile = AltFileUtils.getFileUtil();

		UploadFileInfoEntity entity = altFile.uploadFile(file);
		 if(entity == null) {
			 //  throw new Exception("上传失败");
			  return R.error("上传失败");
		  }


		  return R.ok().put("id", entity.getFileId()).put("url", entity.getFileUrl());

	}

	@SysLog(value="多文件上传",system = SysModule.sys)
	@PostMapping("/filesUpload")
	@ResponseBody
	public R filesUpload(@RequestParam("files") MultipartFile[] files) throws Exception {
		List<UploadFileInfoEntity> uploadFileInfoEntities=new ArrayList<UploadFileInfoEntity>();

  	    // 获取文件名后缀 ,判断���件类型
		for (MultipartFile file: files) {
			String filename = file.getOriginalFilename();

			String suffix = com.xiaobo.common.utils.StringUtils.getSuffixName(filename);

			// 判断是否再要求得范围内
			Set<String> types = uploadTypes();
			if(!types.contains(suffix.toLowerCase())) {
				return   R.error("该上传文件类型不支持.");
			}


			AltFileUtils altFile = AltFileUtils.getFileUtil();

			UploadFileInfoEntity entity = altFile.uploadFile(file);
			if(entity == null) {
				//  throw new Exception("上传失败");
				return R.error("上传失败");
			}else {
				uploadFileInfoEntities.add(entity);
			}
		}

		return R.ok().put("list", uploadFileInfoEntities);

	}


/*	@RequestMapping("/list")
	@ResponseBody
	public R  getFileListInfo(@RequestParam Map<String, Object> params) {
		PageUtils page =ztbAttachmentService.queryPage(params);
		return R.ok().put("page", page);
	}*/

	/**
	 * 删除文件  这里为真实删除
	 * @param id
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public R deleteFile(String id) {
		if(id == null) {
			return R.error("文件不存在");
		}

		 UploadFileInfoEntity ment =  uploadService.getById(id);

		 if(ment == null) {
			 return R.error("文件不存在");
		 }

		 AltFileUtils altFile = AltFileUtils.getFileUtil();

		boolean res = altFile.deleteFile(ment);


		if(res ) {

			// 数据库删除
			uploadService.removeById(id);

			return R.ok().put("file",ment);
		} else {
			return R.error("删除失败");
		}


	}

	@RequestMapping("/list")
	@ResponseBody
	public R list(String ids){

		if(ids == null || ids.isEmpty()) {
			return R.error("当前不存在文件");
		}

		String[] ss = ids.split(",");

		Collection<UploadFileInfoEntity> list = uploadService.selectList(ss);

		return R.ok().put("data", list);
	}


	@RequestMapping("/fileDown")
	public void  fileDowload(HttpServletResponse response,String uuid) throws MyException, IOException  {
		//
		if(StringUtils.isEmpty(uuid)) {
			return ;
		}

        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        //2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)
        UploadFileInfoEntity ment =  uploadService.getById(uuid);
        // uuid 根据ID查询到文件的具体存储路径和文件名

        String name =ment.getOldFileName();
        // 非IE浏览器的处理：
        name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
        response.setHeader("Content-disposition",String.format("attachment; filename=\"%s\"", name));
        response.setContentType("multipart/form-data");
        response.setCharacterEncoding("UTF-8");


		 AltFileUtils altFile = AltFileUtils.getFileUtil();

       //通过文件路径获得File对象(假如此路径中有一个download.pdf文件)
        OutputStream os = response.getOutputStream();
        altFile.downFile(ment, os);



	}




}
