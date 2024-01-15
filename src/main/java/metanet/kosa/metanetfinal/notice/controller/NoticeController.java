package metanet.kosa.metanetfinal.notice.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.http.HttpRequest;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.mail.Session;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;
import metanet.kosa.metanetfinal.notice.model.NoticeFile;
import metanet.kosa.metanetfinal.notice.model.NoticeRead;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.service.INoticeService;

@Controller
public class NoticeController {

	/*
	 * 전체적으로 memberId 설정 수정 필요
	 */

	@Autowired
	INoticeService noticeService;

	@Autowired
	JwtTokenProvider jwtTokenProvider;

	// 공지사항 홈
	@GetMapping(value = "/notice")
	public String getNotice() {
		return "notice/notice";
	}

	// 공지사항 홈 with offset
	@GetMapping(value = "/noticeoffset")
	public String getNotice(@RequestParam String offset, Model model) {
		model.addAttribute("modelOffset", offset);
		return "notice/notice";
	}

	// 공지사항 등록 화면 이동
	@GetMapping(value = "/notice/register")
	public String getNoticeRegister() {
		return "notice/register";
	}

	// 공지사항 등록하기
	@PostMapping(value = "/notice/write")
	public String writeNotice(Notices notices, BindingResult results, HttpServletRequest request) {

		int memberId = 0;

		// 쿠키에 담긴 로그인 정보 가져오기
		try {
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("access_token")) {
					// String cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
					System.out.println("쿠키에서 꺼낸 value : " + cookie.getValue());
					String token = cookie.getValue();

					// 가져온 JWT 토큰에서 Payload 같은 거 꺼내오는건 JWTProvider 클래스에 작성
					String sub = jwtTokenProvider.getSubjectFromToken(token);
					memberId = jwtTokenProvider.getMemberIdFromToken(token);

					System.out.println("sub 는 " + sub);
					System.out.println("memberId 는 " + memberId);
				}
			}
		} catch (Exception e) {
			System.out.println("쿠키 처리 중 에러 발생");
			return "";
		}

		// 파일 처리하기
		try {
			System.out.println("File 처리 시작");
			MultipartFile mfile = notices.getMultipartFile();

			if (mfile != null && !mfile.isEmpty()) {
				System.out.println("notices 처리 시작");

				notices.setFile(mfile.getBytes()); // 프런트에서 넘어온 MultipartFile 을 DB에 저장하기 위해서는 Byte[] 로 바꾸어 주어야 한다.
				System.out.println("mfile get bytes 처리 완료 : " + mfile.getBytes());

				notices.setFileName(mfile.getOriginalFilename()); // multipartfile 에서 파일 이름을 꺼내주어야 함.
				System.out.println("mfile get filename 처리 완료 : " + mfile.getOriginalFilename());

				notices.setMemberId(Integer.valueOf(memberId));
				System.out.println("mfile get memberId 처리 완료 : " + Integer.valueOf(memberId));
					
				notices.setFileSize(mfile.getSize());
				System.out.println("mfile get fileSize 처리 완료 : " + mfile.getSize());
				
				notices.setFileContentType(mfile.getContentType());
				System.out.println("mfile get contentType 처리 완료 : " + mfile.getContentType());
				
				
				
				System.out.println("insertNoticeWithFile 시작! ");
				
				System.out.println("notices 출력하기 : " + notices);
				
				noticeService.insertNoticeWithFile(notices, memberId);

			} else {
				noticeService.insertNoticeWithoutFile(notices, memberId);
			}

		} catch (Exception e) {
			System.out.println("파일 처리 중 에러 발생");
			return "";
		}

		return "notice/notice";
	}

	//공지 읽기
	@GetMapping("/notice/read")
	public String noticeRead(@RequestParam int noticeId, @RequestParam String offset, Model model) {
		NoticeRead noticeRead = noticeService.noticeRead(noticeId);
		noticeRead.setOffset(Integer.valueOf(offset));
		model.addAttribute("noticeRead", noticeRead); // noticeRead 로 Pagination 도 담아서 함께 보냄
		return "notice/read";
	}
	
	//파일 다운로드
	@GetMapping("/file")
	public ResponseEntity<byte[]> getFile(@RequestParam String noticeId) {
		NoticeFile noticeFile = noticeService.getNoticeFile(Integer.valueOf(noticeId));
		
		return null;
	}

	/*
	 * // 공지사항 리스트 조회
	 * 
	 * @GetMapping(value = "/notice/list/{page}") public String
	 * getNoticeList(@PathVariable(required = false) Integer page, HttpSession
	 * session, Model model) { if (page == null) { page = 1; }
	 * 
	 * session.setAttribute("page", page); List<Notices> noticeList =
	 * noticeService.getNoticeList(page); model.addAttribute("noticeList",
	 * noticeList);
	 * 
	 * int bbsCount = noticeService.getTotalNoticeNum(); int totalPage = 0; if
	 * (bbsCount > 0) { totalPage = (int) Math.ceil(bbsCount / 10.0); } int
	 * totalPageBlock = (int) (Math.ceil(totalPage / 10.0)); int nowPageBlock =
	 * (int) Math.ceil(page / 10.0); int startPage = (nowPageBlock - 1) * 10 + 1;
	 * int endPage = 0; if (totalPage > nowPageBlock * 10) { endPage = nowPageBlock
	 * * 10; } else { endPage = totalPage; } model.addAttribute("totalPageCount",
	 * totalPage); model.addAttribute("nowPage", page);
	 * model.addAttribute("totalPageBlock", totalPageBlock);
	 * model.addAttribute("nowPageBlock", nowPageBlock);
	 * model.addAttribute("startPage", startPage); model.addAttribute("endPage",
	 * endPage);
	 * 
	 * return "notice/list3"; }
	 * 
	 * @GetMapping(value = "notice/list") public String getNoticeList(HttpSession
	 * session, Model model) { return getNoticeList(1, session, model); }
	 * 
	 * // 공지사항 검색 리스트 조회
	 * 
	 * @GetMapping("/notice/search/{page}")
	 * 
	 * @ResponseBody public ResponseEntity<?>
	 * getNoticeSearchList(@RequestParam(required = false, defaultValue = "") String
	 * keyword,
	 * 
	 * @PathVariable(required = false) Integer page, HttpSession session, Model
	 * model) {
	 * 
	 * if (page == null) { page = 1; }
	 * 
	 * List<Notices> noticeList = noticeService.getNoticeSearchList(keyword, page);
	 * model.addAttribute("noticeList", noticeList);
	 * 
	 * int bbsCount = noticeService.getTotalNoticSearcheNum(keyword); int totalPage
	 * = 0; if (bbsCount > 0) { totalPage = (int) Math.ceil(bbsCount / 10.0); } int
	 * totalPageBlock = (int) (Math.ceil(totalPage / 10.0)); int nowPageBlock =
	 * (int) Math.ceil(page / 10.0); int startPage = (nowPageBlock - 1) * 10 + 1;
	 * int endPage = 0; if (totalPage > nowPageBlock * 10) { endPage = nowPageBlock
	 * * 10; } else { endPage = totalPage; }
	 * 
	 * Map<String, Object> responseData = new HashMap<>();
	 * responseData.put("noticeList", noticeList); responseData.put("keyword",
	 * keyword); responseData.put("totalPageCount", totalPage);
	 * responseData.put("nowPage", page); responseData.put("totalPageBlock",
	 * totalPageBlock); responseData.put("nowPageBlock", nowPageBlock);
	 * responseData.put("startPage", startPage); responseData.put("endPage",
	 * endPage);
	 * 
	 * return ResponseEntity.ok(responseData); }
	 * 
	 * // 공지사항 상세조회
	 * 
	 * @GetMapping("/notice/{noticeId}") public String
	 * getNoticeDetails(@PathVariable int noticeId, @PathVariable(required = false)
	 * Integer page, Principal principal, Model model) {
	 * 
	 * if (page == null) { page = 1; } Notices notice =
	 * noticeService.getNotice(noticeId);
	 * 
	 * model.addAttribute("notice", notice); model.addAttribute("page", page);
	 * 
	 * // Member member = this.memberService.getUser(principal.getName());
	 * 
	 * return "notice/view2"; }
	 * 
	 * // 공지사항 첨부파일 다운로드
	 * 
	 * @GetMapping("/download/files/{dirPath:.+}") public ResponseEntity<Resource>
	 * fileDownload(@PathVariable String dirPath) throws IOException { // Path
	 * fullPath = Paths.get("C:/upload/" + //
	 * dirPath.substring("/upload/".length())); String directoryPath =
	 * System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files\\";
	 * // 전체 파일 경로를 생성합니다. Path fullPath = Paths.get(directoryPath + dirPath);
	 * 
	 * Resource resource = new InputStreamResource(Files.newInputStream(fullPath));
	 * return ResponseEntity.ok().contentType(MediaType.parseMediaType(
	 * "application/octet-stream")).body(resource); }
	 * 
	 * // 공지사항 작성
	 * 
	 * @GetMapping(value = "/notice/write") public String writeNotice(HttpSession
	 * session, Principal principal) { // 관리자인지 확인 후 ,,,
	 * 
	 * // 관리자인 경우 // CSRF 토큰 생성 후 세션에 저장 // String csrfToken =
	 * UUID.randomUUID().toString(); // CSRF 토큰 생성 //
	 * session.setAttribute("csrfToken", csrfToken); // 세션에 저장 return
	 * "notice/write2"; }
	 * 
	 * // 공지사항 작성
	 * 
	 * @PostMapping(value = "/notice/write") public String writeNotice(Notices
	 * notice, BindingResult results, String csrfToken, MultipartFile file,
	 * HttpSession session, RedirectAttributes redirectAttrs) {
	 * 
	 * // String sessionToken = (String)session.getAttribute("csrfToken"); //
	 * if(csrfToken == null || csrfToken.equals(sessionToken)) { // throw new
	 * RuntimeException("CSRF Token Error"); // } try {
	 * notice.setContent(notice.getContent().replace("\r\n", "<br>"));
	 * notice.setTitle(Jsoup.clean(notice.getTitle(), Safelist.basic()));
	 * notice.setContent(Jsoup.clean(notice.getContent(), Safelist.basic()));
	 * 
	 * noticeService.insertNotice(notice, file);
	 * 
	 * } catch (Exception e) { e.printStackTrace();
	 * redirectAttrs.addFlashAttribute("message", e.getMessage()); } return
	 * "redirect:/notice/" + notice.getNoticeId(); }
	 * 
	 * // 공지사항 수정
	 * 
	 * @GetMapping(value = "/notice/update/{noticeId}") public String
	 * updateNotice(@PathVariable int noticeId, Model model) { Notices notice =
	 * noticeService.getNotice(noticeId);
	 * notice.setContent(notice.getContent().replaceAll("<br>", "\r\n"));
	 * model.addAttribute("notice", notice); return "notice/update"; }
	 * 
	 * // 공지사항 수정
	 * 
	 * @PostMapping(value = "/notice/update/{noticeId}") public String
	 * updateNotice(@PathVariable int noticeId, Notices notice, BindingResult
	 * results, String csrfToken, MultipartFile file, HttpSession session,
	 * RedirectAttributes redirectAttrs) {
	 * 
	 * // String sessionToken = (String)session.getAttribute("csrfToken"); //
	 * if(csrfToken == null || csrfToken.equals(sessionToken)) { // throw new
	 * RuntimeException("CSRF Token Error"); // }
	 * 
	 * try { notice.setContent(notice.getContent().replace("\r\n", "<br>"));
	 * notice.setTitle(Jsoup.clean(notice.getTitle(), Safelist.basic()));
	 * notice.setContent(Jsoup.clean(notice.getContent(), Safelist.basic()));
	 * 
	 * noticeService.updateNotice(noticeId, notice, file);
	 * 
	 * } catch (Exception e) { e.printStackTrace();
	 * redirectAttrs.addFlashAttribute("message", e.getMessage()); }
	 * 
	 * return "redirect:/notice/" + notice.getNoticeId(); }
	 * 
	 * // 공지사항 삭제
	 * 
	 * @GetMapping(value = "/notice/delete/{noticeId}") public String
	 * deleteNotice(@PathVariable int noticeId, Model model) {
	 * noticeService.deleteNotice(noticeId); return "redirect:/notice/list"; }
	 * 
	 * // tmp
	 * 
	 * @GetMapping(value = "/notice/tmp") public String tmpNotice() { return
	 * "notice/tmp"; }
	 * 
	 */
}
