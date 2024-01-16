package metanet.kosa.metanetfinal.notice.model;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class NoticeReadWithoutFile {
	private String name;
	private int noticeId;
	private String title;
	private String content;
	private String isEmphasized;
	private int offset; //현제 페이징 위치
}
