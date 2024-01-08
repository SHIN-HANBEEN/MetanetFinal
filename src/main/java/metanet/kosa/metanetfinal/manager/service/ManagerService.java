package metanet.kosa.metanetfinal.manager.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import metanet.kosa.metanetfinal.manager.repository.IManagerRepository;
import metanet.kosa.metanetfinal.notice.model.Notices;


@Service
public class ManagerService implements IManagerService {
	
	@Autowired
	IManagerRepository managerRepository;
	
	/**
	 * 배차번호를 기준으로 예약한 사용자들에게 알림을 보냄
	 * TODO
	 * 1. 예매-배차 테이블에서 배차번호를 기준으로 예매번호들을 조회
	 * 2. 예매테이블에서 예매번호들을 기준으로 회원번호와 비회원번호를 조회
	 * 3. 비회원과 회원테이블에서 전화번호를 조회
	 */
//	@Override
//	public void AlarmForModifiedEvent(int schId, String alarmInfo) {
//		
//
//	}
	/*
	 * 공지글에 글을 등록
	 */
//	@Override
//	public void insertBoard(Notices notice) {
//		managerRepository.insertBoard(notice);
//
//	}
//	/*
//	 * 공지글을 수정
//	 */
//	@Override
//	public void updateBoard(Notices notice) {
//		managerRepository.updateBoard(notice);
//
//	}
//	/*
//	 * 공지글 삭제
//	 */
//	@Override
//	public void deleteBoard(int ntcId) {
//		// TODO Auto-generated method stub
//		managerRepository.deleteBoard(ntcId);
//	}

}
