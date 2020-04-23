import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Test {

	public static void main(String[] args) throws IOException {
		
		String path = "test.png" ;
    	 
    	 File f = new File(path);
    	 
    	 FileInputStream input = new FileInputStream(f);
    	 
    	 ByteArrayOutputStream output= new ByteArrayOutputStream();
    	 
    	 int a = -1 ;
    	 byte[] b1 = new byte[1024];
    	 while((a = input.read(b1)) != -1) {
    		 output.write(b1 , 0 , a);
    	 }
    	 
    	 output.flush();
    	 
    	 input.close();
    	 
    	  
    	 byte[] bs = output.toByteArray();
    	 
    	 byte[] out = addWaterMark(bs, "测试123456", Color.RED);
    	 
    	   
    	 BufferedImage bi = ImageIO.read(new ByteArrayInputStream(out));
    	
    	 ImageIO.write(bi, "png", new File("out.png"));
    	 
		
	}
	
	
	 /**
     * @param input 传入图片字节数组
     * @param waterMarkContent 水印内容
     * @param markContentColor 水印颜色
     * @param font 水印字体
     */
    public static byte[] addWaterMark(byte[] input,String waterMarkContent,Color markContentColor) {

        try {
            // 读取原图片信息

            Image srcImg = ImageIO.read(new ByteArrayInputStream(input));//文件转化为图片
            int srcImgWidth = srcImg.getWidth(null);//获取图片的宽
            int srcImgHeight = srcImg.getHeight(null);//获取图片的高
            // 加水印
            BufferedImage bufImg = new BufferedImage(srcImgWidth, srcImgHeight, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = bufImg.createGraphics();
            g.drawImage(srcImg, 0, 0, srcImgWidth, srcImgHeight, null);
            g.setColor(markContentColor); //根据图片的背景设置水印颜色
            
            //int min = Math.min(srcImgWidth, srcImgHeight);
            
            //Font font = Font.createFont(Font.BOLD, WaterMarkUtils.class.getResourceAsStream("/MSYHBD.TTC"));
             
           // Font font = new Font("微软雅黑",Font.BOLD,min/10);
            //g.setFont(font);              //设置字体
           
            //设置水印的坐标
            int x = srcImgWidth/2   ;
            int y = srcImgHeight/2;
            g.drawString(waterMarkContent, x, y);  //画出水印
            g.dispose();
            // 输出图片

            ByteArrayOutputStream outImgStream = new ByteArrayOutputStream();

            ImageIO.write(bufImg, "jpg", outImgStream);
            System.out.println("添加水印完成");

            outImgStream.flush();

            byte[] out = outImgStream.toByteArray();
            outImgStream.close();


            return out ;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null ;
    }
	
}
