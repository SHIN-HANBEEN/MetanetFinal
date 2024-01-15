package metanet.kosa.metanetfinal.coolsms;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/sms-certification")
public class SmsCertificationController {
	@Autowired
	PhoneNumCertificationService phoneNumCertificationService;
	
	@PostMapping("/send")
	public ResponseEntity<?> sendSms(@RequestParam("phonenum") String phonenum) throws Exception {
		try {
			// sendRandomNumber(String)
			phoneNumCertificationService.sendRandomNumber(phonenum);
			 // return new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.SMS_CERT_MESSAGE_SUCCESS), HttpStatus.OK);
			
		} catch() {
			
		}
	}
}
