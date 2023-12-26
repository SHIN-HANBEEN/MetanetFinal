package metanet.kosa.metanetfinal.company.repository;

public interface IBusRepository {
	/*
	 * 버스의 좌석 수 반환하기
	 */
	int getSeatCountBySchedule(int sceId);
}
