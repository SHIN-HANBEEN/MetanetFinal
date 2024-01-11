package metanet.kosa.metanetfinal.member.repository;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.member.model.Members;

@Repository
@Mapper
public interface IMemberRepository {
	/*
	 * 회원가입할 때, 아이디 고유 확인
	 * 전화번호 반환
	 */
	String isUniqueId(String id); 
	
	/*
	 * 회원 등록
	 */
	void register(Members member); 
	
	/*
	 * 권한 조회
	 */
	List<String> getRoles(String memberid);
	/*
	 * 아이디 찾기 : 전화번호로 아이디 조회
	 */
	String getIdByPhoneNumber(String phoneNum); 
	
	/*
	 * 전화 번호 가져오기
	 */
	String getPhoneNumberById(String id);
	/*
	 * 비밀번호 찾기 : 아이디로 비밀번호 초기화 및 임시 비밀번호 발송
	 * 1. 생성된 임시비밀번호로 바꾸기
	 */
	void resetPwById(@Param("id") String id, @Param("tmpPassword") String tmpPassword); 
	
	/*
	 * 회원탈퇴 : 아이디로 회원 탈퇴 진행
	 */
	void signOut(@Param("id") String id, @Param("password") String password);
	
	/*
	 * 회원정보수정 : 이름, 이메일, 전화번호 수정 가능
	 * 이름, 전화번호는 사용자가 전화번호 인증을 할 때만 할 수 있으므로
	 * null 값이 넘어올 수 있다. 그에 따른 동적 쿼리 처리가 필요함
	 */
	void updateMemberByID(@Param("id") String id, @Param("email") String email, @Param("phoneNum") String phoneNum);
	
	/*
	 * 아이디로 회원조회
	 */
	Members getMemberById(String id);
	/*
	 * PK로 회원조회
	 */
	Members getMemberByMemberId(int memberId);
	/*
	 * 로그인 By ID and Password
	 */
	Members getMemberByIdAndPassword(@Param("id")String id, @Param("password") String password);
	void updateMemberMileage(@Param("memberId")int memberId, @Param("mileage") int mileage,
			@Param("mileageRate") int mileageRate, @Param("totalPrice") int totalPrice);

}
