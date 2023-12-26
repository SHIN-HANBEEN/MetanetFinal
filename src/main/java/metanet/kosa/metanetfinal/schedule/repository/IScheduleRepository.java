package metanet.kosa.metanetfinal.schedule.repository;

import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.schedule.model.Schedule;

@Mapper
@Repository
public interface IScheduleRepository {
	Schedule[] getSchedule(int depId, int desId, Date depTim);
}
