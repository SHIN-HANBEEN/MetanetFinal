package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.repository.INoticeRepository;

public class NoticeService implements INoticeService{
	
	@Autowired
	INoticeRepository noticeRepository;

	@Override
	public List<Notices> getNoticeList() {
		/*
		 * 공지사항 리스트 조회
		 */
		return noticeRepository.getNoticeList();
	}

	@Override
	public Notices getNotice(int ntcId) {
		/*
		 * 공지사항 상세 조회
		 */
		return noticeRepository.getNotice(ntcId);
	}
	
	
}
