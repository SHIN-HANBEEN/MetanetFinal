package metanet.kosa.metanetfinal.member.model;



import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
@Getter

public class NumberAuthentication {
	private String sixDigitRandomNumber;
	private LocalDateTime nowDate;
}
