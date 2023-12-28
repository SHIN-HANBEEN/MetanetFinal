package metanet.kosa.metanetfinal.reservation.service;

import org.springframework.stereotype.Service;

@Service
public interface IReservationScheduleService {
	// 버스의 예매된 좌석 목록 가져오기
	int[] getReservedSeat(int schId);
}
