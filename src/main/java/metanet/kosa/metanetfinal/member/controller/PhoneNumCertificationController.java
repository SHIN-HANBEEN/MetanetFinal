package metanet.kosa.metanetfinal.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;

@RestController
public class PhoneNumCertificationController {
	@Autowired
	PhoneNumCertificationService phoneNumCertificationService;
	
	@GetMapping("/certification-phonenumber")
	public void sendRandomNumber(@RequestParam("phonenum") String phonenum) {
		phoneNumCertificationService.sendRandomNumber(phonenum);
	}
	
	@PostMapping("/certification-phonenumber")
	public String AuthenticationNumber(@RequestParam String phonenum, @RequestParam String inputNumber) {
		boolean result = phoneNumCertificationService.AuthNumber(phonenum, inputNumber);
		return result ? "인증에 성공했습니다." : "인증에 실패했습니다.";
	}
}
