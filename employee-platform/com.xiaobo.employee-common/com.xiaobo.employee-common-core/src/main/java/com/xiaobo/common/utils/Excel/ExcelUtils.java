package com.xiaobo.common.utils.Excel;

import cn.hutool.core.text.csv.CsvWriter;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.monitorjbl.xlsx.StreamingReader;
import com.xiaobo.common.exception.RRException;
import com.xiaobo.common.utils.DateUtils;
import com.xiaobo.common.utils.StringUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * excel操作公共类-提供excel按照模板输出
 * @author zhangxiaobo
 *
 */
public class ExcelUtils {

    static org.slf4j.Logger logger = LoggerFactory.getLogger(ExcelUtils.class);


	/**
	 * excel文件解析为csv文件
	 * @param excelFile
	 * @param tmpFile
	 */
	@SuppressWarnings("resource")
	public static int parseExcelToCsvFile(File excelFile , File tmpFile ,String file_id , String split , Integer[] ingoreFields) {
 
		Workbook wb = null;
		String modelName = excelFile.getName().toLowerCase();
		 
		try {
			
			InputStream input = new FileInputStream(excelFile);
			
		
			if(modelName.endsWith(".xlsx")  ) 
			{
				wb = StreamingReader.builder()
						
			            .rowCacheSize(500)  //缓存到内存中的行数，默认是10
			            .bufferSize(20480)  //读取资源时，缓存到内存的字节大小，默认是1024
			          //  .sstCacheSize(500) 
			            .open(input);  //打开资源，必须，可以是InputStream或者是File，注意：只能打开XLSX格式的文件
			}
//				wb = new XSSFWorkbook(input);
			else if(modelName.endsWith(".xls"))
				wb = new HSSFWorkbook(input);
			else
				throw new RRException("model file format is not valid , this : " + modelName + " , eg:.xlsx");
			
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

			throw new RRException("model excel file load error : " + modelName);
		}
		
		  
       
 
		
		Sheet sheet =  wb.getSheetAt(0);
		
		int cnt = 0;
		 
		BufferedWriter writer = null;
		try {
			writer = new BufferedWriter(new FileWriter(tmpFile));
		 
			StringBuffer sb = new StringBuffer();
			 
			// 开始解析
			Iterator<Row> rows = sheet.iterator();
			int cellCnt = 0;
			while(rows.hasNext()) {
				Row row = rows.next();
				
				//忽略表头
				
				int rowcnt = row.getPhysicalNumberOfCells();
				if(rowcnt == 0) break ;
				if(cnt == 0) {
					cellCnt = rowcnt;
					cnt++;
					continue ;
				}

				//取出每个单元格数据
				//Iterator<Cell> cells = row.iterator();
				  
				sb.append(file_id + split);
				int v_cnt = 0; // 实际由数据的字段 如果一行中一个由数据的字段都没有 说明结束了
				for(int i = 0 ; i < cellCnt ; i++) {
					
					// 判断该字段是否需要忽略
					if(ingoreFields != null && ArrayUtils.contains(ingoreFields, i)) {
						continue ;
					}
					
					Cell cell = row.getCell(i);
				 
					Object value = getCellValue(cell);

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
				
				if(v_cnt == 0) break ;
				
				sb.deleteCharAt(sb.length() - 1);
				writer.write(sb.toString());
				writer.newLine();
				sb.delete(0, sb.length());
				cnt++;
			}
			writer.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RRException("create tmp file write error ,path: " + tmpFile.getPath() , e);
			
		} finally {
			if(writer != null) {
				try {
					writer.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	
		return cnt;
	}
	
	  
	@Autowired
	public static void main(String[] args) { 
		
		
		String file = "D:/work/T/郑州昊航/document/1207/拨测数据/视频/手机APP/视频类APP-详单_6398207.xlsx" ;
		
		File excelFile = new File(file); 
		File tmpFile = new File("d:/tmp.csv") ;
		String file_id = "1111";
		String split = ";"; 
		
		parseExcelToCsvFile(excelFile, tmpFile, file_id, split , null);
		
	}
	
	/**
	 * 解析excel文件
	 * @param file
	 * @return
	 */ 
	public static List<String[]> parseExcel(File file , int limit) {
		 
		String modelName = file.getName().toLowerCase();
		
		FileInputStream input = null;
		try {
			input = new FileInputStream(file);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(input == null) {
			throw new RRException("文件读取异常: " + file.getName());
		}
		
		return parseExcel(input, 0, limit , modelName.endsWith(".xlsx")) ;
		
	}

	/**
	 * 解析excel文件
	 * @param file
	 * @return
	 */ 
	public static List<String[]> parseExcel(byte[] data , int limit ,boolean xlsx) {
		 
		
		return parseExcel(new ByteArrayInputStream(data), limit,xlsx) ;
		
	}

	/**
	 * 解析excel文件
	 * @param file
	 * @return
	 */ 
	public static List<String[]> parseExcel(InputStream input , int limit ,boolean xlsx) {
		 
		
		return parseExcel(input, 0, limit,xlsx) ;
		
	}
	
	/**
	 * 解析excel文件
	 * @param file
	 * @return
	 */
	@SuppressWarnings("resource")
	public static List<String[]> parseExcel(InputStream input , int sheetIndex , int limit ,boolean xlsx) {
		
		List<String[]> list = new LinkedList<>();
		
		Workbook wb = null;
		//String modelName = file.getName().toLowerCase();
		try {
			
		//	InputStream input = new FileInputStream(file);
			
			 
			/*if(modelName.endsWith(".xlsx"))
				wb = new XSSFWorkbook(input);
			else if(modelName.endsWith(".xls"))
				wb = new HSSFWorkbook(input);*/
			if(xlsx) 
			{
				wb = StreamingReader.builder()
						
			            .rowCacheSize(10)  //缓存到内存中的行数，默认是10
			           .bufferSize(2048)  //读取资源时，缓存到内存的字节大小，默认是1024
			          //  .sstCacheSize(500) 
			            .open(input);  //打开资源，必须，可以是InputStream或者是File，注意：只能打开XLSX格式的文件
			}
			else
				wb = new HSSFWorkbook(input);
			//else
			//	throw new RuntimeException("model file format is not valid , this : " + modelName + " , eg:.xlsx or xls");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();

			throw new RuntimeException("model excel file load error ");
		}

		Sheet sheet =  wb.getSheetAt(sheetIndex);
		int lastRowNum = sheet.getLastRowNum();
		// 开始解析
		 
	 	Iterator<Row> rows = sheet.iterator();
	 	int index = 0;
		while(rows.hasNext()) {
			Row row = rows.next();
			int rowNum = row.getLastCellNum();

			//取出每个单元格数据
			List<Object> cellList = new ArrayList<>();
			for (int i = 0 ; i<rowNum; i++){
				Cell cell = row.getCell(i, Row.RETURN_BLANK_AS_NULL);
				Object value = null;
				if (cell==null){
					value="";
				}else{
					value=getCellValue(cell);
				}


				String valueStr = value != null ? value.toString() : "";

				if(value != null && value instanceof Date) {
					valueStr = DateUtils.format((Date)value	, DateUtils.DATE_TIME_PATTERN);
				}

				cellList.add(valueStr);
			}


			//下面这种写法会跳过为null的单元格
			//Iterator<Cell> cells = row.iterator();
//			while(cells.hasNext()) {
//				Cell cell = cells.next();
//				Object value = getCellValue(cell);
//
////				if(value == null && limit  > 0) {
////					break ;
////				}
//
//				String valueStr = value != null ? value.toString() : "";
//
//				if(value != null && value instanceof Date) {
//					valueStr = DateUtils.format((Date)value	, DateUtils.DATE_TIME_PATTERN);
//				}
//
//				cellList.add(valueStr);
//			}
			
			list.add(cellList.toArray(new String[0]));
			index++ ;
			if(limit > 0 && limit >= index) {
				break ;
			}
			
		}
	 	
	 	
		
		return list ;
		
	}
  
	
	public static Object getCellValue(Cell srcCell) {
		if(srcCell == null) return null ;
		CellType srcCellType = srcCell.getCellTypeEnum();
		 
		Object value = null;  
		
		if (srcCellType == CellType.NUMERIC) {
			if (DateUtil.isCellDateFormatted(srcCell)) {
				value = (srcCell.getDateCellValue());
			} else {
				Double dvalue = (srcCell.getNumericCellValue());
				
				//如果.后面全是0 则转为整形
				if(dvalue != null && dvalue % 1 == 0) {
					value = dvalue.longValue();
				} else {
					value = dvalue ;
				}
				
			}
		} else if (srcCellType == CellType.STRING ) {
			value = (srcCell.getRichStringCellValue());
		} else if (srcCellType == CellType.BLANK ) {
			// nothing21
		} else if (srcCellType == CellType.BOOLEAN  ) {
			value = (srcCell.getBooleanCellValue());
		} else if (srcCellType == CellType.ERROR ) {
			value = (srcCell.getErrorCellValue());

		} else if (srcCellType == CellType.FORMULA  ) {
			value = (srcCell.getCellFormula());
		} else { // nothing29
		}
		 
		return value ;
	}
    
    /**
     * Sheet复制
     * @param fromSheet
     * @param toSheet
     * @param copyValueFlag
     */
    public static void copySheet(Workbook wb,Sheet fromSheet, Sheet toSheet,
                                 boolean copyValueFlag) {
        //合并区域处理

        mergerRegion(fromSheet, toSheet);
        int index = 0;
        for (Iterator<Row> rowIt = fromSheet.rowIterator(); rowIt.hasNext();) {
            Row tmpRow =  rowIt.next();
            Row newRow = toSheet.createRow(tmpRow.getRowNum());

            CellStyle style = tmpRow.getRowStyle();
            if(style != null)
                newRow.setRowStyle(tmpRow.getRowStyle());

            newRow.setHeight(tmpRow.getHeight());

            //针对第一行设置行宽
            if(index == 0) {
                int first = tmpRow.getFirstCellNum();
                int last = tmpRow.getLastCellNum();
                for(int i = first ; i < last ; i++) {
                    int w = fromSheet.getColumnWidth(i);
                    toSheet.setColumnWidth(i, w + 1);
                }
                toSheet.setDefaultColumnWidth(fromSheet.getDefaultColumnWidth());
            }

            //行复制
            copyRow(wb,tmpRow,newRow,copyValueFlag);

            index++ ;
        }
    }
    /**
     * 行复制功能
     * @param fromRow
     * @param toRow
     */
    static void copyRow(Workbook wb,Row fromRow,Row toRow,boolean copyValueFlag){
        for (Iterator<Cell> cellIt = fromRow.cellIterator(); cellIt.hasNext();) {
            Cell tmpCell = cellIt.next();
            Cell newCell = toRow.createCell(tmpCell.getColumnIndex());
            copyCell(wb,tmpCell, newCell, copyValueFlag);
        }
    }
    /**
     * 复制原有sheet的合并单元格到新创建的sheet
     *
     * @param sheetCreat 新创建sheet
     * @param sheet      原有的sheet
     */
    static void mergerRegion(Sheet fromSheet, Sheet toSheet) {
        int sheetMergerCount = fromSheet.getNumMergedRegions();
        for (int i = 0; i < sheetMergerCount; i++) {

            CellRangeAddress cra = fromSheet.getMergedRegion(i);

            toSheet.addMergedRegion(cra);
        }
    }
    /**
     * 复制单元格
     *
     * @param srcCell
     * @param distCell
     * @param copyValueFlag
     *            true则连同cell的内容一起复制
     */
    public static void copyCell(Workbook wb,Cell srcCell, Cell distCell,
                                boolean copyValueFlag) {



        CellStyle newstyle=wb.createCellStyle();
        //copyCellStyle(srcCell.getCellStyle(), newstyle);
        //distCell.setEncoding(srcCell.);
        newstyle.cloneStyleFrom(srcCell.getCellStyle());
        //样式
        distCell.setCellStyle(newstyle);
        //评论
        if (srcCell.getCellComment() != null) {
            distCell.setCellComment(srcCell.getCellComment());
        }
        // 不同数据类型处理
        CellType srcCellType = srcCell.getCellTypeEnum();
        distCell.setCellType(srcCellType);


        if (copyValueFlag) {
            if (srcCellType == CellType.NUMERIC) {
                if (DateUtil.isCellDateFormatted(srcCell)) {
                    distCell.setCellValue(srcCell.getDateCellValue());
                } else {
                    distCell.setCellValue(srcCell.getNumericCellValue());
                }
            } else if (srcCellType == CellType.STRING ) {
                distCell.setCellValue(srcCell.getRichStringCellValue());
            } else if (srcCellType == CellType.BLANK ) {
                // nothing21
            } else if (srcCellType == CellType.BOOLEAN  ) {
                distCell.setCellValue(srcCell.getBooleanCellValue());
            } else if (srcCellType == CellType.ERROR ) {
                distCell.setCellErrorValue(srcCell.getErrorCellValue());

            } else if (srcCellType == CellType.FORMULA  ) {
                distCell.setCellFormula(srcCell.getCellFormula());
            } else { // nothing29
            }
        }
    }

    /**
     * 解析excel文件
     * @param input
     */
/*	public void parseExcel(InputStream input) {

		Workbook wb = null;
		try {
			wb = new XSSFWorkbook(input);

			Sheet sheet = wb.getSheetAt(0);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	*/
    public static  String writeData(InputStream model , HttpServletResponse response , String filename, List<ValueFormat> formats, SheetData... sheetDatas ) {
        String fn = filename.endsWith(".xls") || filename.endsWith(".xlsx") ? filename : filename +".xlsx";
        // 读取字符编码
        String utf = "UTF-8";

        long ct1 = System.currentTimeMillis();
        logger.info("start export , filename : " + filename + " , time : " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date()));

        // 设置响应
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding(utf);
        response.setHeader("Pragma", "public");
        response.setHeader("Cache-Control", "max-age=30");
        try {
            response.setHeader("Content-Disposition", "attachment; filename="
                    + URLEncoder.encode(fn, utf));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();

            logger.error("response set header error , filename:" + filename , e);
            return "导出异常" ;
        }

        try {

            BufferedOutputStream bout = new BufferedOutputStream(response.getOutputStream() , 5*1024);

            ExcelUtils.writeData(model, bout, formats ,sheetDatas );
        } catch (IOException e) {
            // TODO Auto-generated catch block
            // e.printStackTrace();
            logger.error("export error , filename:" + filename , e);
            return "导出异常" ;
        }
        long ct2 = System.currentTimeMillis();

        logger.info("end export , filename : " + filename + " , time : " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date()));


        logger.info("export excel by model , file : " + filename + " , use time : " + (ct2 - ct1));

        return null ;
    }

    public static String writeData(InputStream model , HttpServletResponse response , String filename, SheetData... sheetDatas ) {
        return writeData(model, response, filename, null, sheetDatas);
    }

    /**
     * 写入excel数据
     * @param
     * @param model 采用的模板  模板第一���sheet页必须是模板sheet
     * @param sheetDatas 模板数据
     */

    //@SuppressWarnings("resource")
    public static  void writeData(InputStream model , OutputStream out,List<ValueFormat> formats,SheetData... sheetDatas ) {

        Workbook wb = null;
        //String modelName = model.getName().toLowerCase();
        try {

            //	InputStream input = new FileInputStream(model);
            wb = new XSSFWorkbook(model);
            
           /* if(model.endsWith(".xlsx"))  
                wb = new XSSFWorkbook(input);  
            else if(model.endsWith(".xls"))  
                wb = new HSSFWorkbook(input);  
            else  */

//			else
//				throw new RuntimeException("model file format is not valid , this : " + modelName + " , eg:.xlsx or xls");
        } catch (IOException e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();

            throw new RuntimeException("model excel file load error " );
        }

        Sheet source =  wb.getSheetAt(0);

        //就一个的话 直接用模板
        int size = sheetDatas.length ;
        for(int i = 0 ; i < size  ; i++) {

            if(i == 0) {
                wb.setSheetName(0, sheetDatas[0].getName());

            } else {
                Sheet toSheet = wb.createSheet(sheetDatas[i].getName());
                //复制格式
                copySheet(wb, source, toSheet, true);
            }


        }

        for(int i = 0 ; i < size  ; i++) {
            //写数据
            writeData(sheetDatas[i], wb.getSheetAt(i) , formats);
        }

        try {
            wb.write(out);
            out.flush();
            wb.close();
            out.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


    }

    /**
     * 向sheet页中写入数据
     * @param
     * @param values 数据Map
     * @param sheet sheet
     */
    public static  void writeData(SheetData sheetData , Sheet sheet , List<ValueFormat> formats) {

        //从sheet中找到匹配符 #{}表示单个 , ${}表示集合,从该单元格开始向下追加

        for(Iterator<Row> rowIt = sheet.rowIterator(); rowIt.hasNext();) {
            Row row = rowIt.next();
            //取cell
            for(int j = row.getFirstCellNum() ; j < row.getLastCellNum() ; j++) {

                Cell cell = row.getCell(j);

                //判断cell的内容��否包含 $ 或者#
                if(cell != null && cell.getCellTypeEnum() == CellType.STRING && cell.getStringCellValue() != null
                        && (cell.getStringCellValue().contains("$") || cell.getStringCellValue().contains("#") )) {
                    //剥离# $
                    String[] winds = StringUtils.getWildcard(cell.getStringCellValue().trim());

                    for(String wind : winds) {

                        writeData(sheetData, wind , cell , sheet , formats);
                    }


                }

            }

        }
    }



    /**
     * 填充数据
     * @param
     * @param values
     * @param keyWind #{name}只替换当前 or ${names} 从当前行开始向下替换
     */
    static  void writeData(SheetData sheetData , String keyWind , Cell cell , Sheet sheet , List<ValueFormat> formats) {
        String key = keyWind.substring(2 , keyWind.length() - 1);

//        //判断是否包含转换方法
//        ValueFormat formatMethod = null;
//        for(ValueFormat f : formats) {
//            if(f.getFieldName().equals(key)) {
//                formatMethod = f;
//                break ;
//            }
//        }

        if(keyWind.startsWith("#")) {

            //简单替换

            Object value = sheetData.get(key);

//            if(formatMethod != null) {
//                value = formatMethod.format(value);
//            }

            //为空则替换为空字符串
            if(value == null)
                value = "" ;

            String cellValue = cell.getStringCellValue();
            cellValue = cellValue.replace(keyWind, value.toString());

            cell.setCellValue(cellValue);

        } else  if(keyWind.startsWith("$")) {

            //从list中每个实体开始解,行数从当前开始
            int rowindex = cell.getRowIndex();
            int columnindex = cell.getColumnIndex();

            List<? extends Object> listdata = sheetData.getDatas();

            //不为空的时候开始填充
            if(listdata != null && !listdata.isEmpty()){
                for(Object o : listdata) {
                    Object cellValue =  getValue(o, key);

//                    if(formatMethod != null) {
//                        cellValue = formatMethod.format(cellValue);
//                    }

                    Row row = sheet.getRow(rowindex);
                    if(row == null) {
                        row = sheet.createRow(rowindex);
                    }

                    //取出cell
                    Cell c = row.getCell(columnindex);
                    if(c == null)
                        c = row.createCell(columnindex);
                    if(cell.getCellStyle() != null){
                        c.setCellStyle(cell.getCellStyle());

                    }

                    if(cell.getCellTypeEnum() != null) {
                        c.setCellType(cell.getCellTypeEnum());

                    }

                    if(cellValue != null) {
                        if(cellValue instanceof Number || StringUtils.isNumber(cellValue) )
                            c.setCellValue( Double.valueOf(cellValue.toString()));
                        else if(cellValue instanceof Boolean)
                            c.setCellValue((Boolean)cellValue);
                        else if(cellValue instanceof Date)
                            c.setCellValue((Date)cellValue);
                        else
                            c.setCellValue(cellValue.toString());
                    } else {

                        //数据为空 如果当前单元格已经有数据则重置为空
                        if(c.getStringCellValue() != null) {
                            c.setCellValue("");
                        }

                    }



                    rowindex++ ;
                }
            } else {
                //list数据为空则将$全部替换空字符串
                String cellValue = "" ;

                cell.setCellValue(cellValue);

            }



        }

    }

    public static String writeExcel(HttpServletResponse response , String filename, HlSheet... sheets) {
    	
    	if(!filename.endsWith(".xls") && !filename.endsWith(".xlsx")) {
    		filename = filename + ".xlsx";
    	}
    	
    	 response.setContentType("application/vnd.ms-excel");
         response.setCharacterEncoding("UTF-8");
         response.setHeader("Pragma", "public");
         response.setHeader("Cache-Control", "max-age=30");
         OutputStream out = null;
         try {
             response.setHeader("Content-Disposition", "attachment; filename="
                     + URLEncoder.encode(filename, "UTF-8"));
         	out = response.getOutputStream();
    		
         } catch (UnsupportedEncodingException e) {
             // TODO Auto-generated catch block
             //e.printStackTrace();

             logger.error("response set header error , filename:" + filename , e);
             return "导出异常" ;
         } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			   logger.error("response set header error , filename:" + filename , e);
	             return "导出异常" ;
		}
         
         
         
        
         
         
         writeExcel(out, sheets);
         
         
         return null ;
        
         
    }
    
    /**
     * 写入csv数据到response
     * @param response
     * @param filename
     * @param sheet
     */
    public static String writeCsv(HttpServletResponse response , String filename , HlSheet sheet) {
    	
    	if(!filename.endsWith(".csv")) {
    		filename = filename + ".csv";
    	}
    	

   	 	response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("GBK");
        response.setHeader("Pragma", "public");
        response.setHeader("Cache-Control", "max-age=30");
        PrintWriter out = null;
        try {
            response.setHeader("Content-Disposition", "attachment; filename="
                    + URLEncoder.encode(filename, "UTF-8"));
        	out = response.getWriter();
   		
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            //e.printStackTrace();

            logger.error("response set header error , filename:" + filename , e);
            return "导出异常" ;
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			   logger.error("response set header error , filename:" + filename , e);
	             return "导出异常" ;
		}
        
    	String[] columns = sheet.getColumns(); 
    	  
    	
	   	 CsvWriter write = new CsvWriter(out);
		 write.write(columns);
    	  
		 write.write(sheet.getLines());
    	 
		 write.flush();
		 write.close();
    	   
    	 out.close();
    	 
    	 return null;
        
    	
    }
    
    /**
     * 写入数据到excel中
     * @param sheets 每个sheet页的内容数据
     * @param out 输出文件路径
     */
    public static void writeExcel( OutputStream out , HlSheet... sheets) {

      //  XSSFWorkbook workbook = new XSSFWorkbook();


        /**
         * 
         *  if(model.endsWith(".xlsx"))  
                wb = new XSSFWorkbook(input);  
            else if(model.endsWith(".xls"))  
                wb = new HSSFWorkbook(input);  
            else  
         * 
         */

        ExcelWriter writer = new ExcelWriter(out, ExcelTypeEnum.XLSX);

        int no = 0;
        for(HlSheet hlsheet : sheets) {

           // Sheet sheet = workbook.createSheet(hlsheet.getName());
            
            com.alibaba.excel.metadata.Sheet st = new com.alibaba.excel.metadata.Sheet(no++);
            st.setSheetName(hlsheet.getName());
         
            List<List<Object>> list = new LinkedList<>();
            
            list.add(Arrays.asList(hlsheet.getColumns()));
            
            for(Object[] ss : hlsheet.getLines()) {
            	   list.add(Arrays.asList(ss));
            }
         
            
            writer.write1(list, st);
            
            
            
            //创建第一栏
           /* XSSFRow headRow = sheet.createRow(0);
            String[] titleArray = hlsheet.getColumns();
            for(int m = 0 ; m <  titleArray.length  ; m++)
            {
                XSSFCell cell = headRow.createCell(m);

                sheet.setColumnWidth(m, 4000);
                XSSFCellStyle style = workbook.createCellStyle();
                XSSFFont font = workbook.createFont();
                //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
                font.setBold(true);
//				        short color = HSSFColor.RED.index;
//				        font.setColor(color);
                style.setFont(font);
                //填写数据
                cell.setCellStyle(style);
                cell.setCellValue(titleArray[m]);

            }
            int index = 0;
            //写入数据
            for(Object[] ss : hlsheet.getLines())
            {
                //logger.info("写入一行");
                XSSFRow row = sheet.createRow(index+1);

                for(int i = 0 ; i < ss.length ; i++) {
                    XSSFCell cell = row.createCell(i);

                    cell.setCellValue(ss[i] != null ? ss[i].toString() : "");
                }


                index++;
            }*/

        }

        writer.finish();
        

        //写到磁盘上
        try {

           // workbook.write(out);
            out.flush();
            out.close();
           // workbook.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }



    /**
     * 从实体中解析出字段数据
     * @param data 可能为pojo或者map 从field中解析
     * @param field 字段名称
     * @return
     */

    @SuppressWarnings("rawtypes")
    public static Object getValue(Object data , String field) {

        if(data instanceof Map) {

            Map map = (Map) data;
            return map.get(field);
        }
        try {

            String method = "get" + field.substring(0 , 1).toUpperCase() + field.substring(1);

            Method m = data.getClass().getMethod(method, null);

            if(m != null) {
                return m.invoke(data, null);
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            // e.printStackTrace();
            // logger.error("data invoke error , data:" + data + " , key:" + field);
            return null;
        }


        return null ;

    }
/*

    public static List<Object> parseFile(InputStream inputStream, Class<?> clazz) throws Exception {
        List<Object> registerOtherList = new ArrayList<Object>();
        HSSFWorkbook wb = readFrom(inputStream);
        for (int k = 0; k < wb.getNumberOfSheets(); k++) {
            HSSFSheet sheet = readSheetFrom(wb, k);
            int rows = sheet.getPhysicalNumberOfRows();
            for (int r = 1; r < rows; r++) {
                HSSFRow row = readRowFrom(sheet, r);
                Object o = convertRow2Object(row,clazz);
                if (o == null) {
                    continue;
                }
                registerOtherList.add(o);
            }
        }
        return registerOtherList;
    }
    private static HSSFWorkbook readFrom(InputStream inputStream) throws FileNotFoundException, IOException {
        return new HSSFWorkbook(new BufferedInputStream(inputStream));
    }
    private static HSSFSheet readSheetFrom(HSSFWorkbook wb, int sheetNo) {

        return wb.getSheetAt(sheetNo);
    }
    private static HSSFRow readRowFrom(HSSFSheet sheet, int rowNo) {

        return sheet.getRow(rowNo);
    }
    private static Object convertRow2Object(HSSFRow row,Class<?> clazz) throws Exception {
        HSSFWorkbook demoWorkBook = new HSSFWorkbook();
        if (row == null) {
            return null;
        }
        Map<Object, String> map = new HashMap<Object, String>();

        Constructor constructor=clazz.getConstructor(null);
        Object o=constructor.newInstance(null);
        String error = "";
        Field[] fields = clazz.getDeclaredFields();
        int i=0;
        for (Field field: fields) {


            HSSFCell cell =  row.getCell(i);
            HSSFCellStyle cellStyle2 = demoWorkBook.createCellStyle();
            HSSFDataFormat format = demoWorkBook.createDataFormat();
            cellStyle2.setDataFormat(format.getFormat("@"));
            if(cell!=null){
                cell.getCellStyle().cloneStyleFrom(cellStyle2);
                cell.setCellType(CellType.STRING);
                String value=String.valueOf(row.getCell(i)).trim().replace("null", "");
                PropertyDescriptor descriptor = new PropertyDescriptor(field.getName(), clazz);
                Method method = descriptor.getWriteMethod();
                method.invoke(o,value);
                i++;
            }
        }
        return o;
    }
*/
}

