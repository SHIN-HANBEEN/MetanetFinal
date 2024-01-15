package metanet.kosa.metanetfinal.reservation.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.MemberService;
import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
import metanet.kosa.metanetfinal.reservation.service.IReservationService;
import metanet.kosa.metanetfinal.reservation.service.PaymentService;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;
import metanet.kosa.metanetfinal.route.service.IRouteService;

@Controller
public class ReservationPageController {
	
	@Autowired
	IRouteService routeService;

	@Autowired
	ReservationService reservationService;
	
	@Autowired
	PaymentService paymentService;
	
	@Autowired
	MemberService memberService;
	
	public static final String API_KEY = "7114317823237442";
    public static final String API_SECRET = "qiHm0droCiIRucwhp9k1yBeaOxAzi1FendeBExV5fmqFasplQcWgQXwcaCVlEZB5eKT2OmkxaDlUB8m8";

    
	@GetMapping("/reservation/seats-selection")
	public String seatsSelectPage(@RequestParam String dpTerminalName, @RequestParam String arrTerminalName,
			@RequestParam String departureTime, Model model) {
		String departureId = routeService.getTerminalIdByTerminalName(dpTerminalName);
		String arrivalId = routeService.getTerminalIdByTerminalName(arrTerminalName);

		// 'YYYY-MM-DD HH:mm' 형태로 저장된다.
		System.out.println("departureTime : " + departureTime);

		String parsedDepartureTime = departureTime.substring(0, 4) + departureTime.substring(5, 7)
				+ departureTime.substring(8, 10) + departureTime.substring(11, 13) + departureTime.substring(14, 16);

		// 202401082140 형태로 전환
		System.out.println("parsedDepartureTime  : " + parsedDepartureTime);

		Map<String, Object> dataForSeatsSelection = reservationService.getDataForSeatsSelection(departureId, arrivalId,
				parsedDepartureTime);

		model.addAttribute("mapData", dataForSeatsSelection);

		return "/reservation/seat_reservation";
	}
	
