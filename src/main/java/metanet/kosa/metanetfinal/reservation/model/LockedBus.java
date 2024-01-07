package metanet.kosa.metanetfinal.reservation.model;

import java.time.LocalTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
@Getter
@AllArgsConstructor
public class LockedBus {
	private LocalTime lockTime;
	private int busId;
	private List<Integer> lockedSeats;
}
