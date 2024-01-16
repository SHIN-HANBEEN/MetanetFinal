package metanet.kosa.metanetfinal.reservation;

import static org.junit.jupiter.api.Assertions.*;

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
		Assertions.assertThat(keyEncrypt.decrypt(encrypt)).isEqualTo("01022224445");
	}

}
