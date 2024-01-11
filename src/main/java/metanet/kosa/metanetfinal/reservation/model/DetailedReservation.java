package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class DetailedReservation {
	private String seatIds;
    private String departureTerminalName;
    private String arrivalTerminalName;
    private Date departureTime;
    private Date arrivalTime;
    private Date resDate;
    private String payId;
    private int totalPrice;
}
