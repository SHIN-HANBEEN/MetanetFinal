package metanet.kosa.metanetfinal.admin.model;

import java.sql.Date;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class TodayRoutes {
	private String seatIds;
    private String departureTerminalName;
    private String arrivalTerminalName;
    private String departureTime;
    private String arrivalTime;
}
