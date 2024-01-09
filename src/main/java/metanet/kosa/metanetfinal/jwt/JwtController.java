package metanet.kosa.metanetfinal.jwt;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;

import io.jsonwebtoken.lang.Collections;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.IMemberService;
import metanet.kosa.metanetfinal.member.service.PhoneNumCertificationService;

@Controller
public class JwtController {

	@Autowired
	JwtTokenProvider tokenProvider;

	@PostMapping("/validateToken")
	public ResponseEntity<Map<String, Boolean>> validateToken(@RequestHeader("Authorization") String authorizationHeader) {
	    String token = authorizationHeader.replace("Bearer ", "");

		Map<String, Boolean> response = new HashMap<>();
		if (token != null && tokenProvider.validateToken(token)) {
			// 토큰이 유효한 경우
			response.put("valid", true);
			return ResponseEntity.ok(response);
		} else {
			// 토큰이 유효하지 않은 경우
			response.put("valid", false);
			return ResponseEntity.ok(response);
		}
	}
}
