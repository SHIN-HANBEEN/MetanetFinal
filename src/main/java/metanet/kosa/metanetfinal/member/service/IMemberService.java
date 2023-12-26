package metanet.kosa.metanetfinal.member.service;

import metanet.kosa.metanetfinal.member.model.Member;

public interface IMemberService {
	void register(Member member); 
	String getIdByPhoneNumber(String phoNum);
	String resetPwById(String id);
	
	
	
}
