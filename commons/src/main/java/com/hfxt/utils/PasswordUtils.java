package com.hfxt.utils;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;


//为了实现密码加密存储: ☆☆☆☆☆该工具的加密中使用的salt盐值,应该来自于外部传参. 因为盐值会伴随密码一起保存数据库.
//					当前工具中的盐值完全在内部生成, 应该改变.
public class PasswordUtils {

    //定义密码的MD5的3次迭代加密:
    public static String enctypePassword(String password1 , String salt){

        //加密方式,加密次数: 参考shiro的加密规则:
        String algorithmName = "md5";
        int hashIterations = 3;


        //SimpleHash(加密方式 , 源密码 , 盐值 , 加密次数)
        SimpleHash hash = new SimpleHash(algorithmName, password1,
                salt, hashIterations);

        //开始加密:
        String encodedPassword = hash.toHex();

//        //加密后密码:
//        System.out.println("加密密码:"+encodedPassword);
//
//        //盐值:
//        System.out.println("混淆加密的盐值: "+salt);

        return encodedPassword;
    }

    public static void main(String[] args) {

        //例如: 123123 查看经过MD5和3次加密之后的密码:
        //加密密码 : ebed7d8bfe0abd33db8ca4fe5248644e
        //盐值 : aaae371bdd197487787cb17ce7669e8b

        //采用随机数作为盐值: 起到加密混淆作用.
        String saltValue =  new SecureRandomNumberGenerator().nextBytes().toHex();

        String password1 = "123456";

        String enctypePassword = enctypePassword( password1 , saltValue );

        //加密密码结果:
        System.out.println(enctypePassword);
    }

}
