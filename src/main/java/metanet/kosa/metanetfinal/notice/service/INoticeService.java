package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.notice.model.Notice;

@Service
public interface INoticeService {
	// 공지사항 리스트 조회
	List<Notice> getNoticeList();
	// 공지사항 상세 조회
	Notice getNotice(int ntcId);
}
