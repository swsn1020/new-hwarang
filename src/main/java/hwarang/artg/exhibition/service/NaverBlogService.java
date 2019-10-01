package hwarang.artg.exhibition.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import hwarang.artg.exhibition.model.NaverBlogDTO;

@Service
public class NaverBlogService {
	
	private static final String CLIENT_ID = "fTb1pWogm_CexeF_mq3L";
	private static final String CLIENT_SECRET = "aM3Tt1sbkX";
	
	public List<NaverBlogDTO> naverurlapi(String keyword) throws Exception {

		String apiURL = "https://openapi.naver.com/v1/search/blog?query=";
		//http 요청 보내기
		
		List<NaverBlogDTO> result = new ArrayList<NaverBlogDTO>();
		
//		String keyword = "미국영어회화문법";
		String endcodedKeyword = URLEncoder.encode(keyword,"utf-8");
		apiURL += endcodedKeyword;
		
		URL url = new URL(apiURL);
		
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		//요청 보낼때 client id와 secret을 함께 전송해야 한다.
		connection.setRequestProperty("X-Naver-Client-Id", CLIENT_ID);
		connection.setRequestProperty("X-Naver-Client-Secret", CLIENT_SECRET);
		//연결로부터 응답을 받아오기:스트림을 이용해서 받아오기
		//문자열울 읽어오기 위해서 BufferedReader를 이용하기
		BufferedReader br = null;
		
		//요청이 제대로 처리됬을 경우에만 데이터 읽어오기 : 응답코드를 통해서 확인
		int responceCode = connection.getResponseCode();
		if(responceCode == 200) { //요청 정상처리
			br = new BufferedReader(new InputStreamReader(connection.getInputStream()));			
		}else {
			br = new BufferedReader(
					new InputStreamReader(connection.getErrorStream()));
		}
		//바이트로 받지 않고 문자열로 출력하게 해준다.
		
		//스트림에서 문자 읽어오기
//		String inputLine = br.readLine(); //데이터 한줄읽어오는 코드
		
		String inputLine = null; //문자열을 줄 단위로 읽어오는데,
		//더이상 문자열이 없을때까지 읽어오기
		StringBuilder sb = new StringBuilder();
		while((inputLine = br.readLine())!=null) {
			sb.append(inputLine);// result += inputLine;
		}
		br.close();
//		System.out.println("검색완료");
//		System.out.println("---------------");
		System.out.println(sb.toString());
//		System.out.println("---------------");
		
		//사용가능한 객체 생성 : 책 목록  List<model>
		//json문자열로 List만들어내기
		//Json문자열 객체로 처리하기 위해서  라이브러리에 추가하기
		JSONObject jsonObject = new JSONObject(sb.toString());
		//{~~~,"items":[{},{},{},{},{},{}]}
		JSONArray items = jsonObject.getJSONArray("items");
		for(int i=0;i<items.length();i++) {
			JSONObject item = items.getJSONObject(i);
			NaverBlogDTO blog = new NaverBlogDTO();
			blog.setPostdate(item.getString("postdate"));
			blog.setDescription(item.getString("description"));
			blog.setLink(item.getString("link"));
			blog.setTitle(item.getString("title"));
			result.add(blog);
		}
		return result;
		
	}
}
