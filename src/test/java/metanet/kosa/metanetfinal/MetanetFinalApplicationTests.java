package metanet.kosa.metanetfinal;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

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
		SimpleDateFormat sdf = new SimpleDateFormat(
			    "yyyy-MM-dd HH:mm");
			java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
		
	}
	
	

}
