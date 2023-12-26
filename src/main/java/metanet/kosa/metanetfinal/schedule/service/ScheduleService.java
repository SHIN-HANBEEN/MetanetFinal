package metanet.kosa.metanetfinal.schedule.service;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;

import metanet.kosa.metanetfinal.schedule.model.Schedule;

public class ScheduleService implements IScheduleService{

	@Autowired

	
	// 노선 조회
	@Override
	public Schedule[] getSchedule(int depId, int desId, Date depTim) {
		// TODO Auto-generated method stub
		return null;
	}

}
