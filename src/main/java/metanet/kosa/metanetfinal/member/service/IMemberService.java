package metanet.kosa.metanetfinal.member.service;


import metanet.kosa.metanetfinal.member.model.Members;

public interface IMemberService {
	void register(Members member); 
	String getIdByPhoneNumber(String phoNum);
	String resetPwById(String id);
	void signOut(String id);
	void updateMember(String nme, String ema, String phoNum);
	
}
