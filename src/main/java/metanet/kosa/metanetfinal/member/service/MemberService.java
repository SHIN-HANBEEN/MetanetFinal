package metanet.kosa.metanetfinal.member.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.member.repository.INonMemberRepository;
import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.model.ReservationSchedule;

public class MemberService implements IMemberService {

	@Autowired
	INonMemberRepository memberRepository;
	/*
	@Autowired
	ILineRepository lineRepository;
	
	@Autowired
	IBusRepository busRepository;
	
	@Autowired
	IReservationSchedule reservationScheduleRepository;
	
	@Autowired
	ISchedule scheduleRepository;
	*/
	
	/* 비회원 */
	// 비회원 등록
	@Override
	public boolean registerNonMember(int nmbId, String phoNum) {
		/*
		 * 비회원 정보 등록
		 */
		return false;
	}
	
	// 예매 정보 조회
	@Override
	public Reservation[] getReservation(int nmbId) {
		// TODO Auto-generated method stub
		return memberRepository.getReservation(nmbId);
	}

	// 티켓 발급
	@Override
	public HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory) {
		/*
		 * 티켓 종류(모바일 티켓, 지류 티켓)확인 후, 
		 * QR코드, 티켓 일련번호 발송, 탑승정보(출발지, 도착지, 운송회사이름, 매수, 좌석 정보, 출발시간 ) 해시맵에 넣어서 반환
		 */
		return null;
	}

	// 예매 변경
	@Override
	public boolean changReservation(int resId, int schId) {
		/*
		 * 예매 변경한 후,
		 * 이전 예매 취소 및 환불
		 */
		return false;
	}

	// 예매 완료된 좌석 정보 가져오기
	public int[] getReservedSeat(int resId) {
		return null;
		// return reservationScheduleRepository.getReservedSeat();
	}
	
	
	// 좌석 변경
	@Override
	public boolean changeSeat(int resId, int schId, int seatNum) {
		/*
		 * 현재 예매 되어있는 좌석 정보 가져온 후
		 * 사용자가 변경하기 원하는 좌석을 예약하고
		 * 기존에 사용자가 예약했던 좌석은 취소
		 */
		return false;
	}

	// 예매 취소
	@Override
	public boolean cancelReservation(int resId, int schId) {
		/*
		 * 예매 취소한 후
		 * 환불처리
		 */
		return false;
	}
	
	// 결제하기
	
	// 결제 결과 확인 페이지 정보 가져오기
	public HashMap<String, String> getPayInfo(){
		/*
		 * 예매된 출발지, 도착지, 고속사, 매수, 좌석 정보, 출발시간, 결제금액 정보 저장 후
		 * 티켓 발급
		 */
		return null;
	}

	
	

}
