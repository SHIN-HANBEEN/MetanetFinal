package metanet.kosa.metanetfinal.member.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.member.repository.INonMemberRepository;
import metanet.kosa.metanetfinal.reservation.model.Reservation;
import metanet.kosa.metanetfinal.reservation.model.ReservationSchedule;

public class NonMemberService implements INonMemberService {

	@Autowired
	INonMemberRepository memberRepository;

	
	/* 비회원 */
	// 비회원 등록
	@Override
	public void registerNonMember(int nmbId, String phoNum) {
		/*
		 * 비회원 정보 등록
		 */
		memberRepository.registerNonMember(nmbId, phoNum);
	}
	
	

	
	

}
