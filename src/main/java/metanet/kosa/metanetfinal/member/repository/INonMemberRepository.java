package metanet.kosa.metanetfinal.member.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.reservation.model.Reservation;

@Mapper
@Repository
public interface INonMemberRepository {
	
	/* 비회원 */
	// 비회원 정보 등록
	int registerNonMember(@Param("nmbId") int nmbId, @Param("phoNum") String phoNum);
	// 전화번호 가져오기
	String getPhoNum(int memId);
	// 미사용 예매 정보 조회
	Reservation[] getReservation(int nmbId);
	// 예매 변경
	boolean changReservation(@Param("resId") int resId, @Param("schId") int schId);
	// 좌석 변경 여부
	boolean changeSeat(@Param("resId") int resId, @Param("schId") int schId, @Param("seatNum") int seatNum);
	// 변경된 좌석 번호 가져오기
	int getChangedSeat(@Param("resId") int resId, @Param("schId") int schId);
	// 예매 취소
	boolean cancelReservation(@Param("resId") int resId, @Param("schId") int schId);

}
