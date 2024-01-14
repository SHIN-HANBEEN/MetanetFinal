package metanet.kosa.metanetfinal.notice.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeRead {
	private String id;
	private int noticeId;
	private String title;
	private String content;
	private String fileName;
	private byte[] fileData;
	private String isEmphasized;
}
