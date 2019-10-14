package hwarang.artg.exhibition.service;

import java.io.BufferedInputStream;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import hwarang.artg.exhibition.model.ExhibitionVO;

public class ExhibitionService {
	public final static String PERFORMANCE_URL = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/";
	public final static String SERVICE_KEY = "lC8yHF1DodgPZJZKtzXssNiqMkAYDgZRbHSPlU0ugzFUcEDrgFZOh1HPGhReobUFwYGi9mNi9qEyjINoHIo8%2FA%3D%3D";

	public ExhibitionVO apiParserSearch(String seq) throws Exception {
		String urlStr = PERFORMANCE_URL + "?serviceKey=" + SERVICE_KEY;
		if (seq != null) {
			urlStr = urlStr + "&seq=" + seq;
		}
		URL url = new URL(urlStr);

		ExhibitionVO exh;
		XmlPullParserFactory xmlFactory = XmlPullParserFactory.newInstance();
		xmlFactory.setNamespaceAware(true);
		XmlPullParser xpp = xmlFactory.newPullParser();
		BufferedInputStream bis = new BufferedInputStream(url.openStream());
		xpp.setInput(bis, "utf-8");

		String tag = null;
		int event_type = xpp.getEventType();
		ArrayList<ExhibitionVO> list = new ArrayList<ExhibitionVO>();
		exh = new ExhibitionVO();

		while (event_type != XmlPullParser.END_DOCUMENT) {
			if (event_type == XmlPullParser.START_TAG) {
				tag = xpp.getName();
			} else if (event_type == XmlPullParser.TEXT) {
				if (tag.equals("seq")) {
					exh.setExh_seq(Integer.parseInt(xpp.getText()));
				}
				if (tag.equals("title")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_title(x);
				}
				if (tag.equals("startDate")) {
					String x = xpp.getText();
					String date = x.substring(0, 4)+"/"+x.substring(4, 6)+"/"+x.substring(6);
					exh.setExh_startDate(date);

				}
				if (tag.equals("endDate")) {
					String x = xpp.getText();
					String date = x.substring(0, 4)+"/"+x.substring(4, 6)+"/"+x.substring(6);
					exh.setExh_endDate(date);

				}
				if (tag.equals("place")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}				
					exh.setExh_place(x);

				}
				if (tag.equals("realmName")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_realmName(x);

				}
				if (tag.equals("area")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_area(x);

				}
				if (tag.equals("subTitle")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_subTitle(x);

				}
				if (tag.equals("price")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_price(x);

				}
//				if (tag.equals("contents1")) {
//					String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
//					String content = xpp.getText().replaceAll("\\p{Z}", "");
//					content = content.replaceAll("[a-zA-Z]", "");
//					content = content.replaceAll(match, "");
//
//					if (content.length() > 1700) {
//						exh.setExh_contents(content.substring(0, 1700));
//						if (content.length() > 3400) {
//							exh.setExh_contents1(content.substring(1701, 3400));					
//							if(content.length()>5100) {
//								exh.setExh_contents2(content.substring(3401,5100));
//							}else {
//								exh.setExh_contents2(content.substring(3401));
//							}
//						} else {
//							exh.setExh_contents1(content.substring(1701));
//						}
//					}else {
//						exh.setExh_contents(content);
//					}
//				}
				if (tag.equals("url")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_url(x);

				}
				if (tag.equals("phone")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_phone(x);
				}
				if (tag.equals("imgUrl")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_imgurl(x);
				}
				if (tag.equals("gpsX")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_gpsx(x);

				}
				if (tag.equals("gpsY")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_gpsy(x);

				}
				if (tag.equals("placeUrl")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_placeurl(x);
				}
				if (tag.equals("placeAddr")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_placeaddr(x);

				}
				if (tag.equals("placeSeq")) {
					String x = xpp.getText();
					if(x==null || x=="") {
						x= "정보없음";
					}
					exh.setExh_placeseq(x);
				}
			} else if (event_type == XmlPullParser.END_TAG) {
				tag = xpp.getName();
				if (tag.equals("perforInfo")) {
					list.add(exh);
				}
			}
			event_type = xpp.next();
		}
		return exh;
	}


}
