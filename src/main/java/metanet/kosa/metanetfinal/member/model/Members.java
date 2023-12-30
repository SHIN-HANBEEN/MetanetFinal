package metanet.kosa.metanetfinal.member.model;

import java.sql.Date;

import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
@Getter
public class Members {
	
	private int memberId;
	
	@Pattern(regexp = "(?=.*[a-z])(?=.*[0-9])[a-z0-9]{10,30}", 
			message = "최소 1개 이상의 소문자 영어, 숫자를 이용한 10자~30자를 입력하세요.")
	private String id;
	
	@Pattern(regexp = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9])[a-zA-Z0-9!@#$%^&*()_+\\-=\\[\\]{};:'\"<>,./?]{10,20}",
			message = "최소 1개 이상의 소문자 영어, 대문자 영어, 특수문자, 숫자를 이용한 10자~20자를 입력하세요.")
	private String password;
	
	@Pattern(regexp = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}",
			message = "올바른 형식의 이메일 주소를 입력하세요.")
	private String email;
	
	private Date birthDate;
	
	@Pattern(regexp = "(MALE|FEMALE)",
			message = "MALE 혹은 FEMALE 정보를 넣어야 합니다.")
	private String sex;
	
	private String name;
	
	@Pattern(regexp = "01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}\r\n", 
			message = "010-xxxx-xxxx 형식으로 입력하세요")
	private String phoneNum;
	
	private String role;
	
	private int mileage;
}

