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
		
		return "ok";
	}
	
	@PostMapping("/seat-selection")
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
	
	@PostMapping("/seat-modification")
	public ResponseEntity<Map<String, Object>>  modifySelectedSeatsInBus(@RequestBody Map<String, Object> request) {
		System.out.println(request.toString());
		int busId = Integer.parseInt(request.get("busId").toString());
		//Object to List<Integer>
		List<Object> li = (ArrayList<Object>) request.get("updateTrueSeatsList");
		List<Object> li2 = (ArrayList<Object>) request.get("updateFalseSeatsList");
		List<Integer> updateTrueSeatsList =  new ArrayList<>();
		List<Integer> updateFalseSeatsList =  new ArrayList<>();
		li.stream().map(obj -> Integer.parseInt(obj.toString())).forEach(updateTrueSeatsList::add);
		li2.stream().map(obj -> Integer.parseInt(obj.toString())).forEach(updateFalseSeatsList::add);
		//좌석검증
		if(!reservationService.verifySeatsCount(busId, updateTrueSeatsList)) 
			return new ResponseEntity<Map<String, Object>>(request, HttpStatusCode.valueOf(400));
		//좌석변경 --> 버스 좌석변경, 예약좌석 변경
		String payId = request.get("payId").toString();
		reservationService.modifySeat(updateTrueSeatsList, updateFalseSeatsList, busId, payId);
		
		
		return new ResponseEntity<Map<String, Object>>(request, HttpStatusCode.valueOf(200));
	}
	
	 // 결제 후 정보 받기	
	@PostMapping("/reservation/payOk")
	public ResponseEntity<Map<String, Object>> paytestOk(@RequestBody Map<String, Object> request) {
		System.out.println("결제후 정보:"+request.toString());
		
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
