import org.apache.shiro.crypto.hash.*;
import org.junit.Test;

public class ShiroDbRealmTest {

    @Test
    public void test() {
        // 加密算法名称(MD2, MD5, SHA-1, SHA-256, SHA-384, SHA-512)

        // 加密迭代次数
        int iterations = 1024;

        // Hex存储(占数据库64位字符)，Base64存储(占数据库44位字符)
        String result = new Md2Hash("123", null, iterations).toHex();
        result = new Md5Hash("123", null, iterations).toHex();
        result = new Sha1Hash("123", null, iterations).toHex();
        result = new Sha256Hash("123", null, iterations).toHex();
        result = new Sha384Hash("123", null, iterations).toHex();
        result = new Sha512Hash("123", null, iterations).toHex();
        result = new Sha256Hash("123", null, iterations).toHex();

        result = new Md2Hash("123", null, iterations).toBase64();
        result = new Md5Hash("123", null, iterations).toBase64();
        result = new Sha1Hash("123", null, iterations).toBase64();
        result = new Sha256Hash("123", null, iterations).toBase64();
        result = new Sha384Hash("123", null, iterations).toBase64();
        result = new Sha512Hash("123", null, iterations).toBase64();
        result = new Sha256Hash("123", null, iterations).toBase64();

        System.out.println("输出结果：" + result);
    }
}
