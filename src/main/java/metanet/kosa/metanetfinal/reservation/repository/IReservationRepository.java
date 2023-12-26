package metanet.kosa.metanetfinal.reservation.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.model.ReservationSchedule;

@Repository
@Mapper
public interface IReservationRepository {
	/*
	 * 회원_마이페이지_예매내역, 취소내역 조회에 사용
	 */
	Reservation[] getReservationsById(int id); 
	
	/*
	 * 회원_마이페이지_예매내역, 취소내역 조회에 사용
	 */
	ReservationSchedule getReservationSchedulesByResId(int resId);
	
	/*
	 * 회원_마이페이지_예매내역, 취소내역 조회 : 지난 6개월 예매 내역 가져오기
	 */
	List<Reservation> getReservationHistoryForLastSixMonth(int id); 
	
}
