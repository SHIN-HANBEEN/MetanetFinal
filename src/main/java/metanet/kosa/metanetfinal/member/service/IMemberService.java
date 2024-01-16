package metanet.kosa.metanetfinal.member.service;

import java.util.List;

import metanet.kosa.metanetfinal.member.model.Members;

public interface IMemberService {
	Members login(String id, String password);
	void signin(Members member); 
	String getIdByPhoneNumber(String phoNum);
	String getPhoneNumberById(String id);
	String resetPwById(String id);
	void signOut(String id, String password);
	void updateMember(String userId, String email, String phoNum);
	Members getMemberInfo(String id);
	List<String> getRoles(String id);
	String getPassword(String id);
	void updatePassword(String id, String newPw);
	String getPwById(String id);
	
}
