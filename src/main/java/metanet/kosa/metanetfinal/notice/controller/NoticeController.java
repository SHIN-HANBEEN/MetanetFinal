package metanet.kosa.metanetfinal.notice.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.service.INoticeService;

@Controller
public class NoticeController {
	
	/*
	 * 전체적으로 memberId 설정 수정 필요
	 */
	
	@Autowired
	INoticeService noticeService;
	
	// 공지사항 리스트 조회
	@GetMapping(value= "/notice/list/{page}")
	public String getNoticeList(@PathVariable(required=false) Integer page, HttpSession session, Model model) {
		if(page == null) {
			page = 1;
		}
		
		session.setAttribute("page", page);
		List<Notices> noticeList = noticeService.getNoticeList(page);
		model.addAttribute("noticeList", noticeList);
		
		
		int bbsCount = noticeService.getTotalNoticeNum();
		int totalPage = 0;
		if(bbsCount > 0) {
			totalPage = (int)Math.ceil(bbsCount/10.0);
		}
		int totalPageBlock = (int)(Math.ceil(totalPage/10.0));
		int nowPageBlock = (int)Math.ceil(page/10.0);
		int startPage = (nowPageBlock-1) * 10 + 1;
		int endPage = 0;
		if(totalPage > nowPageBlock * 10) {
			endPage = nowPageBlock * 10;
		} else {
			endPage = totalPage;
		}
		model.addAttribute("totalPageCount", totalPage);
		model.addAttribute("nowPage", page);
		model.addAttribute("totalPageBlock", totalPageBlock);
		model.addAttribute("nowPageBlock", nowPageBlock);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		return "notice/list2";
	}
	
	@GetMapping(value= "notice/list")
	public String getNoticeList(HttpSession session, Model model) {
		return getNoticeList(1, session, model);
	}
	
	
	// 공지사항 검색 리스트 조회
	@GetMapping("/notice/search/{page}")
	@ResponseBody
	public ResponseEntity<?> getNoticeSearchList(@RequestParam(required=false, defaultValue="") String keyword, 
				@PathVariable(required=false) Integer page, HttpSession session, Model model) {
		
		if(page == null) {
			page = 1;
		}

		List<Notices> noticeList = noticeService.getNoticeSearchList(keyword, page);
		model.addAttribute("noticeList", noticeList);
		
		int bbsCount = noticeService.getTotalNoticSearcheNum(keyword);
		int totalPage = 0;
		if(bbsCount > 0) {
			totalPage= (int)Math.ceil(bbsCount/10.0);
		}
		int totalPageBlock = (int)(Math.ceil(totalPage/10.0));
		int nowPageBlock = (int) Math.ceil(page/10.0);
		int startPage = (nowPageBlock-1)*10 + 1;
		int endPage = 0;
		if(totalPage > nowPageBlock*10) {
			endPage = nowPageBlock*10;
		}else {
			endPage = totalPage;
		}
		
		Map<String, Object> responseData = new HashMap<>();
		responseData.put("noticeList", noticeList);
		responseData.put("keyword", keyword);
		responseData.put("totalPageCount", totalPage);
		responseData.put("nowPage", page);
		responseData.put("totalPageBlock", totalPageBlock);
		responseData.put("nowPageBlock", nowPageBlock);
		responseData.put("startPage", startPage);
		responseData.put("endPage", endPage);

	return ResponseEntity.ok(responseData);
	}
	
