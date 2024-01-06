package metanet.kosa.metanetfinal.route.controller;

import java.net.URI;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

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
	 * 출발지, 도착지에서 '동' 한글자만 입력하면 '동'으로 출발하는 리스트 뿌리기 위한 REST
	 */
	@GetMapping("/search-terminal")
	public List<String> searchTerminal(@RequestParam String terminalName) {
		List<Terminals> terminals = routeService.searchTerminalsListStartWithTerminalName(terminalName);
		List<String> result = new ArrayList<>();
		for (int i = 0; i < terminals.size(); i++) {
			result.add(i, terminals.get(i).getTerminalName());
		}
		return result;
	}

	@GetMapping("/search-schedule")
	public String searchSchedule(@RequestParam String dpTerminalName,
			@RequestParam String arrTerminalName, @RequestParam String dpDate) {

		String serviceKey = "EDX0wACMZAUSqHv3FZoxJ//0f5uYSjlN24rlk9/zLatbt21dRKjj81MlsAUFqkDAC68x1aKh6bkdwJUvIuHUyQ==";
		String dpTerminalId = routeService.getTerminalId(dpTerminalName);
		String arrTerminalId = routeService.getTerminalId(arrTerminalName);
		String numOfRows = "10";
		String pageNo = "1";
		String type = "json";
		String parsedDpDate = dpDate.replace("-", "");

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		HttpEntity<?> entity = new HttpEntity<>(headers);
		
		// Build the URL using UriComponentsBuilder
		String apiUrl = "http://apis.data.go.kr/1613000/SuburbsBusInfoService/getStrtpntAlocFndSuberbsBusInfo";
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(apiUrl)
				.queryParam("serviceKey", serviceKey)
				.queryParam("depTerminalId", dpTerminalId).queryParam("arrTerminalId", arrTerminalId)
				.queryParam("depPlandTime", parsedDpDate).queryParam("numOfRows", numOfRows)
				.queryParam("pageNo", pageNo).queryParam("_type", type).build();

		// Create a RestTemplate instance
		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<String> responseEntity = restTemplate.exchange(uri.toUri(), HttpMethod.GET, entity, String.class);

		// Check for success or error
		if (responseEntity.getStatusCode().is2xxSuccessful()) {
			System.out.println("API Response: " + responseEntity.toString());
		} else {
			System.out.println("Error Response: " + responseEntity.toString());
		}

		// Return the result
		return responseEntity.getBody();
	}

}
