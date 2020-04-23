package com.xiaobo.common.utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * Created by pactera on 2017/6/12.
 */
public class MD5Utils {




    public static String md5Sign(Map<String, String> params, String secret) {

        List<String> paramNames = new ArrayList<String>(params.size());
        paramNames.addAll(params.keySet());
        Collections.sort(paramNames);
        StringBuffer buffer = new StringBuffer();

        for(int i = 0; i < params.size(); ++i) {
            String paramName = (String)paramNames.get(i);
            if(i == params.size() - 1) {
                buffer.append(paramName).append("=").append((String)params.get(paramName));
            } else {
                buffer.append(paramName).append("=").append((String)params.get(paramName)).append("&");
            }
        }

        buffer.append(secret);

        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            byte[] bytes = messageDigest.digest(buffer.toString().getBytes("UTF-8"));
            StringBuilder sign = new StringBuilder();

            for(int i = 0; i < bytes.length; ++i) {
                String hex = Integer.toHexString(bytes[i] & 0xFF);
                if(hex.length() == 1) {
                    sign.append("0");
                }

                sign.append(hex);
            }

            return sign.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public static String decryptBase64(String data, String secret)  {
        try {
            if(secret.length() > 8) {
                secret = secret.substring(0, 8);
            }

            byte[] raw = Base64.decodeBase64(data);
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            DESKeySpec desKeySpec = new DESKeySpec(secret.getBytes("UTF-8"));
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
            IvParameterSpec iv = new IvParameterSpec(secret.getBytes("UTF-8"));
            cipher.init(2, secretKey, iv);
            byte[] retByte = cipher.doFinal(raw);
            return new String(retByte, "UTF-8");
        } catch (Exception e) {

            throw new RuntimeException("加密数据解密失败");
        }
    }


    public static String encryptBase64(String data, String secret)  {
        try {
            if(secret.length() > 8) {
                secret = secret.substring(0, 8);
            }
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            DESKeySpec desKeySpec = new DESKeySpec(secret.getBytes("UTF-8"));
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
            IvParameterSpec iv = new IvParameterSpec(secret.getBytes("UTF-8"));
            cipher.init(1, secretKey, iv);
            byte[] bytes = cipher.doFinal(data.getBytes());
            return Base64.encodeBase64String(bytes);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * 接口自定义加密
     * @param str
     * @return
     */
    public static String getMD5(String str){ 
        try {
            // 生成一个MD5加密计算摘要
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 计算md5函数
            md.update(str.getBytes());
            // digest()最后确定返回md5 hash值，返回值���8为字符串。因为md5 hash值是16位的hex值，实际上就是8位的字符
            // BigInteger函数则将8位的字符串转换成16位hex值，用字符串来表示；得到字符串形式的hash值
            return new BigInteger(1, md.digest()).toString(16);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * md5 加密密码
     * @param pass 密码
     * @param salt 盐值
     * @return
     */
    public static String md5Pass(String pass , String salt) {
    	
    	return  DigestUtils.md5Hex(pass);
    	
    	//return new Sha256Hash(pass, salt).toHex();
    	
    }
 
    public static void main(String[] args){

    	String nPass = "123456" ;
    	
    	String ahsNPass = DigestUtils.md5Hex(nPass);
    	
    	System.out.println(ahsNPass);
    	
    	String ahs2Pass = MD5Utils.getMD5(nPass);
    	
    	System.out.println(ahs2Pass);
    	
      
    }
}
