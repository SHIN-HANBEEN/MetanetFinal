package metanet.kosa.metanetfinal;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.extern.slf4j.Slf4j;
import metanet.kosa.metanetfinal.reservation.service.IReservationService;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	IReservationService reservationService;
	
	@GetMapping(value="/")
	public String home(Model model) {
		model.addAttribute("message", "Welcome");
		return "/main";
	}
	
	@PostMapping(value = "/main") 
	public String homePost(@RequestBody Map<String, String> body, Model model) {
		String isOneWay = body.get("isOneWay");
		String departureId = body.get("departureId");
		String arrivalId = body.get("arrivalId");
		String departureTimeString = body.get("departureTime");
		String arrivalTimeString = body.get("arrivalTime");
		String gradeName = body.get("gradeName");
		int price = Integer.parseInt(body.get("price"));
		
		Date departureTime = null;
		Date arrivalTime = null;
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		try {
            Date parsedDepartureDate = (Date) dateFormat.parse(departureTimeString);
            Date parsedArrivalDate = (Date) dateFormat.parse(arrivalTimeString);
            departureTime = new Date(parsedDepartureDate.getTime());
            arrivalTime = new Date(parsedArrivalDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
		
		model.addAttribute("remainingSeatCount", 
				reservationService.getRemainingSeatCount(departureId, arrivalId, departureTime, arrivalTime, gradeName, price));
		return "";
	}
}
