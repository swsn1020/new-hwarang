package hwarang.artg.fundingTest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordEncoderTest {
	public static void main(String[] args) {
		String pw = "18110792";
		String ecodedPw = "$2a$10$isoBuiGHXWwLWkJqM/wRYubmYLoPbOGSM/XlJgZww1.eVNsvyNvai";
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		
		System.out.println(encoder.matches(pw, ecodedPw));
		
		
		
	}
}
