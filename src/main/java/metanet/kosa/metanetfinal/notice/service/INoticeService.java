package metanet.kosa.metanetfinal.notice.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.web.multipart.MultipartFile;

import metanet.kosa.metanetfinal.notice.model.NoticeFile;
import metanet.kosa.metanetfinal.notice.model.NoticeListHome;
import metanet.kosa.metanetfinal.notice.model.NoticeRead;
import metanet.kosa.metanetfinal.notice.model.Notices;

public interface INoticeService {
	// 공지사항 글 작성
	void insertNoticeWithFile(Notices notices, int memberId);
	void insertNoticeWithoutFile(Notices notices, int memberId);
	
	//공지사항 10개 씩 가져오기 
	List<NoticeListHome> getNoticesWithPagination(RowBounds rowBounds);
	
	//공지사항 읽어오기
	NoticeRead noticeRead(int noticeId);
	
	//파일 다운로드
	NoticeFile getNoticeFile(int noticeId);
	
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
