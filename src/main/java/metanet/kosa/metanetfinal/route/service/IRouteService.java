package metanet.kosa.metanetfinal.route.service;

import java.util.List;

import metanet.kosa.metanetfinal.route.model.Routes;
import metanet.kosa.metanetfinal.route.model.Terminals;

public interface IRouteService {
	List<Terminals> searchTerminalsListStartWithTerminalName(String terminalName);
	String getTerminalIdByTerminalName(String terminalName);
	int getCityIdByCityName(String cityName);
	List<String> getTerminalNamesByCityId(int cityId);
	//Routes getRoutesByPayId(String payId);
	//String getRouteIdByPayId(String payId);
	//String getTerminalNameByTerminalId(String terminalId);
	//String getBusGrade(String routeId);
}
