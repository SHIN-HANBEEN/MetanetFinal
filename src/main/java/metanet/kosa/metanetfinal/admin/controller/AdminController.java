package metanet.kosa.metanetfinal.admin.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.ui.Model;

import metanet.kosa.metanetfinal.admin.model.TodayRoutes;
import metanet.kosa.metanetfinal.admin.service.IAdminService;
import metanet.kosa.metanetfinal.member.model.Members;
import metanet.kosa.metanetfinal.member.service.IMemberService;

@Controller
public class AdminController {
	
	@Autowired
	IMemberService MemberService;
	
	@Autowired
	IAdminService adminService;
	
	@GetMapping(value = "/admin/home")
	public String adminhome(Principal principal, Model model) {
		Members member = new Members();
		String todayPrice  = addCommas(adminService.todayPrice());
		String monthPrice  = addCommas(adminService.MonthPrice());
		int todayRes = adminService.todayRes();
		int monthRes = adminService.monthRes();
		member = MemberService.getMemberInfo(principal.getName());
		List<TodayRoutes> todayRoutes = adminService.TodayRoutes();
		List<Map<String, String>> weekPreice = adminService.weekPrice();
		System.out.println(weekPreice);
		model.addAttribute("member", member);
		model.addAttribute("todayPrice", todayPrice);
		model.addAttribute("monthPrice", monthPrice);
		model.addAttribute("todayRes", todayRes);
		model.addAttribute("monthRes", monthRes);
		model.addAttribute("todayRoutes", todayRoutes);
		model.addAttribute("weekPreice", weekPreice);
		return "admin/index";
	}
	
	
	
	
    private static String addCommas(String input) {
        // 뒤에서 3글자마다 콤마 추가
        StringBuilder result = new StringBuilder();
        int count = 0;
        
        for (int i = input.length() - 1; i >= 0; i--) {
            result.insert(0, input.charAt(i));
            count++;
            
            if (count == 3 && i != 0) {
                result.insert(0, ",");
                count = 0;
            }
        }

        return result.toString();
    }
}
