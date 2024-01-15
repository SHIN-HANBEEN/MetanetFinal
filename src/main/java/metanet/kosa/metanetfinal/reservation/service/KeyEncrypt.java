package metanet.kosa.metanetfinal.reservation.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class KeyEncrypt {

    private final static String shaAlg = "SHA-256";
    private final static String aesAlg = "AES/CBC/PKCS5Padding";
    private final static String key = "MyTestCode-32Character-TestAPIKe";
    private final static String iv = key.substring(0, 16);

    public String encrypt(String text) {
        try {
            //String shaKey = getShaKey(text);
            return getAesKey(text);
        } catch (Exception e) {
            throw new RuntimeException("암호화 처리중에 에러가 발생했습니다. ");
        }
    }
    //SHA 알고리즘은 해시 알고리즘을 사용하기 때문에 복호화 불가능
	// SHA-256 키 만들기
    private String getShaKey(String text) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance(shaAlg);
        md.update(text.getBytes());
        return bytesToHex(md.digest());
    }

	// AES 키 만들기
    private String getAesKey(String text) throws Exception {
        Cipher cipher = Cipher.getInstance(aesAlg);
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivParameterSpec);

        byte[] encodedBytes = cipher.doFinal(text.getBytes());
        byte[] encrypted = Base64.getEncoder().encode(encodedBytes);
        return new String(encrypted).trim();
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder builder = new StringBuilder();
        for (byte b : bytes) {
            builder.append(String.format("%02x", b));
        }
        return builder.toString();
    }
    
    public String decrypt(String clientKey) {
        try {
            Cipher cipher = Cipher.getInstance(aesAlg);
            SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
            cipher.init(Cipher.DECRYPT_MODE, keySpec, ivParameterSpec);

            byte[] decoedBytes = Base64.getDecoder().decode(clientKey.getBytes());
            byte[] decrypted = cipher.doFinal(decoedBytes);
            return new String(decrypted).trim();
        } catch (Exception e) {
            throw new RuntimeException("복호화 처리중에 에러가 발생했습니다.");
        }
    }

}
