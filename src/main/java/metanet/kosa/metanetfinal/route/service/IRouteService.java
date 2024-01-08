package metanet.kosa.metanetfinal.route.service;

import java.util.List;

import metanet.kosa.metanetfinal.route.model.Terminals;

public interface IRouteService {
	List<Terminals> searchTerminalsListStartWithTerminalName(String terminalName);
	String getTerminalIdByTerminalName(String terminalName);
}
