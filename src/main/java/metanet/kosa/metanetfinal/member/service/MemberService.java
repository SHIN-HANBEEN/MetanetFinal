package metanet.kosa.metanetfinal.member.service;


import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import metanet.kosa.metanetfinal.coolsms.CoolSmsService;
import metanet.kosa.metanetfinal.email.service.EmailService;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.repository.IMemberRepository;

@Service
@Transactional
public class MemberService implements IMemberService{
	@Autowired
	IMemberRepository memberRepository;
	
	@Autowired
	EmailService emailService;
	
	/*
	 * 로그인
	 * 컨트롤러에서 로그인실패했을때 if(member == null) 처리 필요
	 */
	@Override
	public Members login(String id, String password) {
		return memberRepository.getMemberByIdAndPassword(id, password);
		
	}
	
	/*
	 * 회원 정보 리턴
	 */
	public Members getMemberInfo(String id) {
		return memberRepository.getMemberById(id);
	}

	
	
	/*
	 * 등록하려는 아이디가 유일하면 회원 가입을 진행한다.
	 */
	@Override
	public void signin(Members member) {
		System.out.println(memberRepository.isUniqueId(member.getId()));
		if (memberRepository.isUniqueId(member.getId()) == null) {
			//비밀번호 암호화 필요
			memberRepository.register(member);
		}
	}

	/*
	 * 아이디 찾기 : 
	 * 전화번호 인증 끝난 사용자만 사용 하므로,
	 * 전화번호로 아이디 조회 후 표시
	 */
	@Override
	public String getIdByPhoneNumber(String phoNum) {
		return memberRepository.getIdByPhoneNumber(phoNum);
	}

	@Override
	public String getPhoneNumberById(String id) {
		return memberRepository.getPhoneNumberById(id);
	}
	/*
	 * 비밀번호 찾기 :
	 * 전화번호 인증 끝난 사용자들만 사용가능하므로 
	 * 아이디로 조회 후, Pw 초기화 한 다음, 
	 * 임시 비밀번호 반환
	 */
	@Transactional
	@Override
	public String resetPwById(String id) {
		String uuid = UUID.randomUUID().toString();
		String tmpPassword = uuid.substring(0, 10);
		String userEmail = memberRepository.getMemberById(id).getEmail();
		//비밀번호 암호화 필요
		memberRepository.resetPwById(id, tmpPassword);
		String text = "임시비밀번호 [" + tmpPassword + "]";
		emailService.sendEmailtoUser(userEmail, "메타버스에서 임시비밀번호가 발급되었습니다.", text);
		
		
		return tmpPassword;
	}
	/*
	 * 비밀번호 재설정
	 * 임시비밀번호로 로그인하면
	 * 비밀번호를 재설정한다.
	 */
	public void updatePassword(String id, String newPw) {
		memberRepository.resetPwById(id, newPw);
	}
	/*
	 * 회원탈퇴 : 
	 * 비밀번호를 통한 인증 후 회원을 탈퇴한다.
	 */
	@Override
	public void signOut(String id, String password) {
		memberRepository.signOut(id, password);
	}

	/*
	 * 회원정보수정 이메일, 전화번호를 수정할 수 있습니다. 
	 */
	@Override
	public void updateMember(String memberId, String email, String phoneNum) {
		memberRepository.updateMemberByID(memberId, email, phoneNum);
	}

	@Override
	public List<String> getRoles(String id) {
		return memberRepository.getRoles(id);
	}
	
	public Members getMemberByMemberId(int memberId) {
		return memberRepository.getMemberByMemberId(memberId);
	}

	@Override
	public String getPwById(String id) {
		return memberRepository.getPwById(id);
	}

	

}

