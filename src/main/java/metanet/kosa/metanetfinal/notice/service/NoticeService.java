package metanet.kosa.metanetfinal.notice.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import metanet.kosa.metanetfinal.notice.model.NoticeFile;
import metanet.kosa.metanetfinal.notice.model.NoticeListHome;
import metanet.kosa.metanetfinal.notice.model.NoticeRead;
import metanet.kosa.metanetfinal.notice.model.Notices;
import metanet.kosa.metanetfinal.notice.model.NoticesForDbUpload;
import metanet.kosa.metanetfinal.notice.repository.INoticeRepository;

@Service
public class NoticeService implements INoticeService {

	@Autowired
	INoticeRepository noticeRepository;

	// 공지사항 작성
	@Transactional
	@Override
	public void insertNoticeWithFile(
			@Param("notices") Notices notices, 
			@Param("memberId") int memberId) {
		System.out.println("공지 파일과 함께 넣기 서비스 실행");
		System.out.println("리포지토리 실행 전 notices 확인해보기 : " + notices);
		noticeRepository.insertNoticeWithFile(notices, memberId);
	}

	// 공지사항 작성
	@Transactional
	@Override
	public void insertNoticeWithoutFile(Notices notices, int memberId) {
		noticeRepository.insertNoticeWithoutFile(notices, memberId);
	}

	@Override
	public List<NoticeListHome> getNoticesWithPagination(RowBounds rowBounds) {
		return noticeRepository.getNoticesWithPagination(rowBounds);
	}

	@Override
	public NoticeRead noticeRead(int noticeId) {
		return noticeRepository.readNoticeByNoticeId(noticeId);
	}

	@Override
	public NoticeFile getNoticeFile(int noticeId) {
		return noticeRepository.getNoticeFile(noticeId);
	}

	
	
	
	

//	
//	@Override
//	public List<Notices> getNoticeList(int page) {
//		/*
//		 * 공지사항 리스트 조회
//		 */
//		int start = (page-1)*10 + 1;
//		// 오라클은 BETWEEN a AND b에서 a,b 모두 포함하므로 9를 더해준다
//		return noticeRepository.getNoticeList(start, start+9);
//	}
//
//	@Override
//	public Notices getNotice(int noticeId) {
//		/*
//		 * 공지사항 상세 조회
//		 */
//		return noticeRepository.getNotice(noticeId);
//	}
//
//	@Override
//	public int getTotalNoticeNum() {
//		/*
//		 * 공지사항 총 게시글 개수 구하기
//		 */
//		return noticeRepository.getTotalNoticeNum();
//	}
//
//	@Override
//	public List<Notices> getNoticeSearchList(String keyword, int page) {
//		/*
//		 * 공지사항 검색 리스트 조회
//		 */
//		int start = (page-1)*10 + 1;
//		// System.out.println("서비스 " + keyword+ " " + start);
//		return noticeRepository.getNoticeSearchList("%"+keyword+"%", start, start+9);
//	
//	}
//
//	@Override
//	public int getTotalNoticSearcheNum(String keyword) {
//		return noticeRepository.getTotalNoticSearcheNum(keyword);
//	}
//
//
//	@Override
//	public void deleteNotice(int noticeId) {
//		noticeRepository.deleteNotice(noticeId);
//	}
//
//	@Override
//	public void updateNotice(int noticeId, Notices notice, MultipartFile file) {
//		
//		// 저장할 경로 지정 
//		String directoryPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files\\";
//	    if (!new File(directoryPath).exists()) {
//	        new File(directoryPath).mkdirs();
//	    }
//
//	    // 식별자 생성 및 파일 경로 설정
//	    UUID uuid = UUID.randomUUID();
//	    String fileName = uuid.toString() + "_" + file.getOriginalFilename();
//	    String filePath = directoryPath + fileName;
//	    File saveFile = new File(directoryPath, fileName);
//
//	    try {
//			file.transferTo(saveFile);
//		} catch (IllegalStateException | IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//
//	    // 파일 URL 저장 (예: /files/uuid_filename)
//	    // notice.setDirPath(filePath);
//	    notice.setDirPath("/files/" + fileName);
//		noticeRepository.updateNotice(noticeId, notice);
//		
//	}
//	
//	
//

}