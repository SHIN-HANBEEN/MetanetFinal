package metanet.kosa.metanetfinal.member.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.model.ReservationSchedule;

@Service
public interface INonMemberService {
	
	/* 비회원 */
	// 비회원 정보 등록
	boolean registerNonMember(int nmbId, String phoNum);
	// 예매 정보 조회
	Reservation[] getReservation(int nmbId);
	// 티켓 발급
	public HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory);
	// 예매 변경
	boolean changReservation(int resId, int schId);
	// 좌석 변경
	boolean changeSeat(int resId, int schId, int seatNum);
	// 예매 취소
	boolean cancelReservation(int resId, int schId);
	// 결제
	// int pay();

}
