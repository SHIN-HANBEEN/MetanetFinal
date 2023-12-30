package metanet.kosa.metanetfinal.bus.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class seats {
	private int busId;
	private String routeId;
	private String gradeName;
	private int seatCnt;
}
