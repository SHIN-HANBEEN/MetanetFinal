package metanet.kosa.metanetfinal.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.repository.IReservationRepository;

public class ReservationService implements IReservationService{
	@Autowired
	IReservationRepository reservationRepository;
	
	/*
	 * 마이페이지 예매내역 및 취소내역 조회 :
	 * 과거 6개월까지 예매내역과 취소내역을 조회한다. 
	 */
	@Override
	public List<Reservation> getReservationHistoryForLastSixMonth(int id) {
		return reservationRepository.getReservationHistoryForLastSixMonth(id);
	}
}
