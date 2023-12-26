package metanet.kosa.metanetfinal.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.member.model.Member;
import metanet.kosa.metanetfinal.member.repository.IMemberRepository;

@Service
public class MemberService implements IMemberService{
	@Autowired
	IMemberRepository memberRepository;
	
	/*
	 * 등록하려는 아이디가 유일하면 회원 가입을 진행한다.
	 */
	@Override
	public void register(Member member) {
		if (memberRepository.isUniqueId(member.getId())) {
			memberRepository.register(member);
		}
	}

	@Override
	public String getIdByPhoneNumber(String phoNum) {
		return memberRepository.getIdByPhoneNumber(phoNum);
	}

	@Override
	public String resetPwById(String id) {
		return memberRepository.resetPwById(id);
	}

}
