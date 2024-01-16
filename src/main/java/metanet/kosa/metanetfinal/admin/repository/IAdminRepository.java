package metanet.kosa.metanetfinal.admin.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.admin.model.TodayRoutes;

@Repository
@Mapper
public interface IAdminRepository {
	
	/*
	 * 오늘자 매출
	 */
	String getTodayPrice(); 
	/*
	 * 이번달 매출
	 */
	String getMonthPrice(); 
	/*
	 * 오늘자 예매 건수
	 */
	int getTodayRes();
	/*
	 * 이번달 예매 건수
	 */
	int getMonthRes();
	
	/*
	 * 오늘자 노선
	 */
	List<TodayRoutes> todayRoutes();
	
	List<Map<String, String >> weekPrice();
}
