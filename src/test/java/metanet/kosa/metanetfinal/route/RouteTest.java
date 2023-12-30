package metanet.kosa.metanetfinal.route;

import java.sql.Date;

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
		System.out.println(routeRepository.getRouteId("NAI0511601", "NAI2551901", new Date(2023, 12, 29);
	}
}
