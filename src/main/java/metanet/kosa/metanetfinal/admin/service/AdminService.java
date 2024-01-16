package metanet.kosa.metanetfinal.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import metanet.kosa.metanetfinal.admin.repository.IAdminRepository;

import metanet.kosa.metanetfinal.admin.model.TodayRoutes;


@Service
public class AdminService implements IAdminService{

	@Autowired
	IAdminRepository adminRepository;
	
	@Override
	public String todayPrice() {
		String price = adminRepository.getTodayPrice();
		return price;
	}

	@Override
	public String MonthPrice() {
		String price = adminRepository.getMonthPrice();
		return price;
	}

	@Override
	public int todayRes() {
		int count = adminRepository.getTodayRes();
		return count;
	}

	@Override
	public int monthRes() {
		int count = adminRepository.getMonthRes();
		return count;
	}

	@Override
	public List<TodayRoutes> TodayRoutes() {
		return adminRepository.todayRoutes();
	}

	@Override
	public List<Map<String, String>> weekPrice() {
		return adminRepository.weekPrice();
	}

	
	
	

}
