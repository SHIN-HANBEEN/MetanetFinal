package metanet.kosa.metanetfinal.member.controller;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.IMemberService;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;

@Controller
public class MemberController {

	@Autowired
	IMemberService memberService;

	@Autowired
	PhoneNumCertificationService phoneNumCertificationService;

	@Autowired
	JwtTokenProvider tokenProvider;

	
	@Autowired
	PasswordEncoder passwordEncoder;

	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password) {
		/*
		 * web 에서 보낸 데이터에서 "userid" 키 값을 꺼내서 그걸로 Member 객체를 얻어내고, 유효성 검사를 마친 후에는 token 을
		 * 만들어서 반환해주면 된다.
		 */
		Members member = memberService.getMemberInfo(id);
		if (member == null) {
			throw new IllegalArgumentException("사용자가 없습니다");
		}
		if (!passwordEncoder.matches(password, member.getPassword())) {
			throw new IllegalArgumentException("비밀번호 오류");
		}
		String token = tokenProvider.generateToken(member);
		System.out.println("token" + token);

		return ResponseEntity.ok(token);
	}

//	 @PostMapping("/login2")
//	 @ResponseBody
//     public String login2(@RequestBody Map<String, String> user) {
//          /*
//          * web 에서 보낸 데이터에서 "userid" 키 값을 꺼내서 그걸로
//          * Member 객체를 얻어내고,
//          * 유효성 검사를 마친 후에는 token 을 만들어서 반환해주면 된다.
//          */
//          Members member = memberService.getMemberInfo(user.get("id"));
//          System.out.println("members : "+member);
//          if (member==null) {
//               throw new IllegalArgumentException("사용자가 없습니다");
//          }
//          System.out.println("password :" + user.get("password"));
//          System.out.println(member.getPassword());
//
//          if(!passwordEncoder.matches(user.get("password"), member.getPassword())) {
//               throw new IllegalArgumentException("비밀번호 오류");
//          }
//          return tokenProvider.generateToken(member);
//     }
	/*
	 * @PostMapping("/login") public String login(@RequestParam String id
	 * , @RequestParam String password) {
	 * 
	 * web 에서 보낸 데이터에서 "userid" 키 값을 꺼내서 그걸로 Member 객체를 얻어내고, 유효성 검사를 마친 후에는 token 을
	 * 만들어서 반환해주면 된다.
	 * 
	 * Members member = memberService.getMemberInfo(id); System.out.println(member);
	 * if (member == null) { throw new IllegalArgumentException("사용자가 없습니다"); } if
	 * (!passwordEncoder.matches(password, member.getPassword())) { throw new
	 * IllegalArgumentException("비밀번호 오류"); } return
	 * tokenProvider.generateToken(member); }
	 */

	@GetMapping("/test_jwt")
	public String testJwt(HttpServletRequest request) {
		String token = tokenProvider.resolveToken(request);
		Authentication auth = tokenProvider.getAuthentication(token);
		return tokenProvider.getUserId(token);
	}

	@GetMapping(value = "/signin")
	public String signin(HttpSession session, Model model) {
		String csrfToken = UUID.randomUUID().toString();
		session.setAttribute("csrfToken", csrfToken);
		Members member = new Members();
		model.addAttribute("member", member);
		return "signin";
	}

	@PostMapping(value = "/signin")
	public String signin(Members member, String csrfToken, HttpSession session, Model model) {
		System.out.println(member.toString());
		System.out.println(csrfToken);
		if (csrfToken == null || "".equals(csrfToken)) {
			throw new RuntimeException("CSRF 토큰이 없습니다.");
		} else if (!csrfToken.equals(session.getAttribute("csrfToken"))) {
			throw new RuntimeException("잘 못된 접근이 감지되었습니다.");
		}
		try {
			if (!member.getPassword().equals(member.getPassword2())) {
				model.addAttribute("member", member);
				model.addAttribute("message", "MEMBER_PW_RE");
				return "signin";
			}
			PasswordEncoder pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
			String encodedPw = pwEncoder.encode(member.getPassword());
			member.setPassword(encodedPw);
			member.setRole("USER_ROLE");
			member.setMileage(0);
			memberService.signin(member);
		} catch (DuplicateKeyException e) {
			member.setId(null);
			model.addAttribute("members", member);
			model.addAttribute("message", "ID_ALREADY_EXIST");
			return "signin";
		}
		session.invalidate();
		return "redirect:/";
	}

	/*
	 * @PostMapping(value="/signin") public String signin(Members member, String
	 * csrfToken,String inputNumber, HttpSession session, Model model) {
	 * System.out.println(member.toString()); System.out.println(csrfToken); boolean
	 * result = phoneNumCertificationService.AuthNumber(member.getPhoneNum(),
	 * inputNumber); if(csrfToken==null || "".equals(csrfToken)) { throw new
	 * RuntimeException("CSRF 토큰이 없습니다."); }else
	 * if(!csrfToken.equals(session.getAttribute("csrfToken"))) { throw new
	 * RuntimeException("잘 못된 접근이 감지되었습니다."); } try {
	 * if(!member.getPassword().equals(member.getPassword2())) {
	 * model.addAttribute("member", member); model.addAttribute("message",
	 * "MEMBER_PW_RE"); return "signin"; }else if(result == false) {
	 * model.addAttribute("member", member); model.addAttribute("message",
	 * "certification_RE"); return "signin"; } PasswordEncoder pwEncoder =
	 * PasswordEncoderFactories.createDelegatingPasswordEncoder(); String encodedPw
	 * = pwEncoder.encode(member.getPassword()); member.setPassword(encodedPw);
	 * member.setRole("user"); member.setMileage(0); memberService.signin(member);
	 * }catch(DuplicateKeyException e) { member.setId(null);
	 * model.addAttribute("members", member); model.addAttribute("message",
	 * "ID_ALREADY_EXIST"); return "signin"; } session.invalidate(); return
	 * "redirect:/"; }
	 */
}
