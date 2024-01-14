package metanet.kosa.metanetfinal.reservation.service;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import metanet.kosa.metanetfinal.bus.repository.IBusesRepository;

import metanet.kosa.metanetfinal.member.repository.IMemberRepository;

import metanet.kosa.metanetfinal.reservation.model.DetailedReservation;

import metanet.kosa.metanetfinal.reservation.model.Reservations;
import metanet.kosa.metanetfinal.reservation.repository.IReservationRepository;
import metanet.kosa.metanetfinal.route.model.Routes;
import metanet.kosa.metanetfinal.route.repository.IRouteRepository;

@Slf4j
@Service
public class ReservationService implements IReservationService{
	@Autowired
	IRouteRepository routeRepository;
	
	@Autowired
	IBusesRepository busesRepository;
	
	@Autowired
	IReservationRepository reservationRepository;
	
	@Autowired
	IMemberRepository memberRepository;
	
	public static final int discountRate = 2;
	
	@Transactional
	@Override
	public int getRemainingSeatCount(String departureId, String arrivalId, Date departureTime, 
			Date arrivalTime, String gradeName,int price) {
		

		//출발지, 도착지, 출발시간에 해당하는 데이터가 노선 테이블에 있는지 확인하기
		if (routeRepository.getRouteId(departureId, arrivalId, departureTime)== null) {
			//확인해서, 없으면 노선 아이디 UUID 만들기
			String routeId = UUID.randomUUID().toString();
			
			//노선 생성
			routeRepository.makeNewRoute(routeId, departureId, arrivalId, departureTime, arrivalTime, price);
			
			//버스 생성
			busesRepository.makeNewBus(routeId, gradeName);
			
			//좌석 생성
			int busId = busesRepository.getBusId(routeId);
			for(int i = 0; i<28; i++) {
				busesRepository.makeNewSeat(busId, i+1);
			}
			
			
			//잔여좌석 28 반환
			return busesRepository.getRemainingSeatCount(busId);
		} else {
			//확인해서 있으면, 좌석 테이블에 가서, 예매여부를 확인해서 잔여좌석 수 가져오기
			String routeId = routeRepository.getRouteId(departureId, arrivalId, departureTime);
			int busId = busesRepository.getBusId(routeId);
			return busesRepository.getRemainingSeatCount(busId);
		}
	}
	
	/*
	 * DB데이터 집어넣는 용도의 테스트 메서드 
	 * 나중에 지우기를 -완승-
	 */
	
	@Transactional
	@Override
	public int makeTestDataReservationInfo(String departureId, String arrivalId, Date departureTime, 
			Date arrivalTime, String gradeName,int price) {
		//노선,버스,좌석 DB저장
		int seatCount = getRemainingSeatCount(departureId, arrivalId, departureTime, arrivalTime, gradeName, price);
		return seatCount;
	}
	
	/*
	 * 예매 정보 조회
	 */
	
