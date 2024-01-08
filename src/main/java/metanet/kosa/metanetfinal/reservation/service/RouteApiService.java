package metanet.kosa.metanetfinal.reservation.service;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import metanet.kosa.metanetfinal.route.service.IRouteService;

@Service
public class RouteApiService {
	
	@Autowired
	IRouteService routeService;
	
	public String callRouteAPI(String dpTerminalName,String arrTerminalName, String dpDate) {
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
