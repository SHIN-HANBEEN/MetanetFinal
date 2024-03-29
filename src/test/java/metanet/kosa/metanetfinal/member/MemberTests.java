package metanet.kosa.metanetfinal.member;

import java.sql.Date;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.repository.IMemberRepository;
import metanet.kosa.metanetfinal.member.service.MemberService;

@SpringBootTest
public class MemberTests {
	@Autowired
	MemberService memberService;
	
	@Autowired
	IMemberRepository memberRepository;
	
	@Test
	void regMemberTest() {
//		Members member = Members.builder()
//			.birthDate(new Date(20230101))
//			.memberId(10)
//			.id("test")
//			.password("Qwerty12345678!")
//			.email("test@test.com")
//			.sex("MALE")
//			.name("혿길동")
//			.phoneNum("01011111111")
//			.role("USER")
//			.mileage(1100).build();
//		memberService.signin(member);
	}
	
	@Test
	void getIdByPhoneNumber() {
		String id = memberService.getIdByPhoneNumber("01011111111");
		Assertions.assertThat(id).isEqualTo("test");
	}
	
	@Test
	void resetPwById() {
		String tmpPW = memberService.resetPwById("test");
		System.out.println(tmpPW);
	}
	
	@Test
	void getMemberTest() {
		Members member = memberRepository.getMemberById("test");
		System.out.println(member.getEmail());
	}

}
