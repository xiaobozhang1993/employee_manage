
package com.xiaobo.common.utils;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.commons.lang.StringUtils;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

/**
 * 分页工具类
 *
 * @author zhangxiaobo
 *
 * @date 2016年11月4日 下午12:59:00
 */
public class PageUtils implements Serializable {
	private static final long serialVersionUID = 1L;
	//总记录数
	private long totalCount;
	//每页记录数
	private long pageSize = 10;//默认十条
	//总页数
	private long totalPage;
	//当前页数
	private long currPage = 1;
	//列表数据
	private List<?> list;

	private String orderField ;

	private Boolean asc ;

	// 兼容之前得字段 2019-10-11
	private int page ;
	private int limit ;

	public void setPage(int page) {
		this.page = page;
		this.currPage = page;
	}

	public void setLimit(int limit) {
		this.limit = limit;
		this.pageSize = limit;
	}

	 public int getPage() {
		return (int) (this.page > 0 ? this.page : this.currPage);
	}

	public int getLimit() {
		return (int) (this.limit > 0 ? this.limit : this.pageSize);
	}




	public int getStartPage() {
		return (int) ((currPage-1)*pageSize);
	}



	public PageUtils(){
		super();
	}

	/**
	 * 分页
	 * @param list        列表数据
	 * @param totalCount  总记录数
	 * @param pageSize    每页记录数
	 * @param currPage    当前页数
	 */
	public PageUtils(List<?> list, int totalCount, int pageSize, int currPage) {
		this.list = list;
		this.totalCount = totalCount;
		this.pageSize = pageSize;
		this.currPage = currPage;
		this.totalPage = (int)Math.ceil((double)totalCount/pageSize);
	}

	/*@JsonIgnore
	public String getLimit(){
		return " limit "+this.getStartPage()+","+this.getPageSize();
	}*/
	/**
	 * 分页
	 */
	public PageUtils(IPage<?> page) {
		this.list = page.getRecords();
		this.totalCount = (int)page.getTotal();
		this.pageSize = page.getSize();
		this.currPage = page.getCurrent();
		this.totalPage = (int)page.getPages();
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public long getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize>100?100:pageSize;//页大小不能高于100
		this.pageSize = pageSize<10?10:pageSize;//页大小不能低于10
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public long getCurrPage() {
		return currPage;
	}

	public void setCurrPage(long currPage) {
		this.currPage = currPage<1?1:currPage;
	}

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}



	public String getOrderField() {
		return orderField;
	}



	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}



	public Boolean getAsc() {
		return asc;
	}



	public void setAsc(Boolean asc) {
		this.asc = asc;
	}



	public <T> Page<T> getPage(Class<T> c) {

		Page<T> p = new  Page<T>(currPage, pageSize);



		//防止SQL注入（因为sidx、order是通过拼接SQL实现排序的，会有SQL注入风险）
		String orderField =  getOrderField();
		Boolean asc = getAsc();




		//排序
		if(StringUtils.isNotBlank(orderField) && asc != null){

			OrderItem oi = new OrderItem();
			oi.setColumn(orderField);
			oi.setAsc(asc);


			p.setOrders(Arrays.asList(oi));

		}
		return p;

	}

}
