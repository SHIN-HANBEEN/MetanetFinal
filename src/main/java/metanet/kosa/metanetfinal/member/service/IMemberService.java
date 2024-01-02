package metanet.kosa.metanetfinal.member.service;

import metanet.kosa.metanetfinal.member.model.Members;

public interface IMemberService {
	Members login(String id, String password);
	void register(Members member); 
	String getIdByPhoneNumber(String phoNum);
	String resetPwById(String id);
	void signOut(String id, String password);
	void updateMember(String userId, String email, String phoNum);
	
}
