package metanet.kosa.metanetfinal.common;



import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class LogAspect {
//	@Before("execution(* metanet.kosa.metanetfinal..*.*(..))")
//	public void beforeLog(JoinPoint joinPoint) {
//		Signature signature = joinPoint.getSignature();
//		String methodName = signature.getName();
//		log.info("[[[AOP-before Log]]]-{}", methodName);
//	}
	
//	@AfterThrowing(pointcut = "* metanet.kosa.metanetfinal..*.*(..)", throwing = "exception")
//	public void afterThrowingLog(JoinPoint joinPoint, Exception exception) {
//		Signature signature = joinPoint.getSignature();
//		String methodName = signature.getName();
//		log.info("[[AOP-after throwing Log]]-{}, ex: {}", methodName, exception.getMessage());
//	}
}
