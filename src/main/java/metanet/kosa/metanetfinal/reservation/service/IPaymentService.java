package metanet.kosa.metanetfinal.reservation.service;

import java.util.Map;

public interface IPaymentService {
	/*
	 * 결제하기
	 */
	void pay(int price);
	
	/*
	 * 취소하기
	 */
	void cancle(int payNum);
	/*
	 * 예매아이디로 출발터미널, 도착터미널 받아오기
	 */
	Map<String, String> getTerminals(int resId);
}
