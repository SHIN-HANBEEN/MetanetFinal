package metanet.kosa.metanetfinal.route;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.reservation.service.IReservationService;
import metanet.kosa.metanetfinal.route.repository.IRouteRepository;
import metanet.kosa.metanetfinal.route.service.IRouteService;

@SpringBootTest
public class RouteTest {
	@Autowired
	IRouteRepository routeRepository;
	
	@Autowired
	IRouteService routeService;
	
	@Autowired
	IReservationService reservationService;
	
	
	
//	@Test
//	public void getRouteId() {
//		System.out.println("test started");
//		Date departureTime = null;
//		Date arrivalTime = null;
//		
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
//		try {
//            Date parsedDepartureDate = (Date) dateFormat.parse("202312280640");
//            Date parsedArrivalDate = (Date) dateFormat.parse("");
//            departureTime = new Date(parsedDepartureDate.getTime());
//            arrivalTime = new Date(parsedArrivalDate.getTime());
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
//		if (routeRepository.getRouteId("NAI0511601", "NAI2551901", departureTime)!= null) {
//			System.out.println(routeRepository.getRouteId("NAI0511601", "NAI2551901", departureTime));
//		} else {
//			System.out.println("결과가 비었습니다.");
//		}
//	}
	
//	@Test
//	public void getRemainintSeats() {
//		String depPlaceNm = "동서울";
//		String arrPlaceNm = "강릉시외터미널";
//		String depPlandTime = "202312290640";
//		String arrPlandTime = "202312290930";
//		String gradeNm = "우등";
//		String charge = "22300";
//		
//		String departureId = routeService.getTerminalIdByTerminalName(depPlaceNm.trim());
//		String arrivalId = routeService.getTerminalIdByTerminalName(arrPlaceNm.trim());
//		String trimedDepPlandTime = depPlandTime.trim();
//		String trimedArrPlandTime = arrPlandTime.trim();
//		String trimedGradeNm = gradeNm.trim();
//		String trimedCharge = charge.trim();
//		int price = Integer.valueOf(trimedCharge);
//		Date departureTime = null;
//		Date arrivalTime = null;
//		try {
//			// Parse the string into separate components
//			int year = Integer.parseInt(trimedDepPlandTime.substring(0, 4));
//			int month = Integer.parseInt(trimedDepPlandTime.substring(4, 6));
//			int day = Integer.parseInt(trimedDepPlandTime.substring(6, 8));
//			int hour = Integer.parseInt(trimedDepPlandTime.substring(8, 10));
//			int minute = Integer.parseInt(trimedDepPlandTime.substring(10, 12));
//
//			// departureTime 설정
//			departureTime = getSqlDate(year, month, day, hour, minute);
//
//			// Parse the string into separate components
//			int year2 = Integer.parseInt(trimedArrPlandTime.substring(0, 4));
//			int month2 = Integer.parseInt(trimedArrPlandTime.substring(4, 6));
//			int day2 = Integer.parseInt(trimedArrPlandTime.substring(6, 8));
//			int hour2 = Integer.parseInt(trimedArrPlandTime.substring(8, 10));
//			int minute2 = Integer.parseInt(trimedArrPlandTime.substring(10, 12));
//
//			// departureTime 설정
//			arrivalTime = getSqlDate(year2, month2, day2, hour2, minute2);
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		
//		System.out.println(departureId);
//		System.out.println(arrivalId);
//		System.out.println(departureTime);
//		System.out.println(arrivalTime);
//		System.out.println(trimedGradeNm);
//		System.out.println(charge);
//
//		System.out.println(reservationService.getRemainingSeatCount(
//				departureId, 
//				arrivalId, 
//				departureTime, 
//				arrivalTime, 
//				trimedGradeNm,
//				price));
//	}
//	
//	
//	private static java.sql.Date getSqlDate(int year, int month, int day, int hour, int minute) throws ParseException {
//		// Construct a java.util.Date object
//		java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd HH:mm")
//				.parse(String.format("%04d-%02d-%02d %02d:%02d", year, month, day, hour, minute));
//
//		// Convert java.util.Date to java.sql.Date
//		return new java.sql.Date(utilDate.getTime());
//	}
//	
	@Test
	public void getCityIdByCityName() {
		System.out.println(
				routeService.getCityIdByCityName("서울")
				);
	}
	
	@Test
	public void getTerminalNameByCityId() {
		List<String> r = routeService.getTerminalNamesByCityId(11);
		System.out.println(r);
				
	}
}
