package metanet.kosa.metanetfinal.reservation.service;

import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import metanet.kosa.metanetfinal.bus.repository.IBusesRepository;
import metanet.kosa.metanetfinal.reservation.model.LockedBus;
@Slf4j
@Service
public class SeatsLockSystemService {
	@Autowired
	IBusesRepository busesRepository;
	
	LinkedList<LockedBus> lockedBusQue = new LinkedList<>();

	public static final int lockingTime = 10;

	@Scheduled(cron = "0 * * ? * *") //매 분 0초
	public void checkExpiredSeatTime() {
		//현재 시간 now
		LocalTime now = LocalTime.now();
		
		//Queue에 데이터가 있을 때
		if(!lockedBusQue.isEmpty()) {
			log.info("큐활성화");
			// Queue.peek를 통해 현재시간과 비교
			boolean isTimeOut = isDifferenceGreaterThan10Minutes(now);
			//10분이상 차이가 난다면 락을 풀고 해당과정을 반복
			while(isTimeOut) { 
				LockedBus lockedBus = lockedBusQue.poll();
				//락 풀기 로직 ----
				unlockSeats(lockedBus);
				//------
				isTimeOut = isDifferenceGreaterThan10Minutes(now);
			}
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HHmm");
	}
	
	/*
	 * 좌석상태를 예매완료상태로 변경
	 */
	@Transactional
	public void seatsLocking10m(int busId, List<Integer> selectedSeatList) {
		LocalTime now = LocalTime.now(); 
		//DB에 is_res 상태를 TRUE로 변경
		for (Integer selectedSeat : selectedSeatList) {
			busesRepository.setBusSeatTrue(busId, selectedSeat.intValue());
		}
		//시간, 버스아이디, 선택된 좌석으로 새로운 객체를 생성해서 큐에 저장
		LockedBus lockedBus = new LockedBus(now, busId, selectedSeatList);
		lockedBusQue.add(lockedBus);
	}
	
	/*
	 * 결제가 온전히 완료되었을 때
	 * Queue 에 들어있는 객체를 지워버림으로써 예매완료상태가 변하지 않게함
	 */
	public void paymentCompleteProcess(int busId, List<Integer> selectedSeatList) {
		
		for (int i = 0; i < lockedBusQue.size(); i++) { // O(n)
			LockedBus lockedBus = lockedBusQue.get(i);
			if(lockedBus.getBusId() == busId && selectedSeatList.equals(lockedBus.getLockedSeats())) {
				lockedBusQue.remove(i);
				break;
			}
		}
	}
	
	/*
	 * 10분이상 차이가 나는지 확인하는 메서드
	 */
	@Transactional
	private boolean isDifferenceGreaterThan10Minutes(LocalTime now) {
		if(lockedBusQue.isEmpty()) return false;
		LockedBus peek = lockedBusQue.peek();
		LocalTime lockTime = peek.getLockTime();
		// 두 시간의 차이 계산
		Duration duration = Duration.between(lockTime, now);
		// 차이가 10분 이상인지 확인
		boolean isDifferenceGreaterThan10Minutes = duration.toMinutes() >= lockingTime;
		return isDifferenceGreaterThan10Minutes;
	}
	
	/*
	 * 좌석상태를 FALSE로 변경하는 메서드
	 */
	private void unlockSeats(LockedBus lockedBus) {
		List<Integer> lockedSeatsList = lockedBus.getLockedSeats();
		int lockedBusId = lockedBus.getBusId();
		for (Integer lockedSeatId : lockedSeatsList) {
			busesRepository.setBusSeatFalse(lockedBusId, lockedSeatId.intValue());
		}
	}
}