	/*
	 * 좌석선택페이지를 위한 데이터 JSON 만들기용 01-06
	 */
	@SuppressWarnings("deprecation")
	@Transactional
	@Override
	public Map<String, Object> getDataForSeatsSelection(
			String departureId, 
			String arrivalId, 
			String departureTime) { //202401082140 형태로 값이 전달된다. (reservationPageController 참고)
		Map<String, Object> data = new HashMap<>();
		
		String arrPlaceNm = routeRepository.getTerminalNameByTerminalId(arrivalId);
		String depPlaceNm = routeRepository.getTerminalNameByTerminalId(departureId);
		
		//departureTime = 202401082140 같은 형식으로 들어옵니다.
		// 에러 발생 안하는 것 확인 완료.
		Routes route = routeRepository.getRoute(departureId, arrivalId, departureTime);
		
		List<Integer> occupiedBusSeats = 
				busesRepository.getOccupiedBusSeats(departureId, arrivalId, departureTime);
		
		List<Integer> discountedCost = 
				busesRepository.getDiscountedCostOfBusSeats(departureId, arrivalId, departureTime);
		
		data.put("arrPlaceNm", arrPlaceNm);
		data.put("depPlaceNm", depPlaceNm);
		data.put("arrPlandTime", route.getArrivalTime().toLocaleString());
		data.put("depPlandTime", route.getDepartureTime().toLocaleString());
		data.put("gradeNm", busesRepository.getBusByRouteId(route.getRouteId()).getGradeName());
		data.put("busId", busesRepository.getBusByRouteId(route.getRouteId()).getBusId());
		data.put("routeId", route.getRouteId());
		data.put("occupiedSeats", occupiedBusSeats);
		data.put("adultCharge", discountedCost.get(0));
		data.put("middleChildCharge", discountedCost.get(1));
		data.put("childCharge", discountedCost.get(2));
		
		return data;
	}
	/*
	 * 좌석선택창에서 동시에 선택할 경우 먼저 다음버튼 누른사람이 승자
	 * 선택한 좌석의 수와 선택한 좌석의 예매여부 갯수를 비교
	 */
	@Transactional
	@Override
	public boolean verifySeatsCount(int busId, List<Integer> selectedSeatsList) {
		
		int reservedSeatsCnt = busesRepository.verifyCountFalseSeats(busId, selectedSeatsList);
		System.out.println("DB카운트:" + reservedSeatsCnt);
		System.out.println("DB카운트:" + selectedSeatsList.size());
		if(selectedSeatsList.size() != reservedSeatsCnt) return false;
		return true;
	}
	
	@Transactional
	public boolean reservationPaymentComplete(Map<String, Object> payData, List<Integer> selectedSeatsList) {
		int adultNum = Integer.parseInt(payData.get("adultNum").toString());
		int middleChildNum = Integer.parseInt(payData.get("middleChildNum").toString());
		int childNum = Integer.parseInt(payData.get("childNum").toString());
		//할인아이디 집어넣는 큐
		Queue<Integer> q = new LinkedList<>();
		int memberId = 0;
		int subtractMileage = 0;
		//마일리지 계산
		if(payData.get("isMember").equals("true")) {
			memberId = Integer.parseInt(payData.get("memberId").toString());
			int totalPrice = Integer.parseInt(payData.get("totalPrice").toString());
			subtractMileage = Integer.parseInt(payData.get("mileage").toString());
			memberRepository.updateMemberMileage(memberId, subtractMileage, discountRate, totalPrice);
		}
		for (int i = 0; i < adultNum; i++) q.add(1);
		for (int i = 0; i < middleChildNum; i++) q.add(2);
		for (int i = 0; i < childNum; i++) q.add(3);
		long currentTimeMillis = System.currentTimeMillis();//
		for (Integer seatId : selectedSeatsList) {
			Reservations reservation = 
					Reservations.builder()
								.resId(0)
								.memberId(memberId)
								.phoneNum(payData.get("phoneNum").toString())
								.routeId(payData.get("routeId").toString())
								.busId(Integer.parseInt(payData.get("busId").toString()) )
								.seatId(seatId)
								.discountId(q.poll())
								.resDate(new Date(currentTimeMillis))
								.payId(payData.get("payId").toString())
								.totalPrice(Integer.parseInt(payData.get("totalPrice").toString()))
								.cancledDate(null)
								.build();
			try {
				reservationRepository.insertReservationData(reservation);
				//회원이면 마일리지 차감 필요
			} catch (Exception e) {
				
				log.info("결제실패 @@#@#@#@#@");
				e.printStackTrace();
				return false;
			}
		}
		log.info("결제성공______________@@@@@@@@@!!!!!!!");
		return true;
	}

