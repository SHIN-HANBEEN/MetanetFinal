package metanet.kosa.metanetfinal.route.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import metanet.kosa.metanetfinal.route.model.Terminals;
import metanet.kosa.metanetfinal.route.service.IRouteService;

/*
 * 출발지, 도착지를 입력할 때, 
 * 비동기로 검색창에 리스트를 뿌려주기 위한 
 * REST CONTROLLER 입니다.
 * 
 * 예를 들어, 동 만 입력하면, 동으로 시작하는 터미널들이 리스트로 나오는 것이죠.
 */
@RestController
public class RouteRestController {
	@Autowired
	IRouteService routeService;
	
	/*
	 * 출발지, 도착지에서 '동' 한글자만 입력하면 
	 * '동'으로 출발하는 리스트 뿌리기 위한 REST
	 */
	@GetMapping("/search-terminal")
	public List<Terminals> searchTerminal(@RequestParam String terminalName) {
		List<Terminals> result = routeService.searchTerminalsListStartWithTerminalName(terminalName);
		return result;
	}
}
