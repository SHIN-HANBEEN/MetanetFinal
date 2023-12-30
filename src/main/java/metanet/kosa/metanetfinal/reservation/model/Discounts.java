package metanet.kosa.metanetfinal.reservation.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Discounts {
	private int discountId;
	private String discountType;
	private float discountRate;
}
