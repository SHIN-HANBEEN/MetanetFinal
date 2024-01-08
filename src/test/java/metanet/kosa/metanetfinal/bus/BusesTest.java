package metanet.kosa.metanetfinal.bus;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import metanet.kosa.metanetfinal.bus.repository.IBusesRepository;

@SpringBootTest
public class BusesTest {
	@Autowired
	IBusesRepository busesRepository;
	
	@Test
	void busSeatCountTest() {
		List<Integer> li = new ArrayList<>();
		li.add(5);
		li.add(6);
		li.add(7);
		li.add(8);
		int count = busesRepository.verifyCountFalseSeats(2, li );
		System.out.println(count);
	}
}
