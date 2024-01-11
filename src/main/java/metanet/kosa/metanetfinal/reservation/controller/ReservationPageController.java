package metanet.kosa.metanetfinal.reservation.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import metanet.kosa.metanetfinal.reservation.service.IReservationService;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;
import metanet.kosa.metanetfinal.route.service.IRouteService;

@Controller
public class ReservationPageController {
	@Autowired
	IRouteService routeService;
	
	@Autowired
	IReservationService reservationService;

	@GetMapping("/reservation/seats-selection")
	public String seatsSelectPage(
			@RequestParam String dpTerminalName, 
			@RequestParam String arrTerminalName,
			@RequestParam String departureTime,
			Model model
	) {
		String departureId = routeService.getTerminalIdByTerminalName(dpTerminalName);
		String arrivalId = routeService.getTerminalIdByTerminalName(arrTerminalName);
		
		 // 'YYYY-MM-DD HH:mm' 형태로 저장된다.
		System.out.println("departureTime : " + departureTime);
		
		String parsedDepartureTime = departureTime.substring(0, 4) +
				departureTime.substring(5,7) +
				departureTime.substring(8,10) +
				departureTime.substring(11, 13) +
				departureTime.substring(14, 16);
		
		//202401082140 형태로 전환
		System.out.println("parsedDepartureTime  : " + parsedDepartureTime);
		
		Map<String, Object> dataForSeatsSelection = 
				reservationService.getDataForSeatsSelection(departureId, 
						arrivalId, parsedDepartureTime);
		
		model.addAttribute("mapData", dataForSeatsSelection);

		return "/reservation/seat_reservation";
	}

	@PostMapping("/reservation/payment")
	public Map<String, Object> paymentPage(@RequestBody Map<String, Object> request) {
		System.out.println(request);
		return request;
	}

	@GetMapping("/reservation/payment")
	public String paymentPage1() {

		return "/reservation/pay";
	}
	
	@GetMapping("/reservation/complete")
	public String reservationComplete() {
		return "/reservation/paymentComplete";
	}

}
