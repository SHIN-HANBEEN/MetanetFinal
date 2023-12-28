package metanet.kosa.metanetfinal.reservation.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.reservation.model.Reservation;

@Service
public interface IReservationService {
	// 비회원 예매 리스트 조회
	List<Reservation> getReservation(int nmbId);
	// 비회원 예매 정보 조회
	
	// 비회원 티켓 발급
	HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory);
	// 비회원 예매 변경
	void changReservation(int resId, int schId);
	// 비회원 좌석 변경
	void changeSeat(int resId, int schId, int seatNum);
	// 비회원 예매 취소
	void cancelReservation(int resId, int schId);
	
	// 배차 시간표에서 사용자가 선택한 버스 정보 조회		  
	HashMap<String, String> getBusInfo(int schId);
	// 매수 및 좌석 선택
	void selectSeat(int adult, int child, int special, int[] seats);
}
