package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.notice.model.Notice;
import metanet.kosa.metanetfinal.notice.repository.INoticeRepository;

public class NoticeService implements INoticeService{
	
	@Autowired
	INoticeRepository noticeRepository;

	@Override
	public List<Notice> getNoticeList() {
		/*
		 * 공지사항 리스트 조회
		 */
		return noticeRepository.getNoticeList();
	}

	@Override
	public Notice getNotice(int ntcId) {
		/*
		 * 공지사항 상세 조회
		 */
		return noticeRepository.getNotice(ntcId);
	}
	
	
}
