package hwarang.artg.common.model;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class MessageAspect {
	@Pointcut("execution(* hwarang.artg..controller.*.*Register(..))")
	public void servicept() {}
	
	@Before("servicept()")
	public void startService() {
		System.out.println("aop동작 글 등록 전!!");
	}
	
	@After("servicept()")
	public void endService() {
		System.out.println("글 등록했습니다. AOP동작");
	}

}
