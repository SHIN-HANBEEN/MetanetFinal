package metanet.kosa.metanetfinal.member.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
@Getter
public class Member {
	private int memId;
	private String id;
	private String pwd;
	private String ema;
	private Date birDte;
	private String sex;
	private String nme;
	private String phoNum;
	private String rol;
	private int mlg;
}
