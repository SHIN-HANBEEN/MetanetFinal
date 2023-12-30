package metanet.kosa.metanetfinal.bus.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Buses {
	private int busId;
	private int routeId;
	private String gradeName;
	private int seatCnt;
}
