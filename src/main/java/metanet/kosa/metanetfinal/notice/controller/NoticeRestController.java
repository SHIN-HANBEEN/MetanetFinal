package metanet.kosa.metanetfinal.notice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class NoticeRestController {
	@GetMapping("/notice/getRegister")
	public String getNoticeRegister() {
		return "<h2 class=\"title pb-3 pt-4\">게시글 등록</h2>\r\n"
				+ "\r\n"
				+ "	<!-- 공지사항 컨테이너 -->\r\n"
				+ "	<div class=\"row\">\r\n"
				+ "		<div class=\"col-2\">\r\n"
				+ "\r\n"
				+ "		</div>\r\n"
				+ "\r\n"
				+ "		<div class=\"col-8\">\r\n"
				+ "			<hr class=\"dark horizontal mt-0 mb-2\">\r\n"
				+ "			<span th:text=\"${#authentication.principal.username}\"></span>\r\n"
				+ "		</div>\r\n"
				+ "\r\n"
				+ "		<div class=\"col-2\">\r\n"
				+ "\r\n"
				+ "		</div>\r\n"
				+ "\r\n"
				+ "	</div>\r\n"
				+ "\r\n"
				+ "\r\n"
				+ "";
	}
}
