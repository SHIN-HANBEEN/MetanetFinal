package metanet.kosa.metanetfinal.manager.repository;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.notice.model.Notice;

@Repository
@Mapper
public interface IManagerRepository {
	void insertBoard(Notice notice);
	void updateBoard(Notice notice);
	void deleteBoard(int ntcId);
}
