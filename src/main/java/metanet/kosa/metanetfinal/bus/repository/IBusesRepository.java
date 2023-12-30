package metanet.kosa.metanetfinal.bus.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

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
}
