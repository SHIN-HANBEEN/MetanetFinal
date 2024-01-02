package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.notice.model.Notices;

public interface INoticeService {
	// 공지사항 리스트 조회
	List<Notices> getNoticeList(int page);
	// 공지사항 검색 리스트 조회
	List<Notices> getNoticeSearchList(String keyword, int page);
	// 공지사항 상세 조회
	Notices getNotice(int noticeId);
	// 공지사항 게시글 개수 조회
	int getTotalNoticeNum();
	// 공지사항 검색 게시글 총 개수 조회
	int getTotalNoticSearcheNum(String keyword);
}
