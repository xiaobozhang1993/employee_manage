package com.xiaobo.modules.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

@TableName("sys_res_file")
public class SysFileEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableField("file_uid")
    public String fileUid;

    @TableField("res_id")
    public String resId;

    @TableField("file_name")
    public String fileName;

    @TableField("state")
    @ApiModelProperty("0 notice 1 resource")
    public Integer state;

    @TableField("file_url")
    public String fileUrl;

    @TableField(exist = false)
    public Object response;

    public String getFileUid() {
        return fileUid;
    }

    public void setFileUid(String fileUid) {
        this.fileUid = fileUid;
    }

    public String getResId() {
        return resId;
    }

    public void setResId(String resId) {
        this.resId = resId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public Object getResponse() {
        return response;
    }

    public void setResponse(Object response) {
        this.response = response;
    }
}
