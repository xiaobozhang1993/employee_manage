package com.xiaobo.modules.sys.entity.vo;


import java.util.Date;
import java.util.List;

public class SysOrgVo {

    /**
     * 组织编码
     */
    private String id;
    /**
     * 名称
     */
    private String name;
    /**
     * 上级组织
     */
    private String parentId;

    /**
     * 排序
     * */
    private int    orderNum;

    /**
     * 创建时间
     * */
    private Date createTime;

    /**
     * 修改时间
     * */
    private Date updateTime;

    /**
     * ICON图标*/
    private String fileIconName;

    private List<SysOrgVo>  list;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<SysOrgVo> getList() {
        return list;
    }

    public void setList(List<SysOrgVo> list) {
        this.list = list;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getFileIconName() {
        return fileIconName;
    }

    public void setFileIconName(String fileIconName) {
        this.fileIconName = fileIconName;
    }
}
