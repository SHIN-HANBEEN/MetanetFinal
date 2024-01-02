package metanet.kosa.metanetfinal.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.service.INoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	INoticeService noticeService;
	
	// 공지사항 리스트 조회
	@GetMapping("/notice/list/{page}")
	public String getNoticeList(@PathVariable int page, HttpSession session, Model model) {
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
		
		return "notice/list";
	}
	
	// 공지사항 검색 리스트 조회
	@GetMapping("/notice/search/{page}")
	public String getNoticeSearchList(@RequestParam(required=false, defaultValue="") String keyword, 
				@PathVariable int page, HttpSession session, Model model) {
		System.out.println("controller 서비스 전 " + keyword);
		List<Notices> noticeList = noticeService.getNoticeSearchList(keyword, page);
		model.addAttribute("noticeList", noticeList);
		System.out.println("controller 서비스 후");
		
		int bbsCount = noticeService.getTotalNoticSearcheNum(keyword);
		System.out.println(bbsCount);
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
		model.addAttribute("keyword", keyword);
		model.addAttribute("totalPageCount", totalPage);
		model.addAttribute("nowPage", page);
		model.addAttribute("totalPageBlock", totalPageBlock);
		model.addAttribute("nowPageBlock", nowPageBlock);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

	return "notice/search";
	}
	
	// 공지사항 상세조회
	@GetMapping("/notice/{noticeId}/{page}")
	public String getNoticeDetails(@PathVariable int noticeId, @PathVariable int page, Model model) {
		Notices notice = noticeService.getNotice(noticeId);
		
		model.addAttribute("notice", notice);
		model.addAttribute("page", page);
		
		return "notice/view";
	}
	
	
}
