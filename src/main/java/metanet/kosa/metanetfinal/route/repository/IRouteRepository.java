package metanet.kosa.metanetfinal.route.repository;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface IRouteRepository {
	//출발지, 도착지, 출발시간에 해당하는 데이터가 노선 테이블에 있는지 확인하기
	String getRouteId(
			@Param("departureId") String departureId, 
			@Param("arrivalId") String arrivalId, 
			@Param("departureTime") Date departureTime);
	
	//노선생성
	void makeNewRoute(
			@Param("routeId") String routeId,
			@Param("departureId") String departureId, 
			@Param("arrivalId") String arrivalId, 
			@Param("departureTime") Date departureTime, 
			@Param("arrivalTime") Date arrivalTime, 
			@Param("price") int price);
	
	
}
