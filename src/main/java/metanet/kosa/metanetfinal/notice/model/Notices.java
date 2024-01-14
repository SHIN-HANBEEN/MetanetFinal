package metanet.kosa.metanetfinal.notice.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Builder
@Setter
@ToString
public class Notices {
	private int noticeId;
	private int memberId;
	private String title;
	private String content;
	private String fileName;
	private byte[] file;
	private MultipartFile multipartFile;
	private String isEmphasized;
}
