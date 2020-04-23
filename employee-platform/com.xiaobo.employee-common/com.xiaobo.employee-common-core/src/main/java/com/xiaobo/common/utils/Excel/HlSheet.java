package com.xiaobo.common.utils.Excel;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * 自定义sheet页内容结构
 * @author zhangxiaobo
 *
 */
public class HlSheet {

	private String name ;
	
	String[] columns ;
	
	
	public void setColumns(String[] columns) {
		this.columns = columns;
	}
	
	public String[] getColumns() {
		return columns;
	}
	
	public HlSheet(String name , String[] columns) {
		this.name = name;
		this.columns = columns;
	}
	
	
	/**
	 * 每行的数据 用逗号分开有多少个写多少个
	 */
	private List<String[]> lines = new LinkedList<String[]>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<String[]> getLines() {
		return lines;
	}

	public void addLine( String[]  line) {
	 
		lines.add(line);
	}
	
	public void addLines(Collection<String[]> lines) {
		this.lines.addAll(lines);
	}
	
	public void addDatas(Collection<?>  lines) {
		for(Object o : lines) {
			this.lines.add(o.toString().split(","));
		}
		 
	}
	
	public void clear() {
		this.lines.clear();
	}
	
	
	
	
	
}
