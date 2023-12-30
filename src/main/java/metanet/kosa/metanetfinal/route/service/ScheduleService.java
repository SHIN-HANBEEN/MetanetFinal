package metanet.kosa.metanetfinal.route.service;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.route.repository.IScheduleRepository;
import metanet.kosa.metanetfinal.schedule.model.Schedule;

public class ScheduleService implements IScheduleService{

	@Autowired
	IScheduleRepository scheduleRepository;
	
	// 노선 조회
	@Override
	public Schedule[] getSchedule(int depId, int desId, Date depTim) {
		return scheduleRepository.getSchedule(depId, desId, depTim);
	}

}
