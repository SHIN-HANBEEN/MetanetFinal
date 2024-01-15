package metanet.kosa.metanetfinal.member.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.coolsms.CoolSmsController;
import metanet.kosa.metanetfinal.coolsms.CoolSmsService;
import metanet.kosa.metanetfinal.coolsms.SmsCertificationDao;
import metanet.kosa.metanetfinal.member.model.UserDto;

@Service
public class PhoneNumCertificationService {
	@Autowired
	CoolSmsService smsService;
	//전화번호 인증을 위한 캐시<전화번호, 인증번호>
	//private Map<String, String> certification = new HashMap<>();
	@Autowired
	CoolSmsController smsUtil;
	@Autowired
	SmsCertificationDao smsCertificationDao;
	
	public String sendRandomNumber(String userPhoneNumber) {
		// Random 객체 생성
        Random random = new Random();
        // 100000 이상 999999 이하의 랜덤 정수 생성 6자리수
        int randomNumber = random.nextInt(900000) + 100000;
        // 생성된 랜덤 정수를 6자리 문자열로 변환
        String sixDigitRandomNumber = String.format("%06d", randomNumber);
        smsService.sendOne(userPhoneNumber,"메타버스 인증번호[" + sixDigitRandomNumber +"]");
        // certification.put(userPhoneNumber, sixDigitRandomNumber);
        
        // return sixDigitRandomNumber;
        return smsCertificationDao.createSmsCertification(userPhoneNumber, sixDigitRandomNumber);
	}
	
	/*
	public boolean AuthNumber(String userPhoneNumber, String userInputNumber) {
		//캐시에 있는 인증번호와 사용자가 입력한 인증번호가 같은지 확인
		String authNumber = certification.get(userPhoneNumber);
		return authNumber.equals(userInputNumber);
	}
	
	@Scheduled(cron = "0 0 1 * * ?") //매일 오전 1시에 실행
	public void clearCache() {
		certification.clear();
	}
	*/
	/*
	 * Redis이용한 검증
	 */
	public void verifySms(UserDto.SmsCertificationRequest requestDto) {
        if (isVerify(requestDto)) {
            throw new CustomExceptions.SmsCertificationNumberMismatchException("인증번호가 일치하지 않습니다.");
        }
        smsCertificationDao.removeSmsCertification(requestDto.getPhone());
    }

    public boolean isVerify(UserDto.SmsCertificationRequest requestDto) {
        return !(smsCertificationDao.hasKey(requestDto.getPhone()) &&
                smsCertificationDao.getSmsCertification(requestDto.getPhone())
                        .equals(requestDto.getCertificationNumber()));
    }

}
