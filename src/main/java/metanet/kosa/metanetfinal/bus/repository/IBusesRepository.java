package metanet.kosa.metanetfinal.bus.repository;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.bus.model.Buses;
import metanet.kosa.metanetfinal.bus.model.Seats;

@Mapper
@Repository
public interface IBusesRepository {
//	/*
//	 * 버스의 좌석 수 반환하기
//	 */
//	int getSeatCountBySchedule(int sceId);
	
	/*
	 * 버스 생성하기
	 */
	void makeNewBus(String routeId, String gradeName);
	
	/*
	 * 좌석 생성하기 (한번에 28개 좌석을 자동 생성해야 한다 28번 호출하는 것으로 대체한다.)
	 */
	void makeNewSeat(int busId, int seatId);
	
	/*
	 * 버스 아이디 가져오기
	 */
	int getBusId(String routeId);
	
	/*
	 * 잔여 좌석 수 세기
	 */
	int getRemainingSeatCount(int busId);
	
	/*
	 * 해당 노선의 이미 예매된 좌석 리스트 가져오기
	 */
	List<Integer> getOccupiedBusSeats(@Param("departureId") String departureId, 
									@Param("arrivalId") String arrivalId, 
									@Param("departureTime") String departureTime);
	/*
	 * 해당 노선의 요금 가져오기
	 */
	List<Integer> getDiscountedCostOfBusSeats(@Param("departureId") String departureId, 
			@Param("arrivalId") String arrivalId, 
			@Param("departureTime") String departureTime);
	/*
	 * 노선아이디로 버스가져오기
	 */
	Buses getBusByRouteId(String routeId);
	
	/*
	 * 좌석 예약 (is_res = TRUE and FALSE) 로 변경
	 */
	void setBusSeatTrue(@Param("busId") int busId, @Param("seatId") int seatId );
	void setBusSeatFalse(@Param("busId") int busId, @Param("seatId") int seatId );
	
	int verifyCountFalseSeats(@Param("busId") int busId, @Param("seatIdList") List<Integer> seatIdList);
	
}
