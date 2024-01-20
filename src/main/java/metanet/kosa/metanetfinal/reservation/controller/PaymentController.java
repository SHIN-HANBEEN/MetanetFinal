package metanet.kosa.metanetfinal.reservation.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.MemberService;
import metanet.kosa.metanetfinal.reservation.service.PaymentService;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;
import metanet.kosa.metanetfinal.reservation.service.SeatsLockSystemService;

@RestController
public class PaymentController {

	@Autowired
	PaymentService paymentService;
	@Autowired
	MemberService memberService;
	
	private final IamportClient iamportClient;

	public static final String API_KEY = "7114317823237442";
    public static final String API_SECRET = "qiHm0droCiIRucwhp9k1yBeaOxAzi1FendeBExV5fmqFasplQcWgQXwcaCVlEZB5eKT2OmkxaDlUB8m8";

	public PaymentController() {
		
		/*
		 토큰 발급 
		 */
        this.iamportClient = new IamportClient(API_KEY, API_SECRET);
    }
	
	@PostMapping("reservation/refund/cancel")
    public ResponseEntity<Map> cancelPayment(@RequestBody Map<String, Object> request) throws Exception {
    
    try {
       String token = paymentService.getToken();
       String merchant_uid = (String)request.get("merchant_uid");
       String cancel_request_amount = String.valueOf(request.get("cancel_request_amount"));
       String reason = (String)request.get("reason");
       
       paymentService.payMentCancel(token,merchant_uid,cancel_request_amount,reason);
       Map<String, String> response = new HashMap<>();
           response.put("status", "success");
           response.put("message", "Cancellation successful");

           return ResponseEntity.ok(response);
           
       } catch (Exception e) {
          Map<String, String> response = new HashMap<>();
           response.put("status", "error");
           response.put("message", e.getMessage());

           return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);           
       }
    }
	
	
	@PostMapping("/verify/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);
    }
	
	
	
	@GetMapping(value="reservation/pay")
	public ModelAndView home(Model model) {
		ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("reservation/pay");
		return modelAndView;
	}
	
	@GetMapping("reservation/refund")
	public ModelAndView getRefundTest(Model model) {
		ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("reservation/refund");
		return modelAndView;
		// return "reservation/refundtest";
	}
	

	
	@GetMapping("/paymentid")
	public Map<String, String> getMerchant_uid(Principal principal) {
		Map<String, String> merchantUid = new HashMap<>();
		Date date = new Date();
		String uuid = UUID.randomUUID().toString();
		String uid =  uuid.substring(3,18);
		merchantUid.put("paymentId", uid);
		merchantUid.put("lockingTime", String.valueOf(SeatsLockSystemService.lockingTime));
		merchantUid.put("discountRate", String.valueOf(ReservationService.discountRate));
		try {
			String memberId = principal.getName();
			
			Members member = memberService.getMemberInfo(memberId);
			merchantUid.put("memberId", String.valueOf(member.getMemberId()));
			merchantUid.put("memberMileage", String.valueOf(member.getMileage()));
			merchantUid.put("memberPhoneNum", member.getPhoneNum());
			merchantUid.put("isMember", "true");
			
			
		} catch (Exception e) {
			// TODO: handle exception
			merchantUid.put("isMember", "false");
		}
		return merchantUid;
	}
	
}
