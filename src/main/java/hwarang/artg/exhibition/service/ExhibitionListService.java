package hwarang.artg.exhibition.service;

import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionVO;
import hwarang.artg.exhibition.model.FavoriteMarkVO;
import hwarang.artg.mapper.ExhibitionMapper;

@Service
public class ExhibitionListService {
	public final static String PERFORMANCE_URL = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/area";
	public final static String SERVICE_KEY = "lC8yHF1DodgPZJZKtzXssNiqMkAYDgZRbHSPlU0ugzFUcEDrgFZOh1HPGhReobUFwYGi9mNi9qEyjINoHIo8%2FA%3D%3D";
	@Autowired
	private ExhibitionMapper mapper;

	public List<ExhibitionVO> showPlaceList(String area) {
		return mapper.getPlaceList(area);
	}
	
	public ExhibitionVO showPlaceListByPseq(String placeseq) {
		return mapper.getPlaceByPseq(placeseq);
	}
	
	public List<ExhibitionVO> showListByPlace(String placeseq) {
		return mapper.getListByPlace(placeseq);
	}

	public List<ExhibitionVO> showList(String area) {
		return mapper.selectAll(area);
	}
	
	public List<ExhibitionVO> mainList(CriteriaDTO cri, String member_id) {
		return mapper.getListMain(cri, member_id);
	}
	
	public List<ExhibitionVO> pagingList(CriteriaDTO cri, ExhibitionVO exh,  String member_id) {
		return mapper.getListWithPaging(cri, exh, member_id);
	}
	
	public ExhibitionVO getOne(int exh_seq) {
		return mapper.select(exh_seq);
	}
	
	public int getTotal(CriteriaDTO cri,  ExhibitionVO exh) {
		return mapper.getTotalCount(cri, exh);
	}
	
	public List<String> getExhRealmName() {
		return mapper.getExhRealmName();
	}
	
	public List<String> getExhArea() {
		return mapper.getExhArea();
	}
	
	public List<String> getExhPlace() {
		return mapper.getExhPlace();
	}
	
	
	public void apiParserSearch() throws Exception {
		URL url = new URL(PERFORMANCE_URL + "?ServiceKey=" + SERVICE_KEY + "&cPage=1&rows=10000&sortStdr=1");
		XmlPullParserFactory xmlFactory = XmlPullParserFactory.newInstance();
		xmlFactory.setNamespaceAware(true);
		XmlPullParser xpp = xmlFactory.newPullParser();
		BufferedInputStream bis = new BufferedInputStream(url.openStream());
		xpp.setInput(bis, "utf-8");
		
		String tag = null;
		int event_type = xpp.getEventType();
		ArrayList<String> list = new ArrayList<String>();
		String seq = null;
		
		while (event_type != XmlPullParser.END_DOCUMENT) {
			if (event_type == XmlPullParser.START_TAG) {
				tag = xpp.getName();
			} else if (event_type == XmlPullParser.TEXT) {
				if (tag.equals("seq")) {
					seq = xpp.getText();
				}
				
			} else if (event_type == XmlPullParser.END_TAG) {
				tag = xpp.getName();
				if (tag.equals("perforList")) {
					list.add(seq);
				}
			}
			event_type = xpp.next();
		}
		ExhibitionService service = new ExhibitionService();
		
		for (int i = 0; i < list.size(); i++) {
			mapper.insert(service.apiParserSearch(list.get(i)));
		}
	}
}
