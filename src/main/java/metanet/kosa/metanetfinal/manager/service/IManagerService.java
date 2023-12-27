package metanet.kosa.metanetfinal.manager.service;

import java.util.List;

import metanet.kosa.metanetfinal.notice.model.Notice;

public interface IManagerService {
	void AlarmForModifiedEvent(int schId, String alarmInfo);
	void insertBoard(Notice notice);
	void updateBoard(Notice notice);
	void deleteBoard(int ntcId);
}
