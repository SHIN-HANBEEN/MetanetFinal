package metanet.kosa.metanetfinal.member;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.email.service.EmailService;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;

@SpringBootTest
public class PhoneNumberCertificationTests {

	@Autowired
	PhoneNumCertificationService phoneNumCertificationService;
	
	@Autowired
	EmailService emailService;
	
	@Test
	void certificationSendTest() {
		String authNum = phoneNumCertificationService.sendRandomNumber("01056267924");
		System.out.println(authNum);
		boolean isCertified = phoneNumCertificationService.AuthNumber("01056267924", authNum);
		Assertions.assertThat(isCertified).isTrue();
	}
	
	@Test
	void emailSendTest() {
		emailService.sendEmailtoUser("rladhkstmd10@daum.net", "이메일 발송테스트", "이메일 발송테스트 본문");
	}
}
