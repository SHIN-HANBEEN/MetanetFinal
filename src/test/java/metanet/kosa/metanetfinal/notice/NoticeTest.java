package metanet.kosa.metanetfinal.notice;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.notice.repository.INoticeRepository;
import metanet.kosa.metanetfinal.notice.service.INoticeService;

@SpringBootTest
public class NoticeTest {
	@Autowired
	INoticeRepository noticeRepository;
	
	@Autowired
	INoticeService noticeService;
	
	@Test
	public void getNoticeTest() {
		int noticeId = 5;
		System.out.println(noticeRepository.readNoticeByNoticeId(noticeId));
	}
	
	
	@Test
	public void getNoticeFile() {
		int noticeId = 5;
		System.out.println(noticeRepository.getNoticeFile(noticeId));
	}
}
