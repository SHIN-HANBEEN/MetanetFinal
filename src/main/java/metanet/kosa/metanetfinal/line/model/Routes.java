package metanet.kosa.metanetfinal.line.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Routes {
	private String routeId;
	private String departureId;
	private String arrivalId;
	private Date departureTime;
	private Date arrivalTime;
	private int price;
}
