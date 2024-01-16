package metanet.kosa.metanetfinal.notice.controller;

import java.util.List;

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
		RowBounds rowBounds = new RowBounds(offset, 10);
		return noticeService.getNoticesWithPagination(rowBounds);
	}
	
	@GetMapping("/notice/viplist")
	public List<NoticeListHome> getVipNoticeList() {
		return noticeService.getVipNotice();
	}

}
