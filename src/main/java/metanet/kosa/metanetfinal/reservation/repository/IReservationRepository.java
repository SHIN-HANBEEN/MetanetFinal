package metanet.kosa.metanetfinal.reservation.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
import metanet.kosa.metanetfinal.reservation.model.Reservations;



@Repository
@Mapper
public interface IReservationRepository {
//	/*
//	 * 예매변경에서 사용함
//	 * 새로운 배차번호를 사용하고, 새로운 좌석번호가 들어옴
//	 */
//	void updateReservation(int schId, List<Integer> satNumList, int resId);
//	
//	/*
//	 * 회원_마이페이지_예매내역, 취소내역 조회에 사용
//	 */
//	Reservation[] getReservationsById(int id); 
//	
//	/*
//	 * 회원_마이페이지_예매내역, 취소내역 조회에 사용
//	 */
//	ReservationSchedule getReservationSchedulesByResId(int resId);
//	
	/*
	 * 회원_마이페이지_예매내역, 취소내역 조회 : 지난 6개월 예매 내역 가져오기
	 * ERD에 없는 객체를 반환하기 때문에, SQL이 굉장히 길어질 것 같아요.
	 */
	List<DetailedReservation> getReservationHistoryForLastSixMonth(@Param("canceledDate") Boolean canceledDate, @Param("phoneNum") String phoneNum, @Param("isMember") boolean isMember); 
	
	/*
	 * 사용되지 않은 예매 내역 가져오기
	 * ERD에 없는 객체를 반환하기 때문에, SQL이 굉장히 길어질 것 같아요.
	 */
	List<DetailedReservation> getReservationHistoryNotUsed(@Param("phoneNum") String phoneNum, @Param("isMember") boolean isMember);
	
	/*
	 * 사용되지 않은 예매 내역의 수 구하기
	 */
	
//	/*
//	 * 사용된 좌석 반환하기
//	 */
//	List<Integer> getReservedSeatIdListBySchedule(int schId);
	
	/*
	 * 예매 취소하기 : 예매 테이블 변경
	 * 예매 테이블의 canceldate의 값을 sysdate로 변경
	 */
	void updateResTableIsCnc(String payId);

	/*
	 * 예약한 버스 번호와 좌석 번호 조회
	 * 예매 테이블에서 payId에 해당하는 버스 id와 좌석 id를 가져오기
	 */
	List<Map<String, Object>> getUsingSeats(String payId);
	
	
	
//	/*
//	 * 예매 취소하기 : 예매-배차 테이블에 isCnc 가 TRUE
//	 * 인 데이터가 남아있는데, 그것을 지워야 한다.
//	 */
//	void deleteResSchTable(int resId);
//	
//	// 비회원 예매 리스트 조회
//	List<Reservation> getReservation(int nmbId);
//	// 비회원 예매 변경
//	void changReservation(int resId, int schId);
//	// 비회원 변경된 좌석 번호 가져오기
//	int getChangedSeat(int resId, int schId);
//	// 비회원 예매 취소
//	void cancelReservation(int resId, int schId);
//	
//	// 배차 시간표에서 사용자가 선택한 버스 정보 조회
//	HashMap<String, String> getBusInfo(int schId);
//	// 매수 및 좌석 선택
//	void selectSeat(int adult, int child, int special, int[] seats);
	
	/*
	 * 예약하기
	 * 예약확정
	 */
	void insertReservationData(@Param("res") Reservations res);
	void testCount();
	
	/*
	 * 홈 화면에서 출발지, 도착지, 출발시간 골랐을 때, 잔여좌석 보여주기
	 */
	int getRemainingSeatCount(String departureId, String arrivalId, String departureTime);
	/*
	 * 노선번호로 출발터미널, 도착터미널 받기
	 */
	Map<String, Object> getReservationInfo(@Param("payId") String payId);
	
	List<Integer> getMySeatListByPayId(@Param("payId") String payId);
	
	void modifySeatByPayIdAndSeatId(@Param("payId") String payId, @Param("preSeatId") int preSeatId, @Param("mdSeatId") int mdSeatId);

	
}
