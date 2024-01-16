package metanet.kosa.metanetfinal.notice.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import metanet.kosa.metanetfinal.notice.model.NoticeListHome;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.service.INoticeService;


@RestController
public class NoticeRestController {
	
	@Autowired
	INoticeService noticeService;
	
	@GetMapping("/notice/list")
	public List<NoticeListHome> getNoticeList(@RequestParam int offset) {
		RowBounds rowBounds = new RowBounds(offset, 10); //offset 을 받아서 10개 단위로 가져온다.
		return noticeService.getNoticesWithPagination(rowBounds);
	}
	
	@GetMapping("/notice/viplist")
	public List<NoticeListHome> getVipNoticeList() {
		return noticeService.getVipNotice();
	}
	
	
	
	
	//공지번호 검색 후 노티스 가져오기
	@GetMapping("/notice/search/noticeid")
	public List<NoticeListHome> getNoticeSearchByNoticeId(
			@RequestParam int noticeid, 
			@RequestParam int offset
			) {
		RowBounds rowBounds = new RowBounds(offset, 100);
		System.out.println("공지번호로 검색 완료 : " + 
		noticeService.getNoticeByNoticeIdSearchWithPagination(noticeid, rowBounds));
		return noticeService.getNoticeByNoticeIdSearchWithPagination(noticeid, rowBounds);
	}
	
	
	//공지 제목 검색 후 노티스 가져오기
	@GetMapping("/notice/search/noticetitle")
	public List<NoticeListHome> getNoticeByNoticeTitleSearchWithPagination(
			@RequestParam String title, 
			@RequestParam int offset
			) {
		RowBounds rowBounds = new RowBounds(offset, 100);
		System.out.println(
				noticeService.getNoticeByNoticeTitleSearchWithPagination(title, rowBounds)
				);
		return noticeService.getNoticeByNoticeTitleSearchWithPagination(title, rowBounds);
	}
	
	
	//공지번호 + 공지제목 검색 후 노티스 가져오기
	@GetMapping("/notice/search/noticetitleornoticeid")
	public List<NoticeListHome> getNoticeByNoticeTitleOrNoticeIdSearchWithPagination(
	        @RequestParam String title,
	        @RequestParam(required = false) Integer noticeid,
	        @RequestParam int offset
	) {
	    RowBounds rowBounds = new RowBounds(offset, 100);
	    if (noticeid != null) {
	        return noticeService.getNoticeByNoticeTitleOrNoticeIdSearchWithPagination(noticeid, title, rowBounds);
	    } else { //noticeid 가 숫자가 아니라 문자로 들어오면 null 로 들어온다.
	        return noticeService.getNoticeByNoticeTitleSearchWithPagination(title, rowBounds);
	    }
	}

	
	//int getAllNoticeCount()
	@GetMapping("/notice/count")
	public int getAllNoticeCount() {
		int result = (int)Math.round(noticeService.getAllNoticeCount()/10) + 1;
		System.out.println(
				"전체 공지 개수/10 : " + result 
				);
		return result;
	}

}
