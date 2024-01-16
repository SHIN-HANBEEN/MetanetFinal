package metanet.kosa.metanetfinal.member.controller;

import java.security.Principal;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.IMemberService;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;
import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;
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

	@GetMapping(value = "/login")
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
				"access_token", tokenProvider.generateToken(member)); //member 객체에 담긴 정보를 토대로 jwt token 을 만든다.
		cookie.setMaxAge(60*60*24*7); //어차피 token 에 유효기간을 설정을 해두었기 때문에 의미는 없다.

		cookie.setHttpOnly(true);
		cookie.setPath("/");

		response.addCookie(cookie);

		return ResponseEntity.ok("Login successful");
	}

	@GetMapping("/logout2")
	public String logout(HttpServletResponse response) {
		Cookie cookie = new Cookie("access_token", null);
		cookie.setMaxAge(0); // 어차피 token 에 유효기간을 설정을 해두었기 때문에 의미는 없다.
		cookie.setHttpOnly(true);
		cookie.setPath("/");

		response.addCookie(cookie);

		return "redirect:/";
	}

	@GetMapping(value = "/mypage")
	public String mypage(Principal principal, Model model) {
		System.out.println(principal.getName());
		// 전화번호, memberid, cancel
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
		// 진행 중인 예매 내역 수
		int countNotUserdList = ReservationNotUsedList.size();
		System.out.println(countNotUserdList);


		//최근 6개월의 예매 취소 내역 조회
		List<DetailedReservation> cancelReservationList = reservationService.getReservationHistoryForLastSixMonth(true,phoneNum, true); 
		

		Members member = memberService.getMemberInfo(principal.getName());
		model.addAttribute("countNotUserdList", countNotUserdList);
		model.addAttribute("countResList", countResList);

		model.addAttribute("ReservationList", ReservationList);
		model.addAttribute("ReservationNotUsedList", ReservationNotUsedList);
		model.addAttribute("cancelReservationList", cancelReservationList);
		model.addAttribute("member", member);
		// System.out.println("토큰 테스트 : "+ authToken);
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
		/*
		 * UUID 로 CSRF토큰을 생성하여
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

	@GetMapping(value = "/sign-out")
	public String sign_out()	{
		return "/member/member-delete";
	}

	@GetMapping(value="/member-modification")
	public String modification_member(Principal principal, Model model, HttpSession session) {
		Members member = memberService.getMemberInfo(principal.getName());
		model.addAttribute("member", member);
		return "member/member-modification";
	}
	

	@PostMapping(value="/member-modification")
	public String modification_member(Principal principal, Members member, String csrfToken, Model model, HttpServletRequest request) {
		//System.out.println("csrfToken: " + csrfToken);
		System.out.println(member);
		/*
		if (csrfToken == null || "".equals(csrfToken)) {
			throw new RuntimeException("CSRF 토큰이 없습니다.");
			
		} else if (!csrfToken.equals(session.getAttribute("csrfToken"))) {
			throw new RuntimeException("잘못된 접근이 감지되었습니다.");
		}
		*/
		PasswordEncoder pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String rawPassword = member.getPassword(); // 사용자가 입력한 평문 비밀번호
		String encodedPassword = memberService.getPwById(principal.getName()); // DB에 저장된 인코딩된 비밀번호

		if (pwEncoder.matches(rawPassword, encodedPassword)) {
		    // 비밀번호가 일치하는 경우
		    memberService.updateMember(member.getId(), member.getEmail(), member.getPhoneNum());
		} else {
		    // 비밀번호가 일치하지 않는 경우
		    System.out.println("패스워드 다름");
		    model.addAttribute("member", member);
			model.addAttribute("message", "MEMBER_PW_RE");
			return "/";
		}

		return "redirect:/member-information";
	}
	

	@PostMapping(value = "/sign-out")
	@ResponseBody
	@Transactional
	public ResponseEntity<String> out_sign(Principal principal, @RequestBody Map<String, String> deleteForm, HttpServletResponse response){
		PasswordEncoder pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String password = (String) deleteForm.get("password");
		try {
			/*
			 *  DB에서 Id에 맞는 비밀번호 불러와서 입력한 비밀번호와 일치하는데 검증
			 *  일치하면 회원 탈퇴
			 */
			String getpwd = memberService.getPassword(principal.getName());
			boolean matches = passwordEncoder.matches(password, getpwd);

			if (matches) {
				System.out.println("비밀번호가 일치합니다.");
				memberService.signOut(principal.getName(), getpwd);
				Cookie cookie = new Cookie("access_token", null);
				cookie.setMaxAge(0); // 어차피 token 에 유효기간을 설정을 해두었기 때문에 의미는 없다.
				cookie.setHttpOnly(true);
				cookie.setPath("/");

				response.addCookie(cookie);
				return ResponseEntity.ok("Success");
			} else {
				System.out.println("비밀번호가 일치하지 않습니다.");
				return ResponseEntity.ok("non-Success");
			}

			// 성공 시
		} catch (Exception e) {
			// 실패 시
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failure");
		}
	}
	
	@GetMapping(value="/pw-modification")
	public String modification_pw(Principal principal, Model model) {
		return "member/pw-modification";
	}

	@PostMapping(value = "/pw-modification")
	@ResponseBody
	@Transactional
	public ResponseEntity<String> pw_modification(Principal principal, @RequestBody Map<String, Object> changepwdForm) {
		System.out.println(changepwdForm);
		PasswordEncoder pwEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String password = (String) changepwdForm.get("password");
		String new_pwd = pwEncoder.encode((String) changepwdForm.get("new_password"));
		try {
			/*
			 *  여기에서 비밀번호 변경 로직 수행
			 *  principal id로 DB의 password 가져와서
			 *  form에서 입력한 비밀번호와 일치하는지 확인 후
			 *  일치할 경우
			 *  비밀번호 변경
			 */
			String getpwd = memberService.getPassword(principal.getName());
			boolean matches = passwordEncoder.matches(password, getpwd);

			if (matches) {
				memberService.updatePassword(principal.getName(), new_pwd);
				return ResponseEntity.ok("Success");
			} else {
				return ResponseEntity.ok("non-Success");
			}

			// 성공 시
		} catch (Exception e) {
			// 실패 시
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failure");
		}
	}


	@PostMapping(value = "idcheck")
	public String id_check(@RequestParam String id) {

		return null;
	}
	
	/*
	 * 403 에러
	@GetMapping("/some-protected-resource")
    public String someProtectedResource() {
        // 여기서 어떤 조건을 검사한 후 접근을 금지할 경우
        throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You do not have permission to access this resource.");
    }
	*/

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
