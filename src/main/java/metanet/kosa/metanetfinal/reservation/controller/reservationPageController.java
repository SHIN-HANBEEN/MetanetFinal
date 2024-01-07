package metanet.kosa.metanetfinal.reservation.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class reservationPageController {
	
	@GetMapping("/reservation/seats-selection")
	public String seatsSelectPage() {
		
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
}
