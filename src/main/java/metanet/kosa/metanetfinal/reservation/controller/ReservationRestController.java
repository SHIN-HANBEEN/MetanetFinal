package metanet.kosa.metanetfinal.reservation.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import metanet.kosa.metanetfinal.reservation.service.ReservationService;
import metanet.kosa.metanetfinal.reservation.service.SeatsLockSystemService;

@RestController
public class ReservationRestController {
	
	@Autowired
	ReservationService reservationService;
	@Autowired
	SeatsLockSystemService seatsLockSystemService;
	
	@GetMapping("/routeinfotest")
	public Map<String, Object> getInfoForReservation(
			@RequestParam String departureId, 
			@RequestParam String arrivalId, 
			@RequestParam String departureTime) {
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
		Map<String, Object> dataForSeatsSelection = reservationService.getDataForSeatsSelection(departureId, arrivalId, departureTime);
		
		return dataForSeatsSelection;
	}
	
	@PostMapping("/routeinfotest")
	public ResponseEntity<Map<String, Object>>  selectedSeatsInBus(@RequestBody Map<String, Object> request) {
		System.out.println(request.toString());
		int busId = Integer.parseInt(request.get("busId").toString());
		//Object to List<Integer>
		List<Object> li = (ArrayList<Object>) request.get("selectedSeats");
		List<Integer> selectedSeatsList =  new ArrayList<>();
		li.stream().map(obj -> Integer.parseInt(obj.toString())).forEach(selectedSeatsList::add);
		//좌석검증
		if(!reservationService.verifySeatsCount(busId, selectedSeatsList)) 
			return new ResponseEntity<Map<String, Object>>(request, HttpStatusCode.valueOf(400));
		//검증되면 좌석 락
		seatsLockSystemService.seatsLocking10m(busId, selectedSeatsList);
		System.out.println("총가격"+request.get("totalPrice"));
		return new ResponseEntity<Map<String, Object>>(request, HttpStatusCode.valueOf(200));
	}
	
	 // 결제 후 정보 받기	
	@PostMapping("/reservation/payOk")
	public ResponseEntity<Map<String, Object>> paytestOk(@RequestBody Map<String, Object> request) {
		System.out.println(request.toString());
		
		List<Object> li = (ArrayList<Object>) request.get("selectedSeats");
		List<Integer> selectedSeatsList =  new ArrayList<>();
		li.stream().map(obj -> Integer.parseInt(obj.toString())).forEach(selectedSeatsList::add);
		//좌석잠금큐에서 삭제
		seatsLockSystemService.paymentCompleteProcess(Integer.parseInt(request.get("busId").toString()), selectedSeatsList);
		//좌석예약 DB Insert
		boolean isInserted = reservationService.reservationPaymentComplete(request, selectedSeatsList);
		if(!isInserted) {
			//Insert 실패시
			return new ResponseEntity<>(HttpStatusCode.valueOf(500));
			 
		}
		return new ResponseEntity<Map<String, Object>>(request, HttpStatusCode.valueOf(200));
		
	}
}
