package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Builder
@Getter
@ToString
public class Reservations {
	private int resId;
	private int memberId;
	private String phoneNum;
	private String routeId;
	private int busId;
	private int seatId;
	private int discountId;
	private Date resDate;
	private String payId;
	private int totalPrice;
	private Date cancledDate;
}
