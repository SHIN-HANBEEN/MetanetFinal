package metanet.kosa.metanetfinal.reservation;

import java.sql.Date;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.reservation.model.Reservations;
import metanet.kosa.metanetfinal.reservation.repository.IReservationRepository;

@SpringBootTest
public class ReservationTest {
	@Autowired
	IReservationRepository reservationRepository;
	
	@Test
	void selectReservationlistTest() {
		reservationRepository.getReservationHistoryForLastSixMonth("01052016412");
		
	}
	
	@Test
	void insertReservationDataTest() {
		
		Reservations reservation = 
				Reservations.builder()
							.resId(0)
							.memberId(0)
							.phoneNum("11111111")
							.routeId("80e83662-22a0-498b-bdf7-ac4c5fc86e7c")
							.busId(2)
							.seatId(4)
							.discountId(2)
							.resDate(new Date(System.currentTimeMillis()))
							.payId("payId123456")
							.totalPrice(48000)
							.cancledDate(null)
							.build();
		reservationRepository.insertReservationData(reservation);
	}
}
