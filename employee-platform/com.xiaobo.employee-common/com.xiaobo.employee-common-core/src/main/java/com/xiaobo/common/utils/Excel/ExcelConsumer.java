package com.xiaobo.common.utils.Excel;

import com.xiaobo.common.utils.DateUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.Date;
import java.util.function.Consumer;

public class ExcelConsumer implements Consumer<Row>{

	private int cnt ;
	 
	private String file_id;
	private String split;
	
	
	
	public int getCnt() {
		return cnt;
	}



	public void setCnt(int cnt) {
		this.cnt = cnt;
	}


 


	public String getFile_id() {
		return file_id;
	}



	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}



	public String getSplit() {
		return split;
	}



	public void setSplit(String split) {
		this.split = split;
	}


	private BufferedWriter bw = null;

	public ExcelConsumer(BufferedWriter bw, String file_id, String split) {
		super();
		this.bw = bw;
		this.file_id = file_id;
		this.split = split;
		
		 
	}

	private int cellCnt = 0;

	@Override
	public void accept(Row t) {
		
		int rowcnt = t.getPhysicalNumberOfCells();
		if(rowcnt == 0) return ;
		if(cnt == 0) {
			cellCnt = rowcnt;
			cnt++;
			return ;
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(file_id + split);
		int v_cnt = 0; // 实际由数据的字段 如果一行中一个由数据的字段都没有 说明结束了
		for(int i = 0 ; i < cellCnt ; i++) {
			Cell cell = t.getCell(i);
		 
			Object value = ExcelUtils.getCellValue(cell);

			String valueStr = "" ;

			if(value != null ) {
				if(value instanceof Date) {
					valueStr = DateUtils.format((Date)value	, DateUtils.DATE_TIME_PATTERN);
				} else {
					valueStr = value.toString();
				} 
			} 
			 
			sb.append(valueStr + split); 
			
			v_cnt += (value != null ? 1 : 0);
		}
		
		if(v_cnt == 0) return ;
		
		sb.deleteCharAt(sb.length() - 1);
		try {
			bw.write(sb.toString());
			bw.newLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		sb.delete(0, sb.length());
		cnt++;
		
	}

	 

}
