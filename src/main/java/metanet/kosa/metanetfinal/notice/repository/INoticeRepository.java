package metanet.kosa.metanetfinal.notice.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.notice.model.NoticeFile;
import metanet.kosa.metanetfinal.notice.model.NoticeListHome;
import metanet.kosa.metanetfinal.notice.model.NoticeRead;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.model.NoticesForDbUpload;

@Mapper
@Repository
public interface INoticeRepository {
	// 공지사항 글 작성
	void insertNoticeWithFile(@Param("notices") Notices notices, @Param("memberId") int memberId);
	void insertNoticeWithoutFile(@Param("notices") Notices notices, @Param("memberId") int memberId);
	
	//10개 노티스 가져오기 
	List<NoticeListHome> getNoticesWithPagination(RowBounds rowBounds);
	
	//getVipNotice : 중요 공지 가져오기
	List<NoticeListHome> getVipNotice();
	
	//공지글 읽기
	NoticeRead readNoticeByNoticeId(@Param("noticeId") int noticeId);
	
	//파일 다운로드
	NoticeFile getNoticeFile(@Param("noticeId") int noticeId);
	
	//공지번호 검색 후 노티스 가져오기
	List<NoticeListHome> getNoticeByNoticeIdSearchWithPagination(
				@Param("noticeId") int noticeId,
				RowBounds rowBounds
			);
	
	//공지 제목 검색 후 노티스 가져오기
	List<NoticeListHome> getNoticeByNoticeTitleSearchWithPagination(
				@Param("title") String title,
				RowBounds rowBounds
			);
	
	
	//공지번호 + 공지제목 검색 후 노티스 가져오기
	List<NoticeListHome> getNoticeByNoticeTitleOrNoticeIdSearchWithPagination(
				@Param("noticeId") int noticeId,
				@Param("title") String title,
				RowBounds rowBounds
			);
	
	
	
	
	
	
	
	
	
	
//	// 공지사항 리스트 조회
//	List<Notices> getNoticeList(@Param("start")int start, @Param("end") int end);
//	// 공지사항 검색 리스트 조회
//	List<Notices> getNoticeSearchList(@Param("keyword") String keyword, @Param("start") int start, @Param("end")int end);
//	// 공지사항 상세 조회
//	Notices getNotice(int noticeId);
//	// 공지사항 총 게시글 갯수 조회
//	int getTotalNoticeNum();
//	// 공지사항 게시글 아이디 최댓값 조회
//	int getMaxNoticeId();
//	// 공지사항 검색 총 게시글 갯수 조회
//	int getTotalNoticSearcheNum(@Param("keyword") String keyword);
//	// 공지사항 글 삭제
//	void deleteNotice(int noticeId);
//	// 공지사항 글 수정
//	void updateNotice(@Param("noticeId")int noticeId, @Param("notice") Notices notice);
}
