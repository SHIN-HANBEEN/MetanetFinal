package metanet.kosa.metanetfinal.reservation.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class reservationPageController {
	
	@GetMapping("/reservation/seats-selection")
	public String seatsSelectPage() {
		
		return "/reservation/seat_reservation";
	}

	@GetMapping("/reservation/payment")
	public String paymentPage() {

		return "/reservation/pay";
	}
}
