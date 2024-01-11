package metanet.kosa.metanetfinal.reservation.controller;

import java.io.ByteArrayOutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import metanet.kosa.metanetfinal.reservation.service.IReservationService;

@Controller
public class QrCodeController {
	
	@Autowired
	IReservationService reservationService;
	
	
	/*
	@PostMapping("reservation/tickets")
	// public String getQrcode(@RequestBody Map<String, Object> data, Model model) throws Exception {
	public String getQrcode(Model model) throws Exception {
		//String text = String.valueOf(resId);
		int width = 150;
		int height = 150;
		
		
		System.out.println("ticket controller: " + data.get("payId"));
		
		Map<String,Object> qrMap = new HashMap<>();
		qrMap.put("payId", data.get("payId"));
		qrMap.put("totalPrice", data.get("totalPrice"));
		qrMap.put("busId", data.get("busId"));
		qrMap.put("selectedSeats", data.get("selectedSeats"));
		qrMap.put("adultNum", data.get("adultNum"));
		qrMap.put("routeId", data.get("routeId"));
		
		
		Gson gson = new Gson();
		//String json = gson.toJson(qrMap);
		
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode("234", BarcodeFormat.QR_CODE, width, height);

		ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();

		MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);

		String img = Base64.getEncoder().encodeToString(pngOutputStream.toByteArray());

		
		//model.addAttribute("img", img);
		//model.addAttribute("qrMap", qrMap);
		
		return "reservation/ticket";
	}
*/
	
	
	@PostMapping("reservation/tickets")
	@ResponseBody
	public Map<String, Object> getQrcode() throws Exception {

		//system.out.println("reservation/tickets controller: " + data.get("totalPrice"));
		
//		Gson gson = new Gson();
//		String json = gson.toJson(data);
		
		// Map<String, Object> 
		int width = 150;
		int height = 150;
		
		QRCodeWriter qrCodeWriter = new QRCodeWriter();
		BitMatrix bitMatrix = qrCodeWriter.encode("slkndf", BarcodeFormat.QR_CODE, width, height);

		ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();

		MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);

		String img = Base64.getEncoder().encodeToString(pngOutputStream.toByteArray());
		
		// 출발지, 도착지, 출발시간, 도착시간
		
//		Routes route = routeService.getRoutesInfo((String)data.get("routeId"));
//		//System.out.println((String)data.get("routeId"));
//		String departure = routeService.getTerminalNameByTerminalId(route.getDepartureId());
//		String arrival = routeService.getTerminalNameByTerminalId(route.getArrivalId());
		
		//System.out.println("ticket controller: "+route.toString());
		//System.out.println(departure);
		
		Map<String, Object> ticketMap = new HashMap<>();
		
//		ticketMap.put("data", data);
//		
//		ticketMap.put("departureTime", route.getDepartureTime());
//		ticketMap.put("arrivalTime", route.getArrivalTime());
//		ticketMap.put("departure", departure);
//		ticketMap.put("arrival", arrival);
		ticketMap.put("img", img);
		
//		System.out.println("reservation/tickets controller: " + ticketMap.get("arrivalTime"));
//		System.out.println("reservation/tickets controller: " + ticketMap.get("arrival"));
//		System.out.println("reservation/tickets controller: " + ticketMap.get("img"));
		
		
		// return ResponseEntity.ok(ticketMap);
		return ticketMap;
	}
	
	
	@GetMapping("reservation/ticket2")
	public String getTicket2(@RequestParam String payId, Model model) {
		
		Map<String, Object> info = reservationService.getReservationInfo(payId);
		model.addAttribute("info",info);
		
		// 날짜 형식 변환
        LocalDateTime departureTime = LocalDateTime.parse((String) info.get("DEPARTURE_TIME"));
        LocalDateTime arrivalTime = LocalDateTime.parse((String) info.get("ARRIVAL_TIME"));
        LocalDateTime resDate = LocalDateTime.parse((String) info.get("RES_DATE"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String formattedDepartureTime = departureTime.format(formatter);
        info.put("DEPARTURE_TIME", formattedDepartureTime);
        info.put("ARRIVAL_TIME", arrivalTime);
        info.put("RES_DATE", resDate);
		
		return "reservation/ticket2";
	}
	
	@GetMapping("reservation/ticket3")
	@ResponseBody
	public Map<String, Object> getTicket2(@RequestParam String payId) {
		
		Map<String, Object> info = reservationService.getReservationInfo(payId);
		System.out.println(info);
		return info;
	}
 


}