	public Date nowSqlDate() {
		// 현재 날짜 구하기        
		LocalDate day = LocalDate.now();
		LocalTime time = LocalTime.now();
		String hr = time.toString().split(":")[0];
		String mm = time.toString().split(":")[1];
		// 포맷 정의        
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");         
		// 포맷 적용       
		String formatedDay = day.format(formatter);
		String timeNow = formatedDay+hr+mm;
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		java.util.Date utilDate;
		Date sqlTime = null;
		try {
			utilDate = dateFormat.parse(timeNow);
			sqlTime = new Date(utilDate.getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(timeNow);
		return sqlTime;
	}
	
	/*
	 * 마이페이지 예매내역 및 취소내역 조회 :
	 * 과거 6개월까지 예매내역과 취소내역을 조회한다. 
	 */
	@Override
	public List<DetailedReservation> getReservationHistoryForLastSixMonth(@Param("canceledDate") Boolean canceledDate, @Param("phoneNum") String phoneNum) {
		return reservationRepository.getReservationHistoryForLastSixMonth(canceledDate,phoneNum);
	}

	/*
	 * 예매_회원 예매 정보 조회 : 
	 * 아직 출발 시간이 지나지 않은 예매 내역을 보여줍니다. 
	 */
	@Override
	public List<DetailedReservation> getReservationHistoryNotUsed(String phoneNum) {
		return reservationRepository.getReservationHistoryNotUsed(phoneNum);
	}



	@Override
	public Map<String, Object> getReservationInfo(String payId) {
		return reservationRepository.getReservationInfo(payId);
	}

	
	
	/*
	 * 예매 취소 :
	 * 예매가 취소되면, 예매 데이터를 삭제하는 것이 아닌, 
	 * 예매 취소 여부가 업데이트 된다. 
	 * 따라서, 예매-배차 테이블에 예매한 정보를 
	 * Cascade 로 삭제하는 것이 아닌 개발자가 직접 지워줘야 한다.
	 */
	@Transactional
	@Override
	public void cancleReservation(String payId) {
		/*예매 테이블에서 payId로 버스Id와 좌석Id를 가져옴
		 *한 예매에서 여러 좌석을 선택할 수 있기에 LIST
		 *가져온 데이터로 좌석 테이블의 좌석 상태를 true에서 false 변경
		 *
		 *예매 테이블에서 예매 취소일을 현재 날짜로 변경
		 */
		List<Map<String, Object>> data = reservationRepository.getUsingSeats(payId);
		for(Map<String, Object> reservationSeats : data) {
			int busId= Integer.parseInt(String.valueOf(reservationSeats.get("BUSID")));
			int seatId = Integer.parseInt(String.valueOf(reservationSeats.get("SEATID")));
			busesRepository.setBusSeatFalse(busId, seatId);
		}
		reservationRepository.updateResTableIsCnc(payId);
	}
	/*
	 * payId 로 좌석 리스트 가져오기
	 */
	@Transactional
	public List<Integer> getMySeatList(String payId) {
		return reservationRepository.getMySeatListByPayId(payId);
	}
	
	@Transactional
	public void modifySeat(List<Integer> updateToTrue, List<Integer> updateToFalse, int busId, String payId) {
		log.info("좌석변경중");
		for (int i = 0; i < updateToFalse.size(); i++) {
			reservationRepository.modifySeatByPayIdAndSeatId(payId, updateToFalse.get(i), updateToTrue.get(i));
			busesRepository.setBusSeatFalse(busId, updateToFalse.get(i));
			busesRepository.setBusSeatTrue(busId, updateToTrue.get(i));
		}
	}
		
//	@Autowired
//	IReservationRepository reservationRepository;
//	
//	@Autowired
//	IScheduleRepository scheduleRepository;
//	
//	@Autowired
//	IPaymentService paymentService;
//	
//	@Autowired
//	IBusRepository busRepository;
//	
//	@Autowired
//	IReservationScheduleRepository reservationScheduleRepository;
//	
//	
//	/*
//	 * 예매 변경(같은 노선, 다른 날짜, 다른 시간, 다른 좌석)
//	 * 배차아이디, 예매-배차 아이디, 좌석 번호 리스트를 받아서 업데이트를 해야 한다.
//	 * 예매 테이블에 있는 총액 컬럼은 DB에 설정해둔 제약조건에 따라 자동으로 업데이트 된다.
//	 */
//	@Override
//	public void updateReservation(int schId, List<Integer> satNumList, int resId) {
//		reservationRepository.updateReservation(schId, satNumList, resId);
//	}
//	
//	/*
//	 * 기존 결제를 취소하고 다시 결제를 진행해야한다.
//	 * 결제가 완료되면 예매변경을 진행한다.
//	 */
//	@Override
//	public void updateReservationWhenCostChange(int schId, List<Integer> satNumList, int resId, int price, int payNum) {
//		paymentService.cancle(payNum);
//		paymentService.pay(price);
//		reservationRepository.updateReservation(schId, satNumList, resId);
//	}
//	
//	/*
//	 * 좌석 변경, 예매 전에 잔여 좌석을 표시하기 위함
//	 * 버스의 좌석수와 사용한 좌석 id 리스트를 비교해서 
//	 * 잔여 좌석을 확인해야 한다.
//	 */
//	@Override
//	public List<Integer> getRemainingSeatId(int schId) {
//		int seatCount = busRepository.getSeatCountBySchedule(schId);
//		List<Integer> seatIdList = new ArrayList<>();
//
//	    for (int i = 1; i <= seatCount; i++) {
//	        seatIdList.add(i);
//	    }
//	    
//		List<Integer> reservedSeatIdList = reservationRepository.getReservedSeatIdListBySchedule(schId);
//
//		seatIdList.removeAll(reservedSeatIdList); //버스의 좌석 수로 뽑은 좌석 ID List 에서 예매된 것을 제거한 List 를 반환하면 된다.
//		
//		return seatIdList;
//	}
//	
//	/*
//	 * 좌석 변경 :
//	 * 배차는 그대로이기 때문에 예매-배차 테이블의 좌석번호만 고쳐주면 된다.
//	 */
//	@Override
//	public void updateSeat(List<Integer> satNumList, int resId) {
//		reservationRepository.updateReservation(resId, satNumList, resId);
//	}
//	

//	
//	@Override
//	public List<Reservation> getReservation(int nmbId) {
//		/*
//		 *비회원 예매 리스트 조회
//		 */
//		return reservationRepository.getReservation(nmbId);
//	}
//
//
//	@Override
//	public HashMap<String, String> getTicketInfo(int nmbId, String ticketCategory) {
//		/*
//		 * 비회원 티켓 발급
//		 * 티켓 종류(모바일 티켓, 지류 티켓)확인 후, 
//		 * QR코드, 티켓 일련번호 발송, 탑승정보(출발지, 도착지, 운송회사이름, 매수, 좌석 정보, 출발시간 ) 해시맵에 넣어서 반환
//		 */
//		return null;
//	}
//
//	@Override
//	public void changReservation(int resId, int schId) {
//		/*
//		 * 비회원 예매 변경
//		 * 좌석 변경, 예매 시간, 일자 변경 후 
//		 * 차액이 있다면 결제 진행 후
//		 * 이전 예매 취소 및 환불
//		 */
//		reservationRepository.changReservation(resId, schId);
//	}
//
//	@Override
//	public void changeSeat(int resId, int schId, int seatNum) {
//		/*
//		 * 비회원 좌석 변경
//		 * 사용자가 변경하기 원하는 좌석을 예약하고
//		 * 기존에 사용자가 예약했던 좌석은 취소
//		 */
//		
//		// 좌석 예약 코드 추가
//		reservationRepository.cancelReservation(resId, schId);
//	}
//
//	@Override
//	public void cancelReservation(int resId, int schId) {
//		/*
//		 * 비회원 예매 취소
//		 * 예매 취소한 후
//		 * 환불처리
//		 */
//		reservationRepository.cancelReservation(resId, schId);
//		// 환불 처리 코드 추가
//	}
//
//
//	@Override
//	public HashMap<String, String> getBusInfo(int schId) {
//		/*
//		 * 배차 시간표에서 사용자가 선택한 버스 정보 조회
//		 * 반환되어야 할 정보 : 요금, 소요 시간, 예매된 좌석 배열
//		 */
//		return reservationRepository.getBusInfo(schId);
//	}
//
//
//	@Override
//	public void selectSeat(int adult, int child, int special, int[] seats) {
//		/*
//		 * 매수 및 좌석 선택
//		 * 파라미터 : 일반/초등/보훈 인원수, 선택 좌석
//		 */
//		reservationRepository.selectSeat(adult, child, special, seats);
//		
//	}

	
}
