package metanet.kosa.metanetfinal.notice.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
@Setter
public class NoticeListHome {
	//N.NOTICE_ID, N.TITLE, M.NAME
	private int noticeId;
	private String title;
	private String name;
}
