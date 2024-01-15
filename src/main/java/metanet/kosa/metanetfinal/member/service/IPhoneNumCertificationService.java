package metanet.kosa.metanetfinal.member.service;

import metanet.kosa.metanetfinal.member.model.UserDto;

public interface IPhoneNumCertificationService {
	String sendRandomNumber(String userPhoneNumber);
	void verifySms(UserDto.SmsCertificationRequest requestDto);
	boolean isVerify(UserDto.SmsCertificationRequest requestDto);
}
