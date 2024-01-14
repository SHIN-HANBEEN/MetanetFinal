package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import metanet.kosa.metanetfinal.notice.model.Notices;

public interface INoticeService {
	// 공지사항 글 작성
	void insertNoticeWithFile(Notices notices, String memberId);
	void insertNoticeWithoutFile(Notices notices, String memberId);
	
	
//	// 공지사항 상세 조회
//	Notices getNotice(int noticeId);
//	// 공지사항 리스트 조회
//	List<Notices> getNoticeList(int page);
//	// 공지사항 검색 리스트 조회
//	List<Notices> getNoticeSearchList(String keyword, int page);
//	// 공지사항 게시글 개수 조회
//	int getTotalNoticeNum();
//	// 공지사항 검색 게시글 총 개수 조회
//	int getTotalNoticSearcheNum(String keyword);
//	// 공지사항 글 삭제
//	void deleteNotice(int noticeId);
//	// 공지사항 글 수정
//	void updateNotice(int noticeId, Notices notice, MultipartFile file);
}
