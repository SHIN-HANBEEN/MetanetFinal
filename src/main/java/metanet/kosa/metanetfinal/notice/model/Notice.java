package metanet.kosa.metanetfinal.notice.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Builder
@Setter
@ToString
public class Notice {
	private int ntcId;
	private int memId;
	private String tit;
	private String cnt;
	private String dirPath;
}
