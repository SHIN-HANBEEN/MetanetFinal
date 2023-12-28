package metanet.kosa.metanetfinal.reservation.service;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.reservation.repository.IReservationScheduleRepository;

public class ReservationScheduleService implements IReservationScheduleService {

	@Autowired
	IReservationScheduleRepository reservationScheduleRepository;
	
	public int[] getReservedSeat(int schId) {
		/*
		 * 버스의 예매된 좌석 목록 가져오기
		 */
		return reservationScheduleRepository.getReservedSeat(schId);
	}
}
