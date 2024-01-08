package metanet.kosa.metanetfinal.bus.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Seats {
	private int seatId;
	private int busId;
	private String isRes;
}
