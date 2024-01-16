package metanet.kosa.metanetfinal.reservation;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Base64;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.reservation.service.KeyEncrypt;
@SpringBootTest
class KeyEncrytTest {
	@Autowired
	KeyEncrypt keyEncrypt;
	
	@Test
	void test() throws Exception {
		String encrypt = keyEncrypt.encrypt("01022224445");
//		String str = "eijlCPbq5pwUB5+JV75XKQ==";
//		String encodeToString = Base64.getEncoder().encodeToString(str.getBytes());
//		byte[] decodedBytes = Base64.getDecoder().decode(encodeToString);
//        String decodedStr = new String(decodedBytes);
//		System.out.println(encodeToString);
		Assertions.assertThat(keyEncrypt.decrypt(encrypt)).isEqualTo("01022224445");
	}

}
