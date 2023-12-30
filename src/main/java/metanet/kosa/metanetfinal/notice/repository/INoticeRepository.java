package metanet.kosa.metanetfinal.notice.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import metanet.kosa.metanetfinal.notice.model.Notices;

@Mapper
@Repository
public interface INoticeRepository {
	// 공지사항 리스트 조회
	List<Notices> getNoticeList();
	// 공지사항 상세 조회
	Notices getNotice(int ntcId);
}
