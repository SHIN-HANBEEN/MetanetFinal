package metanet.kosa.metanetfinal.notice.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
@Setter
public class NoticeFile {
	private String fileName;
	private byte[] fileData;
}
