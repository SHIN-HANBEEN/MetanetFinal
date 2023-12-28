package metanet.kosa.metanetfinal.reservation.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.company.repository.IBusRepository;
import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
import metanet.kosa.metanetfinal.reservation.repository.IReservationRepository;
import metanet.kosa.metanetfinal.reservation.repository.IReservationScheduleRepository;
import metanet.kosa.metanetfinal.schedule.repository.IScheduleRepository;
import metanet.kosa.metanetfinal.reservation.model.Reservation;

public class ReservationService implements IReservationService{
	@Autowired
	IReservationRepository reservationRepository;
	
	@Autowired
	IScheduleRepository scheduleRepository;
	
	@Autowired
	IPaymentService paymentService;
	
	@Autowired
	IBusRepository busRepository;
	
	@Autowired
	IReservationScheduleRepository reservationScheduleRepository;
	
	/*
	 * 마이페이지 예매내역 및 취소내역 조회 :
	 * 과거 6개월까지 예매내역과 취소내역을 조회한다. 
	 */
	@Override
	public List<DetailedReservation> getReservationHistoryForLastSixMonth(int id) {
		return reservationRepository.getReservationHistoryForLastSixMonth(id);
	}

	/*
	 * 예매_회원 예매 정보 조회 : 
	 * 아직 출발 시간이 지나지 않은 예매 내역을 보여줍니다. 
	 */
	@Override
	public List<DetailedReservation> getReservationHistoryNotUsed(int id) {
		return reservationRepository.getReservationHistoryNotUsed(id);
	}
	
	/*
	 * 예매 변경(같은 노선, 다른 날짜, 다른 시간, 다른 좌석)
	 * 배차아이디, 예매-배차 아이디, 좌석 번호 리스트를 받아서 업데이트를 해야 한다.
	 * 예매 테이블에 있는 총액 컬럼은 DB에 설정해둔 제약조건에 따라 자동으로 업데이트 된다.
	 */
	@Override
	public void updateReservation(int schId, List<Integer> satNumList, int resId) {
		reservationRepository.updateReservation(schId, satNumList, resId);
	}
	
	/*
	 * 기존 결제를 취소하고 다시 결제를 진행해야한다.
	 * 결제가 완료되면 예매변경을 진행한다.
	 */
	@Override
	public void updateReservationWhenCostChange(int schId, List<Integer> satNumList, int resId, int price, int payNum) {
		paymentService.cancle(payNum);
		paymentService.pay(price);
		reservationRepository.updateReservation(schId, satNumList, resId);
	}
	
	/*
	 * 좌석 변경, 예매 전에 잔여 좌석을 표시하기 위함
	 * 버스의 좌석수와 사용한 좌석 id 리스트를 비교해서 
	 * 잔여 좌석을 확인해야 한다.
	 */
	@Override
	public List<Integer> getRemainingSeatId(int schId) {
		int seatCount = busRepository.getSeatCountBySchedule(schId);
		List<Integer> seatIdList = new ArrayList<>();

	    for (int i = 1; i <= seatCount; i++) {
	        seatIdList.add(i);
	    }
	    
		List<Integer> reservedSeatIdList = reservationRepository.getReservedSeatIdListBySchedule(schId);

		seatIdList.removeAll(reservedSeatIdList); //버스의 좌석 수로 뽑은 좌석 ID List 에서 예매된 것을 제거한 List 를 반환하면 된다.
		
		return seatIdList;
	}
	
	/*
	 * 좌석 변경 :
	 * 배차는 그대로이기 때문에 예매-배차 테이블의 좌석번호만 고쳐주면 된다.
	 */
	@Override
	public void updateSeat(List<Integer> satNumList, int resId) {
		reservationRepository.updateReservation(resId, satNumList, resId);
	}
	
	/*
	 * 예매 취소 :
	 * 예매가 취소되면, 예매 데이터를 삭제하는 것이 아닌, 
	 * 예매 취소 여부가 업데이트 된다. 
	 * 따라서, 예매-배차 테이블에 예매한 정보를 
	 * Cascade 로 삭제하는 것이 아닌 개발자가 직접 지워줘야 한다.
	 */
	@Override
	public void cancleReservation(int resId) {
		reservationRepository.updateResTableIsCnc(resId);
		reservationRepository.deleteResSchTable(resId);
	}
	
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