	// 공지사항 상세조회
	@GetMapping("/notice/{noticeId}")
	public String getNoticeDetails(@PathVariable int noticeId, @PathVariable(required=false) Integer page, Principal principal, Model model) {
		
		if(page == null) {
			page = 1;
		}
		Notices notice = noticeService.getNotice(noticeId);
		
		model.addAttribute("notice", notice);
		model.addAttribute("page", page);
		
		// Member member = this.memberService.getUser(principal.getName());
		
		return "notice/view2";
	}
	
	
	// 공지사항 첨부파일 다운로드
	@GetMapping("/download/files/{dirPath:.+}")
	public ResponseEntity<Resource> fileDownload(@PathVariable String dirPath) throws IOException {
	    // Path fullPath = Paths.get("C:/upload/" + dirPath.substring("/upload/".length()));
	    String directoryPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files\\";
	 // 전체 파일 경로를 생성합니다.
	    Path fullPath = Paths.get(directoryPath + dirPath);
	    
	    Resource resource = new InputStreamResource(Files.newInputStream(fullPath));
	    return ResponseEntity.ok()
	            .contentType(MediaType.parseMediaType("application/octet-stream"))
	            .body(resource);
	}
	
	// 공지사항 작성
	@GetMapping(value="/notice/write")
	public String writeNotice(HttpSession session, Principal principal) {
		// 관리자인지 확인 후 ,,,
		
		// 관리자인 경우
		// CSRF 토큰 생성 후 세션에 저장
//		String csrfToken = UUID.randomUUID().toString(); // CSRF 토큰 생성
//		session.setAttribute("csrfToken", csrfToken); // 세션에 저장
		return "notice/write";
	}
	
	// 공지사항 작성
	@PostMapping(value="/notice/write")
	public String writeNotice(Notices notice, BindingResult results, String csrfToken, MultipartFile file,
			HttpSession session, RedirectAttributes redirectAttrs) {
		
//		String sessionToken = (String)session.getAttribute("csrfToken");
//		if(csrfToken == null || csrfToken.equals(sessionToken)) {
//			throw new RuntimeException("CSRF Token Error");
//		}
		try {
			notice.setContent(notice.getContent().replace("\r\n", "<br>"));
			notice.setTitle(Jsoup.clean(notice.getTitle(), Safelist.basic()));
			notice.setContent(Jsoup.clean(notice.getContent(), Safelist.basic()));
			
			noticeService.insertNotice(notice, file);

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttrs.addFlashAttribute("message", e.getMessage());
		}
		return "redirect:/notice/"+notice.getNoticeId();
	}
	
	
	// 공지사항 수정
	@GetMapping(value="/notice/update/{noticeId}")
	public String updateNotice(@PathVariable int noticeId, Model model) {
		Notices notice = noticeService.getNotice(noticeId);
		notice.setContent(notice.getContent().replaceAll("<br>", "\r\n"));
		model.addAttribute("notice", notice);
		return "notice/update";
	}
	
	
	// 공지사항 수정
	@PostMapping(value="/notice/update/{noticeId}")
	public String updateNotice(@PathVariable int noticeId, Notices notice, BindingResult results, 
			String csrfToken, MultipartFile file, HttpSession session, RedirectAttributes redirectAttrs) {
		
//		String sessionToken = (String)session.getAttribute("csrfToken");
//		if(csrfToken == null || csrfToken.equals(sessionToken)) {
//			throw new RuntimeException("CSRF Token Error");
//		}
		
		try {
			notice.setContent(notice.getContent().replace("\r\n", "<br>"));
			notice.setTitle(Jsoup.clean(notice.getTitle(), Safelist.basic()));
			notice.setContent(Jsoup.clean(notice.getContent(), Safelist.basic()));
			
			noticeService.updateNotice(noticeId, notice, file);

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttrs.addFlashAttribute("message", e.getMessage());
		}
		
		return "redirect:/notice/"+notice.getNoticeId();
	}
	
	// 공지사항 삭제
	@GetMapping(value="/notice/delete/{noticeId}")
	public String deleteNotice(@PathVariable int noticeId, Model model) {
		noticeService.deleteNotice(noticeId);
		return "redirect:/notice/list";
	}
	
	// tmp
	@GetMapping(value="/notice/tmp")
	public String tmpNotice() {
		return "notice/tmp";
	}
	

	
}
