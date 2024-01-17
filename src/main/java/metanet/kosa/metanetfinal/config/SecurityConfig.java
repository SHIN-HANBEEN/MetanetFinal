package metanet.kosa.metanetfinal.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import lombok.extern.slf4j.Slf4j;
import metanet.kosa.metanetfinal.jwt.JwtAuthenticationFilter;
import metanet.kosa.metanetfinal.jwt.JwtTokenProvider;

@Configuration
@EnableWebSecurity
@Slf4j
public class SecurityConfig {

	@Bean
	PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

	@Bean
	JwtTokenProvider jwtTokenProvider() {
		return new JwtTokenProvider();
	}

	@Bean
	JwtAuthenticationFilter authenticationFilter() {
		return new JwtAuthenticationFilter(jwtTokenProvider());
	}

	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf((csrf) -> csrf.disable());
		// 토큰을 사용하는 경우 인가를 적용한 URI 설정
		http.authorizeHttpRequests((authorizeHttpRequests) -> authorizeHttpRequests
				.requestMatchers("/mypage").hasAnyRole("USER", "ADMIN")
				.requestMatchers("/notice/register").hasRole("ADMIN")
				.requestMatchers("/**", "assets/css/**", "assets/js/**", "assets/img/**", "/login").permitAll());
		// requestMatchers("/login", "/signin").permitAll());

		// Session 기반의 인증기반을 사용하지 않고 추후 JWT를 이용하여서 인증 예정
		http.sessionManagement((session) -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

		// Spring Security JWT 필터 로드
		http.addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider()),
				UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

}
