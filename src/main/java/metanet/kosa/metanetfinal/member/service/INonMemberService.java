package metanet.kosa.metanetfinal.member.service;

import org.springframework.stereotype.Service;

@Service
public interface INonMemberService {
	
	/* 비회원 */
	// 비회원 정보 등록
	void registerNonMember(int nmbId, String phoNum);


}
