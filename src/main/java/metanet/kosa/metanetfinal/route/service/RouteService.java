package metanet.kosa.metanetfinal.route.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.route.model.Terminals;
import metanet.kosa.metanetfinal.route.repository.IRouteRepository;

@Service
public class RouteService implements IRouteService{
	@Autowired
	IRouteRepository routeRepository;
	
	@Override
	public List<Terminals> searchTerminalsListStartWithTerminalName(String terminalName) {
		return routeRepository.searchTerminalsListStartWithTerminalName(terminalName);
	}

}
