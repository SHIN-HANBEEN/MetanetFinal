package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reservation {
	private int resId;
	private int memId;
	private String isMem;
	private Date resDte;
	private int payNum;
	private int totPri;
	private String isCnc;
}
