package metanet.kosa.metanetfinal.notice;

import org.apache.ibatis.session.RowBounds;
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
	
	@Test
	public void getNoticebyNoticeId() {
		int noticeId = 3;
		System.out.println(
				noticeRepository
				.getNoticeByNoticeIdSearchWithPagination(noticeId, new RowBounds(0, 10)));
	}
	
	@Test
	public void getNoticebyNoticeTitle() {
		String title = "test";
		System.out.println(
				noticeRepository
				.getNoticeByNoticeTitleSearchWithPagination(title, new RowBounds(0, 10))
				
				);
	}
	
	@Test
	public void getNoticebyNoticeTitleOrNoticeId() {
		int noticeId = 3;
		String title = "test";
		System.out.println(
				noticeRepository
				.getNoticeByNoticeTitleOrNoticeIdSearchWithPagination(
						noticeId,
						title, 
						new RowBounds(0, 10))
				);
	}
}
