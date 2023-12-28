package metanet.kosa.metanetfinal.member.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.model.ReservationSchedule;

@Service
public interface INonMemberService {
	
	/* 비회원 */
	// 비회원 정보 등록
	void registerNonMember(int nmbId, String phoNum);


}
