package metanet.kosa.metanetfinal;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.coolsms.CoolSmsService;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;

@SpringBootTest
class MetanetFinalApplicationTests {
	
	@Autowired
	CoolSmsService coolSmsService;

	@Test
	void contextLoads() {
	}
	
	@Test
	void smsServiceTest() {
		SingleMessageSentResponse sendOne = coolSmsService.sendOne("01056267924", "테스트입니다");
		System.out.println(sendOne.toString());
	}

}
