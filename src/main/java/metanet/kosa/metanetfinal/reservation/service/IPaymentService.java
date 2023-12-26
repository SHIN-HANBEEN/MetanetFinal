package metanet.kosa.metanetfinal.reservation.service;

public interface IPaymentService {
	/*
	 * 결제하기
	 */
	void pay(int price);
	
	/*
	 * 취소하기
	 */
	void cancle(int payNum);
}
