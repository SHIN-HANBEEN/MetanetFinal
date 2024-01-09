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
import org.springframework.web.bind.annotation.RequestHeader;

import lombok.extern.slf4j.Slf4j;
import metanet.kosa.metanetfinal.reservation.service.IReservationService;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;


@Controller
public class HomeController {
	
	@Autowired
	IReservationService reservationService;
	
	@GetMapping(value="/")
	public String home() {
		return "home2";
	}
	
	@GetMapping(value="/login")
	public String login() {
		return "login";
	}
	
	@GetMapping(value="/mypage")
	public String mypage() {
		//System.out.println("토큰 테스트 : "+ authToken);
		return "mypage";
	}
	
	/*
	 * @GetMapping(value="/signin") public String signin() { return "signin"; }
	 */
	
	/*
	 * 출발지, 도착지, 출발시간(출발일자 아님, 배차조회까지 끝낸 다음 선택한 출발시간) 입력
	 * 한 다음, 잔여좌석을 model 에 담아서 redirect 한다. 
	 * 지금은 아직 redirect 할 페이지 작성을 안해서, home 으로 return 을 작성해두었다.
	 */
	@PostMapping(value = "/home") 
	public String homePost(@RequestBody Map<String, String> body, Model model) {
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
            java.util.Date parsedDepartureDate = dateFormat.parse(departureTimeString);
            java.util.Date parsedArrivalDate = dateFormat.parse(arrivalTimeString);
            departureTime = new Date(parsedDepartureDate.getTime());
            arrivalTime = new Date(parsedArrivalDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
		
		model.addAttribute("remainingSeatCount", 
				reservationService.getRemainingSeatCount(departureId, arrivalId, departureTime, arrivalTime, gradeName, price));
		System.out.println(reservationService.getRemainingSeatCount(departureId, arrivalId, departureTime, arrivalTime, gradeName, price));
		return "home2";
	}
}
