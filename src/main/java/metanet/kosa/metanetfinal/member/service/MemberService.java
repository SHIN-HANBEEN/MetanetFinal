package metanet.kosa.metanetfinal.member.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.repository.IMemberRepository;

@Service
public class MemberService implements IMemberService{
	@Autowired
	IMemberRepository memberRepository;
	
	/*
	 * 등록하려는 아이디가 유일하면 회원 가입을 진행한다.
	 */
	@Override
	public void register(Members member) {
		if (memberRepository.isUniqueId(member.getId())) {
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

	/*
	 * 비밀번호 찾기 :
	 * 전화번호 인증 끝난 사용자들만 사용가능하므로 
	 * 아이디로 조회 후, Pw 초기화 한 다음, 
	 * 임시 비밀번호 반환
	 */
	@Override
	public String resetPwById(String id) {
		return memberRepository.resetPwById(id);
	}

	/*
	 * 회원탈퇴 : 
	 * 비밀번호를 통한 인증 후 회원을 탈퇴한다.
	 */
	@Override
	public void signOut(String id) {
		memberRepository.signOut(id);
	}

	/*
	 * 회원정보수정 이름, 이메일, 전화번호를 수정할 수 있습니다. 
	 * 이름, 전화번호는 사용자가 전화번호 인증을 할 때만 할 수 있으므로
	 * null 값이 넘어올 수 있다. 그에 따른 동적 쿼리 처리가 필요함
	 */
	@Override
	public void updateMember(String nme, String ema, String phoNum) {
		memberRepository.updateMember(nme, ema, phoNum);
	}

	

}







































