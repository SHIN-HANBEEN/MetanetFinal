package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reservations {
	private int resId;
	private int memberId;
	private int nmemberId;
	private String routeId;
	private int busId;
	private int seatId;
	private int discountId;
	private Date resDate;
	private String payId;
	private int totalPrice;
	private String isCancled;
	private Date cancledDate;
}
