package metanet.kosa.metanetfinal.route.repository;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface IRouteRepository {
	//출발지, 도착지, 출발시간에 해당하는 데이터가 노선 테이블에 있는지 확인하기
	String getRouteId(String departureId, String arrivalId, Date departureTime);
	
	//노선생성
	void makeNewRoute(String routeId ,String departureId, String arrivalId, Date departureTime, 
			Date arrivalTime, int price);
	
	
}
