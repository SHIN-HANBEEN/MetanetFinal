package metanet.kosa.metanetfinal.member.service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.coolsms.CoolSmsService;
import metanet.kosa.metanetfinal.member.model.NumberAuthentication;

@Service
public class PhoneNumCertificationService {
	@Autowired
	CoolSmsService smsService;
	//전화번호 인증을 위한 캐시<전화번호, 인증번호>
	private Map<String, NumberAuthentication> certification = new HashMap<>();
	
	public String sendRandomNumber(String userPhoneNumber) {
		// Random 객체 생성
        Random random = new Random();
        // 100000 이상 999999 이하의 랜덤 정수 생성 6자리수
        int randomNumber = random.nextInt(900000) + 100000;
        // 생성된 랜덤 정수를 6자리 문자열로 변환
        String sixDigitRandomNumber = String.format("%06d", randomNumber);
        
        // NumberAuthentication 객체 생성 및 생성한 6자리 문자열과 현재 날짜를 입력
        NumberAuthentication numberAuthentication = new NumberAuthentication();
        numberAuthentication.setSixDigitRandomNumber(sixDigitRandomNumber);
        numberAuthentication.setNowDate(LocalDateTime.now());
        
        System.out.println(sixDigitRandomNumber);
        //핸드폰 번호로 인증 번호 전송
        //smsService.sendOne(userPhoneNumber,"메타버스 인증번호[" + sixDigitRandomNumber +"]");
        
        //인증 Map에 핸드폰 번호와 [인증번호,현재 날짜] 저장
        certification.put(userPhoneNumber, numberAuthentication);
        System.out.println(certification);
        return sixDigitRandomNumber;
	}
	
	public boolean AuthNumber(String userPhoneNumber, String userInputNumber) {
		
		//캐시에 있는 인증번호와 사용자가 입력한 인증번호가 같은지 확인
		NumberAuthentication authdata = certification.get(userPhoneNumber);
		
		LocalDateTime localdate = authdata.getNowDate();
		LocalDateTime currentdate = LocalDateTime.now();
		
		Duration duration = Duration.between(localdate, currentdate);
		if(authdata.getSixDigitRandomNumber().equals(userInputNumber) 
				&& duration.toMinutes() <= 2) {
			
			//삭제할 키 설정
			String keyToRemove = userPhoneNumber;
			
			certification.remove(keyToRemove);
			return true;
		}
		return false;
	}
	
	@Scheduled(cron = "0 0 1 * * ?") //매일 오전 1시에 실행
	public void clearCache() {
		certification.clear();
	}
}
