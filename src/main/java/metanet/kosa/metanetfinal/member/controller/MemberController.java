package metanet.kosa.metanetfinal.member.controller;

import java.awt.Dialog.ModalExclusionType;
import java.security.Principal;
import java.util.List;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.repository.IMemberRepository;
import metanet.kosa.metanetfinal.member.service.IMemberService;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;
import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
import metanet.kosa.metanetfinal.reservation.model.Reservations;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;

@Controller
public class MemberController {

	@Autowired
	IMemberService memberService;

	@Autowired
	PhoneNumCertificationService phoneNumCertificationService;

	@Autowired
	JwtTokenProvider tokenProvider;
	
	@Autowired
	ReservationService reservationService;

	
	@Autowired
	PasswordEncoder passwordEncoder;

	@GetMapping(value="/login")
	public String login() {
		return "member/login";
	}
	
	
	@PostMapping("/login")
	@ResponseBody
	public ResponseEntity<String> login(@RequestParam String id, @RequestParam String password, 
			HttpServletResponse response) {
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
		/*
		 * 비밀번호 검증이 완료 되면 쿠키에 JWT 토큰을 넣어서 생성
		 */
		Cookie cookie = new Cookie(
				"access_token", tokenProvider.generateToken(member));
		cookie.setMaxAge(60*60*24*7); //어차피 token 에 유효기간을 설정을 해두었기 때문에 의미는 없다.
		cookie.setHttpOnly(true);
		cookie.setPath("/");
		
		response.addCookie(cookie);

		return ResponseEntity.ok("Login successful");
	}
	

	@GetMapping("/logout2")
	public String logout(HttpServletResponse response) {
		Cookie cookie = new Cookie(
				"access_token", null);
		cookie.setMaxAge(0); //어차피 token 에 유효기간을 설정을 해두었기 때문에 의미는 없다.
		cookie.setHttpOnly(true);
		cookie.setPath("/");
		
		response.addCookie(cookie);

		return "redirect:/";
	}
	
	

	@GetMapping(value="/mypage")
	public String mypage(Principal principal, Model model) {
		System.out.println(principal.getName());
		//전화번호, memberid, cancel
		String phoneNum = memberService.getPhoneNumberById(principal.getName());
		System.out.println(phoneNum);
		//전화번호를 기반으로 현재 날짜를 기준으로 6개월 간 예매 정보를 가져옴.
		List<DetailedReservation> ReservationList = reservationService.getReservationHistoryForLastSixMonth(false,phoneNum); 
		//전체 예매 내역 수 
		int countResList = ReservationList.size();
		System.out.println(countResList);
		
		//전화번호를 기반으로 출발일이 현재 날짜 이후 인 예매 정보 조회
		List<DetailedReservation> ReservationNotUsedList = reservationService.getReservationHistoryNotUsed(phoneNum); 
		System.out.println(ReservationNotUsedList);
		//진행 중인 예매 내역 수
		int countNotUserdList = ReservationNotUsedList.size();
		System.out.println(countNotUserdList);

		//최근 6개월의 예매 취소 내역 조회
		List<DetailedReservation> cancelReservationList = reservationService.getReservationHistoryForLastSixMonth(true,phoneNum); 
		
		Members member = memberService.getMemberInfo(principal.getName());
		model.addAttribute("countNotUserdList",countNotUserdList);
		model.addAttribute("countResList",countResList);
		
		model.addAttribute("ReservationList",ReservationList);
		model.addAttribute("ReservationNotUsedList",ReservationNotUsedList);
		model.addAttribute("cancelReservationList",cancelReservationList);
		model.addAttribute("member", member);
		//System.out.println("토큰 테스트 : "+ authToken);
		return "member/mypage";
	}

	@GetMapping(value = "/member-information")
	public String memberModification(Principal principal, Model model) {
		Members member = memberService.getMemberInfo(principal.getName());
		model.addAttribute("member", member);
		return "member/member-information";
	}

	@GetMapping(value = "/signin")
	public String signin(HttpSession session, Model model) {
		/*UUID 로 CSRF토큰을 생성하여 
		 * 
		 */
		String csrfToken = UUID.randomUUID().toString();
		session.setAttribute("csrfToken", csrfToken);
		Members member = new Members();
		model.addAttribute("member", member);
		return "member/signin";
	}

	@PostMapping(value = "/signin")
	public String signin(Members member, String csrfToken, HttpSession session, Model model) {
		System.out.println(member.toString());
		System.out.println(csrfToken);
		if (csrfToken == null || "".equals(csrfToken)) {
			throw new RuntimeException("CSRF 토큰이 없습니다.");
			
		} else if (!csrfToken.equals(session.getAttribute("csrfToken"))) {
			throw new RuntimeException("잘못된 접근이 감지되었습니다.");
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
			member.setRole("ROLE_USER");
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
	
	@GetMapping(value="/pw-modification")
	public String modification_pw(Principal principal, Model model) {
		return "member/pw-modification";
	}
	
	@GetMapping(value="/member-modification")
	public String modification_member(Principal principal, Model model) {
		return "member/member-modification";
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
