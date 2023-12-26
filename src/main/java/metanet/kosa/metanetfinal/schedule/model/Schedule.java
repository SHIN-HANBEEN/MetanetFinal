package metanet.kosa.metanetfinal.schedule.model;

import java.sql.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Schedule {
	private int schId;
	private int lineId;
	private int busId;
	private Date deptTim;
	private Date arrTim;
	private int pri;
}