package metanet.kosa.metanetfinal.reservation.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.reservation.model.Reservation;

@Mapper
@Repository
public interface IReservationRepository {
	// 비회원 예매 리스트 조회
	List<Reservation> getReservation(int nmbId);
	// 비회원 예매 변경
	void changReservation(int resId, int schId);
	// 비회원 변경된 좌석 번호 가져오기
	int getChangedSeat(int resId, int schId);
	// 비회원 예매 취소
	void cancelReservation(int resId, int schId);
	
	// 배차 시간표에서 사용자가 선택한 버스 정보 조회
	HashMap<String, String> getBusInfo(int schId);
	// 매수 및 좌석 선택
	void selectSeat(int adult, int child, int special, int[] seats);
}
