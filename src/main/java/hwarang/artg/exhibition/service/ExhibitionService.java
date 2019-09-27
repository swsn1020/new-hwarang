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
					exh.setExh_title(xpp.getText());

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
					exh.setExh_place(xpp.getText());

				}
				if (tag.equals("realmName")) {
					exh.setExh_realmName(xpp.getText());

				}
				if (tag.equals("area")) {
					exh.setExh_area(xpp.getText());

				}
				if (tag.equals("subTitle")) {
					exh.setExh_subTitle(xpp.getText());

				}
				if (tag.equals("price")) {
					exh.setExh_price(xpp.getText());

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
					exh.setExh_url(xpp.getText());

				}
				if (tag.equals("phone")) {
					exh.setExh_phone(xpp.getText());
				}
				if (tag.equals("imgUrl")) {
					exh.setExh_imgurl(xpp.getText());
				}
				if (tag.equals("gpsX")) {
					exh.setExh_gpsx(xpp.getText());

				}
				if (tag.equals("gpsY")) {
					exh.setExh_gpsy(xpp.getText());

				}
				if (tag.equals("placeUrl")) {
					exh.setExh_placeurl(xpp.getText());

				}
				if (tag.equals("placeAddr")) {
					exh.setExh_placeaddr(xpp.getText());

				}
				if (tag.equals("placeSeq")) {
					exh.setExh_placeseq(xpp.getText());
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

	public Date transformDate(String date) {
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyymmdd");

		// Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
		SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");

		java.util.Date tempDate = null;

		try {
			// 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
			tempDate = beforeFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
		String transDate = afterFormat.format(tempDate);

		// 반환된 String 값을 Date로 변경한다.
		Date d = Date.valueOf(transDate);

		return d;
	}

}
