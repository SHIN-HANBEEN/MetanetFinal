package metanet.kosa.metanetfinal.reservation.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class reservationRestController {
	
	@GetMapping("/routeinfotest")
	public String getInfoForReservation() {
		String info = 
				"{\r\n"
				+ "   \"arrPlaceNm\": \"강릉시외터미널\",\r\n"
				+ "   \"arrPlandTime\": 202312280930,\r\n"
				+ "   \"charge\": 22300,\r\n"
				+ "   \"depPlaceNm\": \"동서울\",\r\n"
				+ "   \"depPlandTime\": 202312280640,\r\n"
				+ "   \"gradeNm\": \"우등\",\r\n"
				+ "   \"routeId\": \"NAI201603170047420\",\r\n"
				+ "   \"occupiedSeats\": [1,2,10,21,22],\r\n"
				+ "   \"adultCharge\": 22300,\r\n"
				+ "   \"middleChildCharge\": 17800,\r\n"
				+ "   \"childCharge\": 9800,\r\n"
				+ "   \"busId\": 100\r\n"
				+ "}";
		return info;
	}
	
	@PostMapping("/routeinfotest")
	public Map<String, Object> selectedSeatsInBus(@RequestBody Map<String, Object> request) {
		System.out.println(request.toString());
		return request;
	}
}
