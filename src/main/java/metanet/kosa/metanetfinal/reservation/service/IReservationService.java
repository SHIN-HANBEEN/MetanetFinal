package metanet.kosa.metanetfinal.reservation.service;

import java.util.List;

import metanet.kosa.metanetfinal.reservation.model.Reservation;

public interface IReservationService {
	List<Reservation> getReservationHistoryForLastSixMonth(int id);
}
