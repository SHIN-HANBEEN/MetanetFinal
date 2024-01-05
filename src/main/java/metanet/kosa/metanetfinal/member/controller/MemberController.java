package metanet.kosa.metanetfinal.member.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.member.service.IMemberService;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memberService;
	
	@GetMapping(value="/signin")
	public String signin(HttpSession session, Model model) {
		String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        
		return "signin";
	}
}
