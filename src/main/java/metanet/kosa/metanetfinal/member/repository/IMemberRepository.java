package metanet.kosa.metanetfinal.member.repository;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.member.model.Member;

@Repository
@Mapper
public interface IMemberRepository {
	/*
	 * 회원가입할 때, 아이디 고유 확인
	 */
	boolean isUniqueId(String id); 
	
	/*
	 * 회원 등록
	 */
	void register(Member member); 
	
	/*
	 * 아이디 찾기 : 전화번호로 아이디 조회
	 */
	String getIdByPhoneNumber(String phoNum); 
	
	/*
	 * 비밀번호 찾기 : 아이디로 비밀번호 초기화 및 임시 비밀번호 발송
	 */
	String resetPwById(String id); 
	
	/*
	 * 회원탈퇴 : 아이디로 회원 탈퇴 진행
	 */
	void signOut(String id);
	
	/*
	 * 회원정보수정 : 이름, 이메일, 전화번호 수정 가능
	 */
	
}
