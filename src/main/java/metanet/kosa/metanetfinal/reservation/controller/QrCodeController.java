package metanet.kosa.metanetfinal.reservation.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.RequestParam;


import metanet.kosa.metanetfinal.reservation.service.IReservationService;

@Controller
public class QrCodeController {
	
	@Autowired
	IReservationService reservationService;
	
	@GetMapping("reservation/ticket")
	public String getTicket2(@RequestParam String payId, Model model) {
		
		Map<String, Object> info = reservationService.getReservationInfo(payId);
		
		// 날짜 형식 변환
        LocalDateTime departureTime = ((Timestamp) info.get("DEPARTURE_TIME")).toLocalDateTime();
        LocalDateTime arrivalTime = ((Timestamp) info.get("ARRIVAL_TIME")).toLocalDateTime();
        LocalDateTime resDate = ((Timestamp) info.get("RES_DATE")).toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm");
        String formattedDepartureTime = departureTime.format(formatter);
        String formattedArrivalTime = arrivalTime.format(formatter);
        String depTime = departureTime.format(formatter2);
        String arrTime = arrivalTime.format(formatter2);
        
        info.put("DEPARTURE_TIME", formattedDepartureTime);
        info.put("ARRIVAL_TIME", formattedArrivalTime);
        info.put("RES_DATE", resDate);
        info.put("depTime", depTime);
        info.put("arrTime", arrTime);
        
        String adult = info.get("ADULT").toString();
		String middleChild = info.get("MIDDLE_CHILD").toString();
		String child = info.get("CHILD").toString();
		StringBuilder sb = new StringBuilder();
		if(!adult.equals("0")) sb.append("성인 "+ adult +"명 ");
		if(!middleChild.equals("0")) sb.append("중고생 "+ middleChild +"명 ");
		if(!child.equals("0")) sb.append("아동 "+ child +"명");
		
		info.put("AGE", sb.toString());
        
        model.addAttribute("info", info);
		
		return "reservation/ticket";
	}
	
	@GetMapping("/tickets")
	@ResponseBody
	public void printTicket(@RequestParam String payId) {
		
	}

 


}