package metanet.kosa.metanetfinal.reservation.service;

import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.bus.repository.IBusesRepository;
import metanet.kosa.metanetfinal.reservation.model.LockedBus;
@Service
public class SeatsLockSystemService {
	@Autowired
	IBusesRepository busesRepository;
	
	LinkedList<LockedBus> lockedBusQue = new LinkedList<>();
	
	@Scheduled(cron = "0 * * ? * *") //매 분 0초
	public void clearCache() {
		System.out.println("1분지남");
		LocalTime now = LocalTime.now();
		if(!lockedBusQue.isEmpty()) {
			boolean isTimeOut = isDifferenceGreaterThan10Minutes(now);
			while(isTimeOut) { //10분이상 차이가 난다면 버리고 반복
				LockedBus lockedBus = lockedBusQue.poll();
				//락 풀기 로직 ----
				unlockSeats(lockedBus);
				//------
				isTimeOut = isDifferenceGreaterThan10Minutes(now);
			}
		}
		System.out.println(now);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");
		
		System.out.println("현재시간:" + now.format(formatter) );
	}

	private boolean isDifferenceGreaterThan10Minutes(LocalTime now) {
		LockedBus peek = lockedBusQue.peek();
		LocalTime lockTime = peek.getLockTime();
		// 두 시간의 차이 계산
		Duration duration = Duration.between(now, lockTime);
		// 차이가 10분 이상인지 확인
		boolean isDifferenceGreaterThan10Minutes = duration.toMinutes() >= 10;
		return isDifferenceGreaterThan10Minutes;
	}
	
	private void unlockSeats(LockedBus lockedBus) {
		List<Integer> lockedSeatsList = lockedBus.getLockedSeats();
		int lockedBusId = lockedBus.getBusId();
		
	}
}
