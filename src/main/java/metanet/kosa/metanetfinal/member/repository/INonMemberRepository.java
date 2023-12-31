package metanet.kosa.metanetfinal.member.repository;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface INonMemberRepository {
	
	/* 비회원 */
	// 비회원 정보 등록
	void registerNonMember(int nmbId, String phoNum);
	// 전화번호 가져오기
	String getPhoNum(int nmbId);
	

}
