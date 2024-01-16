package metanet.kosa.metanetfinal.reservation.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
import metanet.kosa.metanetfinal.reservation.model.Reservations;


public interface IReservationService {

//	/*
//	 * 예매 변경(같은 노선, 다른 날짜, 다른 시간, 다른 좌석)
//	 * 배차아이디, 예매-배차 아이디, 좌석 번호 리스트를 받아서 업데이트를 해야 한다.
//	 * 단, 이 서비스는 가격의 차이가 없고 예매하려는 좌석의 수의 변동이 없는 경우 사용한다. 
//	 */
//	void updateReservation(int schId, List<Integer> satIdList, int resId);
//	
//	/*
//	 * 예매 변경(같은 노선, 다른 날짜, 다른 시간, 다른 좌석)
//	 * 배차아이디, 예매-배차 아이디, 좌석 번호 리스트를 받아서 업데이트를 해야 한다.
//	 * 단, 이 서비스는 가격의 차이가 있어서 기존 결제를 취소하고 새로운 결제를 해야하며
//	 * 예매하려는 좌석의 수의 변동이 없는 경우 사용한다. 
//	 */
//	void updateReservationWhenCostChange(int schId, List<Integer> satIdList, int resId, int price, int payNum);
//	
//	/*
//	 * 잔여좌석 표시 :
//	 * 좌석 변경, 예매 전에 잔여 좌석을 표시하기 위함
//	 */
//	List<Integer> getRemainingSeatId(int schId);
//	
//	/*
//	 * 좌석 변경 :
//	 * 배차는 그대로이기 때문에 예매-배차 테이블의 좌석번호만 고쳐주면 된다.
//	 */
//	void updateSeat(List<Integer> satIdList, int resId);
//	
	//예매 취소
	void cancleReservation(String payId);
	
//	// 비회원 예매 리스트 조회
////	List<Reservation> getReservation(int nmbId);
//	// 비회원 예매 정보 조회
//	
//	// 비회원 티켓 발급
//	HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory);
//	// 비회원 예매 변경
//	void changReservation(int resId, int schId);
//	// 비회원 좌석 변경
//	void changeSeat(int resId, int schId, int seatNum);
//	// 비회원 예매 취소
//	void cancelReservation(int resId, int schId);
//	
//	// 배차 시간표에서 사용자가 선택한 버스 정보 조회		  
//	HashMap<String, String> getBusInfo(int schId);
//	// 매수 및 좌석 선택
//	void selectSeat(int adult, int child, int special, int[] seats);
	
	/*
	 * 마이페이지 예매내역 및 취소내역 조회 :
	 * 과거 6개월까지 예매내역과 취소내역을 조회한다. 
	 */
	List<DetailedReservation> getReservationHistoryForLastSixMonth(Boolean canceledDate, String phoneNum, boolean isMember);
	
	
	/*
	 * 예매_회원 예매 정보 조회 : 
	 * 아직 출발 시간이 지나지 않은 예매 내역을 보여줍니다. 
	 */
	List<DetailedReservation> getReservationHistoryNotUsed(String phoneNum, boolean isMember);
	
	
	/*
	 * 홈 화면에서 출발지, 도착지, 출발시간 골랐을 때, 잔여좌석 보여주기
	 */
	int getRemainingSeatCount(String departureId, String arrivalId, Date departureTime, 
			Date arrivalTime, String gradeName,int price);
	
	int makeTestDataReservationInfo(String departureId, String arrivalId, Date departureTime, 
			Date arrivalTime, String gradeName,int price);
	
	boolean verifySeatsCount(int busId, List<Integer> selectedSeatsList);
	
	Map<String, Object> getDataForSeatsSelection(String departureId, String arrivalId, String departureTime);

	Map<String, Object> getReservationInfo(String payId);

	
}
