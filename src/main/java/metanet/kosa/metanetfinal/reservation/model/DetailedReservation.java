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
    private String departureTime;
    private String arrivalTime;
    private String resDate;
    private String payId;
    private int totalPrice;
    private String departureTerminalId;
    private String arrivalTerminalId;
}
