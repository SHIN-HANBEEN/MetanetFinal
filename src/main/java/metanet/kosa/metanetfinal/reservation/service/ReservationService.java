package metanet.kosa.metanetfinal.reservation.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.repository.IReservationRepository;
import metanet.kosa.metanetfinal.reservation.repository.IReservationScheduleRepository;

public class ReservationService implements IReservationService{
	
	@Autowired
	IReservationRepository reservationRepository;
	
	@Autowired
	IReservationScheduleRepository reservationScheduleRepository;
	
	@Override
	public List<Reservation> getReservation(int nmbId) {
		/*
		 *비회원 예매 리스트 조회
		 */
		return reservationRepository.getReservation(nmbId);
	}


	@Override
	public HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory) {
		/*
		 * 비회원 티켓 발급
		 * 티켓 종류(모바일 티켓, 지류 티켓)확인 후, 
		 * QR코드, 티켓 일련번호 발송, 탑승정보(출발지, 도착지, 운송회사이름, 매수, 좌석 정보, 출발시간 ) 해시맵에 넣어서 반환
		 */
		return null;
	}

	@Override
	public void changReservation(int resId, int schId) {
		/*
		 * 비회원 예매 변경
		 * 좌석 변경, 예매 시간, 일자 변경 후 
		 * 차액이 있다면 결제 진행 후
		 * 이전 예매 취소 및 환불
		 */
		reservationRepository.changReservation(resId, schId);
	}

	@Override
	public void changeSeat(int resId, int schId, int seatNum) {
		/*
		 * 비회원 좌석 변경
		 * 사용자가 변경하기 원하는 좌석을 예약하고
		 * 기존에 사용자가 예약했던 좌석은 취소
		 */
		
		// 좌석 예약 코드 추가
		reservationRepository.cancelReservation(resId, schId);
	}

	@Override
	public void cancelReservation(int resId, int schId) {
		/*
		 * 비회원 예매 취소
		 * 예매 취소한 후
		 * 환불처리
		 */
		reservationRepository.cancelReservation(resId, schId);
		// 환불 처리 코드 추가
	}


	@Override
	public HashMap<String, String> getBusInfo(int schId) {
		/*
		 * 배차 시간표에서 사용자가 선택한 버스 정보 조회
		 * 반환되어야 할 정보 : 요금, 소요 시간, 예매된 좌석 배열
		 */
		return reservationRepository.getBusInfo(schId);
	}


	@Override
	public void selectSeat(int adult, int child, int special, int[] seats) {
		/*
		 * 매수 및 좌석 선택
		 * 파라미터 : 일반/초등/보훈 인원수, 선택 좌석
		 */
		reservationRepository.selectSeat(adult, child, special, seats);
		
	}

}
