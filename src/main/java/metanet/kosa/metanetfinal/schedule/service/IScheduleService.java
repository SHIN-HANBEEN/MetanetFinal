package metanet.kosa.metanetfinal.schedule.service;

import java.sql.Date;

import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.schedule.model.Schedule;

@Service
public interface IScheduleService {
	// 편도 노선 조회
	Schedule[] getSchedule(int depId, int desId, Date depTim);
}
