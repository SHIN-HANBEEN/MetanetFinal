package metanet.kosa.metanetfinal.reservation.model;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class DetailedReservation {
	private int resId; //예약번호
	private String isCnc; //취소 여부 (TRUE, FALSE 반환됨)
	private String depName; //출발지
	private String desName; //도착지
	private Date depTim; //출발시간
	private Date arrTim; //도착시간
	private Date resDte; //예약일
	private List<String> disNmeList; //할인명(성인, 아이, 보훈 등) 리스트
	private int satCot; //예매한 좌석 수
	private int totPri; //총가격
}
