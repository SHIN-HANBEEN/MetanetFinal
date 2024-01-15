package metanet.kosa.metanetfinal.reservation.service;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

@Component
public class KeyDecrypt {

    private final static String alg = "AES/CBC/PKCS5Padding";
    private final static String key = "MyTestCode-32Character-TestAPIKe";
    private final static String iv = key.substring(0, 16);

    public String decrypt(String clientKey) {
        try {
            Cipher cipher = Cipher.getInstance(alg);
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
