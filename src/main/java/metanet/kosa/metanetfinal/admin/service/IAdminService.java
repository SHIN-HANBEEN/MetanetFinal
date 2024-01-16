package metanet.kosa.metanetfinal.admin.service;

import java.util.List;
import java.util.Map;

import metanet.kosa.metanetfinal.admin.model.TodayRoutes;

public interface IAdminService {
	
	String todayPrice();
	String MonthPrice();
	int todayRes();
	int monthRes();
	List<TodayRoutes> TodayRoutes();
	List<Map<String, String >> weekPrice();

}
