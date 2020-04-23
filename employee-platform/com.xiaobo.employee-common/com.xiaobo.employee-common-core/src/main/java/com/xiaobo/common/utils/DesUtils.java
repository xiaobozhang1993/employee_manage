package com.xiaobo.common.utils;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * DES加密 解密算法
 * 采用PKCS7Padding 填充模式
 * 
 * @author zhangxiaobo
 * @date 2017-3-17 上午10:12:11
 */
public class DesUtils {

    private final static String DES = "DES";
    private final static String ENCODE = "UTF-8";
    private final static String defaultKey = "ourlat@123.com";

    public static void main(String[] args) throws Exception {
        String data = "a123456A1245";
        // System.err.println(encrypt(data, key));
        // System.err.println(decrypt(encrypt(data, key), key));
        System.out.println(encrypt(data));
        System.out.println(decrypt(encrypt(data)));
         
        System.out.println(decrypt("qQ3R8z5P+cOfQBtPBKWhQQ=="));
        
    }

    /**
     * 使用 默认key 加密
     * 
     * @return String
     * @author lifq
     * @date 2015-3-17 下午02:46:43
     */
    public static String encrypt(String data) throws Exception {
        byte[] bt = encrypt(data.getBytes(ENCODE), defaultKey.getBytes(ENCODE));
        //Base64.getEncoder().encodeToString(bt);
        
        String strs =   Base64.getEncoder().encodeToString(bt); //Base64.encodeBase64String(bt); //new BASE64Encoder().encode(bt);
        return strs;
    }

    /**
     * 使用 默认key 解密
     * 
     * @return String
     * @author lifq
     * @date 2015-3-17 下午02:49:52
     */
    public static String decrypt(String data)   {
        if (data == null)
            return null;
       // BASE64Decoder decoder = new BASE64Decoder();
        byte[] buf = Base64.getDecoder().decode(data) ;//Base64.decodeBase64(data);// decoder.decodeBuffer(data);
        byte[] bt;
		try {
			bt = decrypt(buf, defaultKey.getBytes(ENCODE));
			 return new String(bt, ENCODE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
       
		
    }

    /**
     * Description 根据键值进行加密
     * 
     * @param data
     * @param key
     *            加密键byte数组
     * @return
     * @throws Exception
     */
    public static String encrypt(String data, String key) throws Exception {
        byte[] bt = encrypt(data.getBytes(ENCODE), defaultKey.getBytes(ENCODE));
        String strs = Base64.getEncoder().encodeToString(bt) ;//  Base64.encodeBase64String(bt);// new BASE64Encoder().encode(bt);
        return strs;
    }

    /**
     * Description 根据键值进行解密
     * 
     * @param data
     * @param key
     *            加密键byte数组
     * @return
     * @throws IOException
     * @throws Exception
     */
    public static String decrypt(String data, String key) throws IOException,
            Exception {
        if (data == null)
            return null;
       // BASE64Decoder decoder = new BASE64Decoder();
        byte[] buf = Base64.getDecoder().decode(data);// Base64.decodeBase64(data);// decoder.decodeBuffer(data);
        byte[] bt = decrypt(buf, key.getBytes(ENCODE));
        return new String(bt, ENCODE);
    }

    /**
     * Description 根据键值进行加密
     * 
     * @param data
     * @param key
     *            加密键byte数组
     * @return
     * @throws Exception
     */
    private static byte[] encrypt(byte[] data, byte[] key) throws Exception {
        // 生成一个可信任的随机数源
        SecureRandom sr = new SecureRandom();

        // 从原始密钥数据创建DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);

        // 创建一个密钥工厂，然后用它把DESKeySpec转换成SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);

        // Cipher对象实际完成加密��������
        Cipher cipher = Cipher.getInstance(DES);

        // 用密钥初始化Cipher对象
        cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);

        return cipher.doFinal(data);
    }

    /**
     * Description 根据键值进行解密
     * 
     * @param data
     * @param key
     *            加密键byte数组
     * @return
     * @throws Exception
     */
    private static byte[] decrypt(byte[] data, byte[] key) throws Exception {
        // 生成一个可信任的随机数源
        SecureRandom sr = new SecureRandom();

        // 从原始密钥数据创建DESKeySpec对象
        DESKeySpec dks = new DESKeySpec(key);

        // 创建一个密钥工厂，然后用它把DESKeySpec转换成SecretKey对象
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
        SecretKey securekey = keyFactory.generateSecret(dks);

        // Cipher对象实际完成解密操作
        Cipher cipher = Cipher.getInstance(DES);

        // 用密钥初始化Cipher对象
        cipher.init(Cipher.DECRYPT_MODE, securekey, sr);

        return cipher.doFinal(data);
    }
}
