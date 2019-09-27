package hwarang.artg.member.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Service;


@Service
public class NaverService {
	private static final String CLIENT_ID = "fTb1pWogm_CexeF_mq3L";
	private static final String CLIENT_SECRET = "aM3Tt1sbkX";
	//redirect_url
	private static final String REDIRECT_URL = "http://localhost:8081/member/naverLogin";
	//redirect_url2
	private static final String REDIRECT_URL2 = "http://localhost:8081/index";
	
	public NaverService() {
		
	}
	// CSRF(요청위조) 방지를 위한 애플리케이션과 사용자 간의 상태를 보유하는 고유한 세션 토큰 생성
	// 상태 토큰(=세션토큰)은 추후 검증을 위해 세션에 저장되어야 한다.
	public String getState() {
		// 상태 토큰으로 사용할 랜덤 문자열 생성(고유한 세션토큰을 위함)
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		return state;
	}
	//네이버 로그인 인증요청문의 url 생성
	public String getURL(String state) {
		try {
			//문자열의 redirectURL를 인코딩으로 변환해야 한다.
			String redirectURL = URLEncoder.encode(REDIRECT_URL, "UTF-8");
			//response_type=code : 인증과정에 대한 구분값,code로 값 고정
			String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			apiURL += "&client_id=" + CLIENT_ID;
			apiURL += "&redirect_uri=" + redirectURL;
			apiURL += "&state=" + state;
			//필수 정보 제공을 위한 코드(매번?)
//			apiURL += "&auth_type=reprompt";				
			return apiURL;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	//state - 콜백으로 전달받은 상태 토큰이 서비스에서 생성한 상태토큰과 일치해야 정상적인 요청 확인(검증)받는다.
	//검증을 받고 인증코드(code)를 받는다.만약 일치하지 않는다면 오류코드를 받는다.
	//code - 콜백으로 전달받은 인증코드,접근토큰 발급에 사용됨.
	//상태 토큰에 대한 검증이 성공적으로 끝났다면 응답으로 전달받은 인증 코드를 이용해 최종 인증 값인 접근 토큰을 발급받습니다.
	public Map<String, Object> getUserInfo(String code,String state){
		String redirectURL;
		try {
			redirectURL = URLEncoder.encode(REDIRECT_URL2, "UTF-8");
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
			apiURL += "&client_id=" + CLIENT_ID;
			apiURL += "&client_secret=" + CLIENT_SECRET;
			apiURL += "&redirect_uri=" + redirectURL;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
//			String access_token = "";
//			String refresh_token = "";
			System.out.println("apiURL="+ apiURL);
			
			URL url = new URL(apiURL); //인증을 받기 위한 주소(상태토큰)를 넣는다.
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			//넣어준 주소를 get방식으로 연결한다.
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();//연결해서 받은 인증코드
			BufferedReader br; 
			System.out.println("responseCode="+responseCode); 
			
			if(responseCode == 200) {//정상 호출
				//연결해서 받은 데이터(accessToken)를 버퍼에 거쳐서 전달 받는다. 
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else { //에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer(); //문자열을 추가하거나 변경할때 주로 사용하는 자료형
			//문자열 inputLine안에 받은데이터를 읽어온다. null이 될때까지 읽어온다.
			while((inputLine = br.readLine())!=null) {
				res.append(inputLine); //읽어온 데이터를 inpurLine에 추가한다.
			}
			br.close(); //다 받으면 BufferedReader를 닫는다.
			if(responseCode == 200) {
				System.out.println("naver Service: "+res.toString());
				//문자열로 받은 accessToken을 json으로 변환한다.
				//서버에서 클라이언트에게 값을 전달하기 위해 사용한다.
				JSONObject json = new JSONObject(res.toString());
				String accessToken = json.getString("access_token");
				System.out.println("accessToken:"+accessToken);
				//accessToken을 이용해 사용자를 조회하는 메소드
				return getUserInfoFormNaver(accessToken); 
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return null;
	}
	//accessToken을 이용해 사용자를 조회하는 메소드
	public Map<String, Object> getUserInfoFormNaver(String accessToken){
		String token = accessToken; //네이버 로그인 접근토큰;
		String header = "Bearer " + token; //Bearer 다음에 공백 추가
		//요청할때 Authorization: [Bearer(토큰타입)] [접근 토큰] 형식으로 요청 헤더를 보낸다. 
		try {
			//사용자 프로필 정보 조회 요청 URL
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine())!= null) {
				response.append(inputLine);
			}
			br.close();
			JSONObject json = new JSONObject(response.toString());
			JSONObject userJson = json.getJSONObject("response");
			return userJson.toMap();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
//	//네이버 회원 탈퇴 메소드
//	public Map<String, Object> naverDelete(String accessToken) throws UnsupportedEncodingException {
//		String token;
//		token = URLEncoder.encode(accessToken, "UTF-8");
//				
//		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=delete";
//		apiURL += "&client_id=" + CLIENT_ID;
//		apiURL += "&client_secret=" + CLIENT_SECRET;
//		apiURL += "&access_token=" + token;
//		apiURL += "&service_provider=NAVER";
//		
//		try {
//			URL url = new URL(apiURL);
//			HttpURLConnection con = (HttpURLConnection) url.openConnection();
//			con.setRequestMethod("GET");
//			int responseCode = con.getResponseCode();
//			BufferedReader br;
//			if(responseCode == 200) {
//				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
//			}else {
//				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
//			}
//			String inputLine;
//			StringBuffer response = new StringBuffer();
//			while((inputLine = br.readLine())!= null) {
//				response.append(inputLine);
//			}
//			br.close();
//			JSONObject json = new JSONObject(response.toString());
//			JSONObject userJson = json.getJSONObject("response");
//			return userJson.toMap();
//			
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		
//		return null;
//		
//	}
}
