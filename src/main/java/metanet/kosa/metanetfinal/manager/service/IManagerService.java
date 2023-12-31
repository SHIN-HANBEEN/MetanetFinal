package metanet.kosa.metanetfinal.manager.service;

import metanet.kosa.metanetfinal.notice.model.Notices;

public interface IManagerService {
	void AlarmForModifiedEvent(int schId, String alarmInfo);
	void insertBoard(Notices notice);
	void updateBoard(Notices notice);
	void deleteBoard(int noticeId);
}