	@GetMapping("/reservation/seats-selection/modification/")
	public String modifySeatsSelectPage(@RequestParam String dpTerminalName, @RequestParam String arrTerminalName,
			@RequestParam String departureTime, @RequestParam String payId , Model model) {
		String departureId = routeService.getTerminalIdByTerminalName(dpTerminalName);
		String arrivalId = routeService.getTerminalIdByTerminalName(arrTerminalName);

		// 'YYYY-MM-DD HH:mm' 형태로 저장된다.
		System.out.println("departureTime : " + departureTime);

		String parsedDepartureTime = departureTime.substring(0, 4) + departureTime.substring(5, 7)
				+ departureTime.substring(8, 10) + departureTime.substring(11, 13) + departureTime.substring(14, 16);

		// 202401082140 형태로 전환
		System.out.println("parsedDepartureTime  : " + parsedDepartureTime);

		Map<String, Object> dataForSeatsSelection = reservationService.getDataForSeatsSelection(departureId, arrivalId,
				parsedDepartureTime);
		List<Integer> mySeatList = reservationService.getMySeatList(payId);
		dataForSeatsSelection.put("mySeatList", mySeatList);
		dataForSeatsSelection.put("payId", payId);
		model.addAttribute("mapData", dataForSeatsSelection);

		return "/reservation/modify_seat_reservation";
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
	public String reservationComplete(@RequestParam String payId, Model model) {
		Map<String, Object> info = reservationService.getReservationInfo(payId);
		String adult = info.get("ADULT").toString();
		String middleChild = info.get("ADULT").toString();
		String child = info.get("ADULT").toString();
		StringBuilder sb = new StringBuilder();
		if(!adult.equals("0")) sb.append("성인 "+ adult +"명 ");
		if(!middleChild.equals("0")) sb.append("중고생 "+ middleChild +"명 ");
		if(!child.equals("0")) sb.append("아동 "+ child +"명");
		
		info.put("AGE", sb.toString());
		model.addAttribute("info",info);
		
		return "reservation/paymentComplete";
	}

	/*
	 * payId 와 총 금액을 통해 환불 처리 진행.
	 * 개인 사업자 API와 비밀키로 토큰을 발행하고
	 * payId, totalprice를 통해 환불 API로 요청을 보내서 환불을 진행.
	 * 
	 * 그 다음 예매한 좌석을 조회해서 취소 시키고
	 * 예매 상태에서 취소 날짜를 현재 날짜로 변경
	 */
	 @PostMapping("/cancelReservation")
	 @Transactional
	 @ResponseBody
	    public ResponseEntity<String> cancelReservation(@RequestBody Map<String, Object> request) {
		 try {  
		 // 받아온 데이터 사용
	        String payId = (String) request.get("payId");
	        String totalPrice =(String) request.get("totalPrice");

	        // 여기에 삭제 작업 수행
	        
	        String token = paymentService.getToken();
	        String merchant_uid = payId;
	        String cancel_request_amount = totalPrice;
	        String reason = "개인 사유로 인한 취소";
	        System.out.println(merchant_uid);
	        
	        paymentService.payMentCancel(token,merchant_uid,cancel_request_amount,reason);
	        reservationService.cancleReservation(merchant_uid);
	        // 작업 결과에 따라 응답 반환
	        return ResponseEntity.ok("Success");
	        
	    } catch (Exception e) {
	        // 실패했을 경우
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to process data");
	    }
	}
	 
	@GetMapping(value="/reservation/list")
	public String mypage(Principal principal, Model model) {
		
		//전화번호, memberid, cancel
		String phoneNum = memberService.getPhoneNumberById(principal.getName());
		System.out.println(phoneNum);
		
		//전화번호를 기반으로 현재 날짜를 기준으로 6개월 간 예매 정보를 가져옴.
		List<DetailedReservation> ReservationList = reservationService.getReservationHistoryForLastSixMonth(false,phoneNum, true); 
		//전체 예매 내역 수 
		int countResList = ReservationList.size();
		System.out.println(countResList);
		
		//전화번호를 기반으로 출발일이 현재 날짜 이후 인 예매 정보 조회
		List<DetailedReservation> ReservationNotUsedList = reservationService.getReservationHistoryNotUsed(phoneNum, true); 
		System.out.println(ReservationNotUsedList);
		//진행 중인 예매 내역 수
		int countNotUserdList = ReservationNotUsedList.size();
		System.out.println(countNotUserdList);

		//최근 6개월의 예매 취소 내역 조회
		List<DetailedReservation> cancelReservationList = reservationService.getReservationHistoryForLastSixMonth(true,phoneNum, true); 
		
		Members member = memberService.getMemberInfo(principal.getName());
		model.addAttribute("countNotUserdList",countNotUserdList);
		model.addAttribute("countResList",countResList);
		
		model.addAttribute("ReservationList",ReservationList);
		model.addAttribute("ReservationNotUsedList",ReservationNotUsedList);
		model.addAttribute("cancelReservationList",cancelReservationList);
		model.addAttribute("member", member);
		
		
		return "reservation/reservation_list";
	}
	
	@GetMapping("/reservation/nmemberlist")
	public String getNMemberReservationList(@RequestParam String phoneNum,Principal principal, Model model) {
		
		
		//전화번호를 기반으로 현재 날짜를 기준으로 6개월 간 예매 정보를 가져옴.
		List<DetailedReservation> ReservationList = reservationService.getReservationHistoryForLastSixMonth(false,phoneNum, false); 
		//전체 예매 내역 수 
		int countResList = ReservationList.size();
		System.out.println(countResList);
		
		//전화번호를 기반으로 출발일이 현재 날짜 이후 인 예매 정보 조회
		List<DetailedReservation> ReservationNotUsedList = reservationService.getReservationHistoryNotUsed(phoneNum, false); 
		System.out.println(ReservationNotUsedList);
		//진행 중인 예매 내역 수
		int countNotUserdList = ReservationNotUsedList.size();
		System.out.println(countNotUserdList);

		//최근 6개월의 예매 취소 내역 조회
		List<DetailedReservation> cancelReservationList = reservationService.getReservationHistoryForLastSixMonth(true,phoneNum, false); 
		
		model.addAttribute("countNotUserdList",countNotUserdList);
		model.addAttribute("countResList",countResList);
		
		model.addAttribute("ReservationList",ReservationList);
		model.addAttribute("ReservationNotUsedList",ReservationNotUsedList);
		model.addAttribute("cancelReservationList",cancelReservationList);
		return "reservation/reservation_list";
	}

	    
}
