package metanet.kosa.metanetfinal.reservation.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationSchedule {
	private int resId;
	private int schId;
	private int satNum;
	private int disId;
	private int disPri;
}
