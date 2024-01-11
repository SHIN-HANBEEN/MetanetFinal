package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ReservationInfo {
	
	private String payId;
	private Date resDate;
	private int[] seatId;
	private Date departureTime;
	private Date arrivalTime;
	private String departureName;
	private String arrivalName;
	private int adult;
	private int middleChild;
	private int child;
}
