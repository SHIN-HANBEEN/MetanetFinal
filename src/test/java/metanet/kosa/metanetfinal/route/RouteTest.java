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
		System.out.println(routeRepository.getTerminalIdByTerminalName("동서울"));
	}
	
}
