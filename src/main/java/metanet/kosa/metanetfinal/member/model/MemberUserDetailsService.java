package metanet.kosa.metanetfinal.member.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import metanet.kosa.metanetfinal.member.service.IMemberService;


@Component
public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private IMemberService memberService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		/*
		 * username으로 Repository에서 Member를 찾는 method
		 */
		Members member = memberService.getMemberInfo(username);
		if(member == null) { //로그인하지 않은 사용자
			throw new UsernameNotFoundException("[" + member.getMemberId() + "] 사용자는 없습니다."); 
			//SpringSecurity 가 갖는 예외 발생 with 메시지
		}
		
		List<String> roles = memberService.getRoles(username);

		// 위의 권한을 활용해서 authorities 를 만들어야 합니다. 
		
		List<GrantedAuthority> authorities = AuthorityUtils.createAuthorityList(roles); 
		//String 배열을 활용해서 Authority 배열을 만들 수 있는 AuthorityUtils 의 createAuthorityList 메서드
		return new MemberUserDetails(member.getId(), 
				member.getPassword(), authorities, member.getMileage());
	}
}