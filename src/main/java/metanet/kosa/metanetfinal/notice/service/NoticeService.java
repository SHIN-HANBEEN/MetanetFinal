package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.repository.INoticeRepository;

public class NoticeService implements INoticeService{
	
	@Autowired
	INoticeRepository noticeRepository;

	@Override
	public List<Notices> getNoticeList(int page) {
		/*
		 * 공지사항 리스트 조회
		 */
		int start = (page-1)*10 + 1;
		// 오라클은 BETWEEN a AND b에서 a,b 모두 포함하므로 9를 더해준다
		return noticeRepository.getNoticeList(start, start+9);
	}

	@Override
	public Notices getNotice(int noticeId) {
		/*
		 * 공지사항 상세 조회
		 */
		return noticeRepository.getNotice(noticeId);
	}

	@Override
	public int getTotalNoticeNum() {
		/*
		 * 공지사항 총 게시글 개수 구하기
		 */
		return noticeRepository.getTotalNoticeNum();
	}

	@Override
	public List<Notices> getNoticeSearchList(String keyword, int page) {
		/*
		 * 공지사항 검색 리스트 조회
		 */
		int start = (page-1)*10 + 1;
		return noticeRepository.getNoticeSearchList("%"+keyword+"%", start, start+9);
	}

	@Override
	public int getTotalNoticSearcheNum() {
		return noticeRepository.getTotalNoticSearcheNum();
	}
	
	
}
