package hwarang.artg.member.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KakaoService {
	//카카오톡 유저의 정보 조회
	public Map<String, Object> getUserInfo(String access_token) {
		//카카오톡 사용자 정보 요청을 위한 주소
		String REQUEST_URL = "https://kapi.kakao.com/v2/user/me";

//		String CLIENT_ID = "v2OqEOP4IZWY36zQjmM47MjRW19kxiG3";
//		String REDIRECT_URI = "http://localhost:8081/member/kakaoLogin";
		//HttpClient 생성
		HttpClient client = HttpClientBuilder.create().build();
		//Post 메소드 URL 생성
		HttpPost post = new HttpPost(REQUEST_URL);
		//정보 요청을 위한 코드 추가
		post.addHeader("Authorization", "Bearer " + access_token);
		// post.addHeader("property_keys","[\"kakao_account.email\"]");

		JsonNode node = null;//map과 list로만 사용가능.
		HttpResponse response;
		Map<String, Object> kakaoInfo = null;
		try {
			//클라이언트가 post메소드를 요청한다.
			response = client.execute(post);
			//요청한 코드 번호
			int responseCode = response.getStatusLine().getStatusCode();
			//인스턴스 생성
			ObjectMapper mapper = new ObjectMapper();
			System.out.println("kakaoLogin : " + response.getEntity().getContent());
			//인스턴스는 요청한 Entity의 내용을 node에 저장
			node = mapper.readTree(response.getEntity().getContent());

			System.out.println("responseCode : " + responseCode);
			System.out.println("node : " + node);				
		
			kakaoInfo = new HashMap<String, Object>();
			kakaoInfo.put("id", node.get("id").asText());
			kakaoInfo.put("name", node.get("properties").get("nickname").asText());
			kakaoInfo.put("email", node.get("kakao_account").get("email").asText());
			String genderInfo = node.get("kakao_account").get("has_gender").asText();
			System.out.println(genderInfo.toString());
			if(genderInfo.toString().equals("true")) {
				kakaoInfo.put("gender", node.get("kakao_account").get("gender").asText());				
			}
				
			System.out.println(kakaoInfo);				

			
			
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return kakaoInfo;
	}
	//카카오톡 동적 동의 하기
	public void scops() {
		String REDIRECT_URI = "http://localhost:8081/member/kakaoLogin";
		String APP_KEY = "e210e19417b24807d3716f4e5a0bf4a9";
		String REQUEST_URL = "https://kapi.kakao.com/oauth/authorize?";	
		String SCOPE_VALUE = "account_email profile gender";
		
		String encodedURI=null; 
		try {
			encodedURI = "client_id="+URLEncoder.encode(APP_KEY, "utf-8")+"&redirect_uri="+URLEncoder.encode(REDIRECT_URI, "utf-8")+
					"&response_type=code&scope="+URLEncoder.encode(SCOPE_VALUE, "utf-8")+"";
			REQUEST_URL +=encodedURI;
			
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(REQUEST_URL);
		HttpClient client = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(REQUEST_URL);

		JsonNode node = null;
		HttpResponse response;
		
		try {
			response = client.execute(get);
			int responseCode = response.getStatusLine().getStatusCode();
			System.out.println("responseCode : "+responseCode);
			ObjectMapper mapper = new ObjectMapper();
			System.out.println("scope : " + response.getEntity().getContent());
			node = mapper.readTree(response.getEntity().getContent());
			
			System.out.println("scopeResult: " + node);

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	//카카오톡 탈퇴1:연결해제를 위한 토큰 부르기
	public Map<String, Object> delete(String access_token){
		String REQUEST_URL = "https://kapi.kakao.com/v1/user/unlink";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(REQUEST_URL);
		post.addHeader("Authorization", "Bearer " + access_token);
		
		JsonNode node = null;
		HttpResponse response;
		Map<String, Object> kakaoInfo = null;
		try {
			response = client.execute(post);
			int responseCode = response.getStatusLine().getStatusCode();
			System.out.println("responseCode : "+responseCode);
			ObjectMapper mapper = new ObjectMapper();
			System.out.println("delete : " + response.getEntity().getContent());
			node = mapper.readTree(response.getEntity().getContent());
			
			kakaoInfo = new HashMap<String, Object>();
			System.out.println("kakao delete: " + node);
			
			String id = (String) kakaoInfo.put("id", node.get("id").asText());
			delete2(id);	
			
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return kakaoInfo;
	}
	//카카오톡 탈퇴2:연결해제를 위한 admin_key
	public boolean delete2(String id){
		String REQUEST_URL = "https://kapi.kakao.com/v1/user/unlink";
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(REQUEST_URL);
		post.addHeader("Authorization", "KakaoAK " + "ebe1248c4e13e583973bb5648cb44db1");
		post.addHeader("target_id_type=user_id&target_id=", id);
		
		HttpResponse response;
		try {
			response = client.execute(post);
			int responseCode = response.getStatusLine().getStatusCode();
			System.out.println("responseCode : "+responseCode);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	
	//카카오톡 로그아웃
	public Map<String, Object> logout(String access_token) {

		String REQUEST_URL = "https://kapi.kakao.com/v1/user/logout";
//		String CLIENT_ID = "v2OqEOP4IZWY36zQjmM47MjRW19kxiG3";
//		String REDIRECT_URI = "http://localhost:9000/Ykproject/write";

		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(REQUEST_URL);
		post.addHeader("Authorization", "Bearer " + access_token);
		// post.addHeader("property_keys","[\"kakao_account.email\"]");

		JsonNode node = null;
		HttpResponse response;
		Map<String, Object> kakaoInfo = null;
		try {
			response = client.execute(post);
			int responseCode = response.getStatusLine().getStatusCode();
			System.out.println("responseCode : "+responseCode);
			
			ObjectMapper mapper = new ObjectMapper();
			System.out.println("test : " + response.getEntity().getContent());
			node = mapper.readTree(response.getEntity().getContent());
			
			System.out.println("kakao Logout: " + kakaoInfo);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return kakaoInfo;
	}

	
}
