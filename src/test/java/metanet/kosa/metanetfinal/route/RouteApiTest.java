package metanet.kosa.metanetfinal.route;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.bus.repository.IBusesRepository;
import metanet.kosa.metanetfinal.reservation.service.ReservationService;
import metanet.kosa.metanetfinal.reservation.service.RouteApiService;
@SpringBootTest
public class RouteApiTest {
	@Autowired
	RouteApiService routeApiService;
	@Autowired
	ReservationService reservationService;
	@Autowired
	IBusesRepository busesRepository;
	
	@Test
	void testApi() {
		String callRouteAPI = routeApiService.callRouteAPI("동서울", "강릉시외터미널", "2024-01-05");
		System.out.println(callRouteAPI);
	}
	
	@Test
	void makeDataForSeatsInfo() {
		/**
		 * 
		 */
		String arrTime = "202401050930";
		String depTime = "202401050640";
		
		
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
			java.util.Date utilDate = dateFormat.parse(arrTime);
			Date sqlArrTime = new Date(utilDate.getTime());
			java.util.Date depDate = dateFormat.parse(depTime);
			Date sqlDepTime = new Date(depDate.getTime());
			
			reservationService.makeTestDataReservationInfo("NAI0511601", "NAI2551901", sqlDepTime, sqlArrTime, "우등", 22300);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@Test
	void occupiedSeatsTest() {
		List<Integer> busSeats = busesRepository.getOccupiedBusSeats("NAI0511601", "NAI2551901", "202401050930");
		for (Integer integer : busSeats) {
			System.out.println(integer);
		}
	}
	
	@Test
	void costTest() {
		List<Integer> costs = busesRepository.getDiscountedCostOfBusSeats("NAI0511601", "NAI2551901", "202401050930");
		for (Integer integer : costs) {
			System.out.println(integer);
		}
	}
	
	@Test
	void testData() {
		Map<String, Object> data = reservationService.getDataForSeatsSelection("NAI0511601", "NAI2551901", "202401050640");
		System.out.println(data);
	}
	
	@Test
	void testDate() {
		Date nowSqlDate = reservationService.nowSqlDate();
		System.out.println(nowSqlDate.toString());
	}
}
