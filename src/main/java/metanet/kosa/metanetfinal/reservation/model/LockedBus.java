package metanet.kosa.metanetfinal.reservation.model;

import java.time.LocalTime;
import java.util.List;

import lombok.Getter;
@Getter
public class LockedBus {
	private LocalTime lockTime;
	private int busId;
	private List<Integer> lockedSeats;
}
