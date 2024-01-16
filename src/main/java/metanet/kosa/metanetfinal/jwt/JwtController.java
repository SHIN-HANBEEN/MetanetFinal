package metanet.kosa.metanetfinal.jwt;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import lombok.extern.slf4j.Slf4j;
@Slf4j
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
			//return ResponseEntity.ok(response);
			return ResponseEntity.ok(response);
		}
	}
}
