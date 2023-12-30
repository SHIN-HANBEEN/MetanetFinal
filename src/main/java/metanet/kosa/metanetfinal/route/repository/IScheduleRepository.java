package metanet.kosa.metanetfinal.route.repository;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.schedule.model.Schedule;

@Mapper
@Repository
public interface IScheduleRepository {
	// 노선 조회
	Schedule[] getSchedule(int depId, int desId, Date depTim);
	
	
}
