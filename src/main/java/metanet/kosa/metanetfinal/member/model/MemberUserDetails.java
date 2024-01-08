package metanet.kosa.metanetfinal.member.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;

public class MemberUserDetails extends User {

	private static final long serialVersionUID = -3906158559151971401L;

	private int mileage;

	public MemberUserDetails(String username, String password, 
			Collection<? extends GrantedAuthority> authorities, int mileage) {
		super(username, password, authorities);
		this.mileage = mileage;
	}
	
	public int getUserEmail() {
		
		return this.mileage;
	}
}

/*
 * @Override public Collection<? extends GrantedAuthority> getAuthorities() {
 * List<GrantedAuthority> auths = new ArrayList<>(); String role =
 * member.getRole();
 * 
 * auths.add(new SimpleGrantedAuthority(role)); return auths; }
 * 
 * 
 * 비밀번호 정보 제공
 * 
 * @Override public String getPassword() { return member.getPassword(); }
 * 
 * 
 * ID 정보 제공
 * 
 * @Override public String getUsername() { return member.getId(); }
 * 
 * 
 * 계정 만료 여부 제공 특별히 사용 안할 시 항상 true
 * 
 * @Override public boolean isAccountNonExpired() { return true; }
 * 
 * 
 * 계정 비활성화 여부 제공 사용 안할경우 true를 반환
 * 
 * @Override public boolean isAccountNonLocked() { return true; }
 * 
 * 
 * 계정 인증 정보를 저장할지에 대한 여부 ture 처리 시 모든 인증정보를 만료시키지 않기에 주의
 * 
 * @Override public boolean isCredentialsNonExpired() { return true; }
 * 
 * 
 * 계정 활성화 여부 사용 안할 시 true 반환
 * 
 * @Override public boolean isEnabled() { return true; }
 * 
 * }
 */

/*
 * private static final long serialVersionUID = -3906158559151971401L;
 * 
 * private int mileage;
 * 
 * public MemberUserDetails(String username, String password, Collection<?
 * extends GrantedAuthority> authorities, int mileage) { super(username,
 * password, authorities); this.mileage = mileage; }
 * 
 * public int getMileage() { return this.mileage; } }
 */
