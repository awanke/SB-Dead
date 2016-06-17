import org.apache.shiro.crypto.hash.Sha256Hash;

public class ShiroDbRealmTest {
    public static void main(String[] args) {
        // 加密算法名称(MD2, MD5, SHA-1, SHA-256, SHA-384, SHA-512)

        // 加密迭代次数
        int iterations = 1024;

        // true=Hex存储(占数据库64位字符)，false=Base64存储(占数据库44位字符)
        boolean isStoredHex = false;

        String result = "";
        if (isStoredHex) {
            result = new Sha256Hash("123", null, iterations).toHex();
//            result = new Md5Hash("123", null, iterations).toHex();
//            result = new Sha1Hash("123", null, iterations).toHex();
//            result = new Sha256Hash("123", null, iterations).toHex();
//            result = new Sha384Hash("123", null, iterations).toHex();
//            result = new Sha512Hash("123", null, iterations).toHex();
//            result = new Sha256Hash("123", null, iterations).toHex();
        } else {
            result = new Sha256Hash("123", null, iterations).toBase64();
//            result = new Md5Hash("123", null, iterations).toBase64();
//            result = new Sha1Hash("123", null, iterations).toBase64();
//            result = new Sha256Hash("123", null, iterations).toBase64();
//            result = new Sha384Hash("123", null, iterations).toBase64();
//            result = new Sha512Hash("123", null, iterations).toBase64();
//            result = new Sha256Hash("123", null, iterations).toBase64();
        }
        System.out.println("输出结果：" + result);
    }
}
