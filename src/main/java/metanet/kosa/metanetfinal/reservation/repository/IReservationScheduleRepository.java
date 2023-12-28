package metanet.kosa.metanetfinal.reservation.repository;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface IReservationScheduleRepository {
	// 버스의 예매된 좌석 목록 가져오기
	int[] getReservedSeat(int schId);
}
