package metanet.kosa.metanetfinal.route.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import metanet.kosa.metanetfinal.reservation.service.IReservationService;
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

	@Autowired
	IReservationService reservationService;

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
		System.out.println(result);
		return result;
	}

	@GetMapping("/search-schedule")
	public String searchSchedule(@RequestParam String dpTerminalName, @RequestParam String arrTerminalName,
			@RequestParam String dpDate) {
		System.out.println(dpTerminalName);
		System.out.println(arrTerminalName);
		System.out.println(dpDate);

		String serviceKey = "EDX0wACMZAUSqHv3FZoxJ//0f5uYSjlN24rlk9/zLatbt21dRKjj81MlsAUFqkDAC68x1aKh6bkdwJUvIuHUyQ==";
		String dpTerminalId = routeService.getTerminalIdByTerminalName(dpTerminalName.trim());
		String arrTerminalId = routeService.getTerminalIdByTerminalName(arrTerminalName.trim());
		String numOfRows = "10";
		String pageNo = "1";
		String type = "json";
		String parsedDpDate = dpDate.replace("-", "");
		// 날짜 -7 처리 프런트에서 했음.

		System.out.println(dpTerminalId);
		System.out.println(arrTerminalId);
		System.out.println(parsedDpDate);

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		HttpEntity<?> entity = new HttpEntity<>(headers);

		// 비동기 요청보내기. 포스트맨의 출/도착지기반 조회 Copy 에 해당한다.
		String apiUrl = "http://apis.data.go.kr/1613000/SuburbsBusInfoService/getStrtpntAlocFndSuberbsBusInfo";
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(apiUrl).queryParam("serviceKey", serviceKey)
				.queryParam("depTerminalId", dpTerminalId)
				.queryParam("arrTerminalId", arrTerminalId)
				.queryParam("depPlandTime", parsedDpDate)
				.queryParam("numOfRows", numOfRows)
				.queryParam("pageNo", pageNo)
				.queryParam("_type", type)
				.build();

		// Create a RestTemplate instance
		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<String> responseEntity = restTemplate.exchange(uri.toUri(), HttpMethod.GET, entity,
				String.class);

		// Check for success or error
		if (responseEntity.getStatusCode().is2xxSuccessful()) {
			System.out.println("API Response: " + responseEntity.getBody());
		} else {
			System.out.println("Error Response: " + responseEntity.toString());
		}

		// Return the result
		return responseEntity.getBody();
	}

	@GetMapping("/get-remaining-seats")
	public int getRemainingSeats(@RequestParam String depPlaceNm, 
			@RequestParam String arrPlaceNm,
			@RequestParam String depPlandTime, 
			@RequestParam String arrPlandTime, 
			@RequestParam String gradeNm,
			@RequestParam String charge) {
		// 'YYYY-MM-DD HH:mm' 형태로 time 데이터가 들어온다.
		
		String departureId = routeService.getTerminalIdByTerminalName(depPlaceNm.trim());
		String arrivalId = routeService.getTerminalIdByTerminalName(arrPlaceNm.trim());
		String trimedDepPlandTime = depPlandTime.trim();
		String trimedArrPlandTime = arrPlandTime.trim();
		String trimedGradeNm = gradeNm.trim();
		String trimedCharge = charge.trim();
		int price = Integer.valueOf(trimedCharge);
		Date departureTime = null;
		Date arrivalTime = null;
		String dbDepartureTime = ""; //db에서 검색할 때 사용할 형태로 가공하기
		String dbArrivalTime = ""; //db에서 검색할 때 사용할 형태로 가공하기
		// 'YYYY-MM-DD HH:mm' 형태로 들어오는 출발, 도착 시간 데이터
		try {
			// Parse the string into separate components
			int year = Integer.parseInt(trimedDepPlandTime.substring(0, 4));
			int month = Integer.parseInt(trimedDepPlandTime.substring(5, 7));
			int day = Integer.parseInt(trimedDepPlandTime.substring(8, 10));
			int hour = Integer.parseInt(trimedDepPlandTime.substring(11, 13));
			int minute = Integer.parseInt(trimedDepPlandTime.substring(14, 16));

			// departureTime 설정
			departureTime = getSqlDate(year, month, day, hour, minute);
			dbDepartureTime = trimedDepPlandTime.substring(0, 4) + month + day + hour + minute;

			// Parse the string into separate components
			int year2 = Integer.parseInt(trimedArrPlandTime.substring(0, 4));
			int month2 = Integer.parseInt(trimedArrPlandTime.substring(5, 7));
			int day2 = Integer.parseInt(trimedArrPlandTime.substring(8, 10));
			int hour2 = Integer.parseInt(trimedArrPlandTime.substring(11, 13));
			int minute2 = Integer.parseInt(trimedArrPlandTime.substring(14, 16));

			// departureTime 설정
			arrivalTime = getSqlDate(year2, month2, day2, hour2, minute2);
			dbArrivalTime = trimedArrPlandTime.substring(0, 4) + month2 + day2 + hour2 + minute2;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
//		System.out.println(departureId);
//		System.out.println(arrivalId);
//		System.out.println(departureTime);
//		System.out.println(arrivalTime);
//		System.out.println(trimedGradeNm);
//		System.out.println(charge);
		
		//잔여좌석 결과를 조회할 때, 이전에 조회한 적이 없다면 새로운 Route, Bus, Seat 이 생성이 됩니다.
		System.out.println("잔여좌석 결과 : " + reservationService.getRemainingSeatCount(
				departureId, 
				arrivalId, 
				departureTime, 
				arrivalTime, 
				trimedGradeNm,
				price));

		return reservationService.getRemainingSeatCount(
				departureId, 
				arrivalId, 
				departureTime, 
				arrivalTime, 
				trimedGradeNm,
				price);
	}
	
	@GetMapping("/terminal-list")
	public List<String> terminalList(@RequestParam String cityName) {
		int cityId = routeService.getCityIdByCityName(cityName);
		return routeService.getTerminalNamesByCityId(cityId);
	}
	

	private static java.sql.Date getSqlDate(int year, int month, int day, int hour, int minute) throws ParseException {
		// Construct a java.util.Date object
		java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd HH:mm")
				.parse(String.format("%04d-%02d-%02d %02d:%02d", year, month, day, hour, minute));

		// Convert java.util.Date to java.sql.Date
		return new java.sql.Date(utilDate.getTime());
	}
}
