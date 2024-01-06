package metanet.kosa.metanetfinal.route;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.route.repository.IRouteRepository;

@SpringBootTest
public class RouteTest {
	@Autowired
	IRouteRepository routeRepository;
	
	
	
	
	@Test
	public void getRouteId() {
		System.out.println("test started");
		Date departureTime = null;
		Date arrivalTime = null;
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		try {
            Date parsedDepartureDate = (Date) dateFormat.parse("202312280640");
            Date parsedArrivalDate = (Date) dateFormat.parse("");
            departureTime = new Date(parsedDepartureDate.getTime());
            arrivalTime = new Date(parsedArrivalDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
		if (routeRepository.getRouteId("NAI0511601", "NAI2551901", departureTime)!= null) {
			System.out.println(routeRepository.getRouteId("NAI0511601", "NAI2551901", departureTime));
		} else {
			System.out.println("결과가 비었습니다.");
		}
	}
}
