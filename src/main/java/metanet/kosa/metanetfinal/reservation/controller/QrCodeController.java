package metanet.kosa.metanetfinal.reservation.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import metanet.kosa.metanetfinal.reservation.service.IReservationService;

@Controller
public class QrCodeController {
	
	@Autowired
	IReservationService reservationService;
	
	@GetMapping("reservation/ticket2")
	public String getTicket2(@RequestParam String payId, Model model) {
		
		Map<String, Object> info = reservationService.getReservationInfo(payId);
		
		// 날짜 형식 변환
        LocalDateTime departureTime = ((Timestamp) info.get("DEPARTURE_TIME")).toLocalDateTime();
        LocalDateTime arrivalTime = ((Timestamp) info.get("ARRIVAL_TIME")).toLocalDateTime();
        LocalDateTime resDate = ((Timestamp) info.get("RES_DATE")).toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm");
        String formattedDepartureTime = departureTime.format(formatter);
        String depTime = departureTime.format(formatter2);
        String arrTime = arrivalTime.format(formatter2);
        
        info.put("DEPARTURE_TIME", formattedDepartureTime);
        info.put("ARRIVAL_TIME", arrivalTime);
        info.put("RES_DATE", resDate);
        info.put("depTime", depTime);
        info.put("arrTime", arrTime);
        
        model.addAttribute("info", info);
		
		return "reservation/ticket2";
	}

 


}