package hwarang.artg.rrboard.model;

public class NaverReiewDTO {
	//postdate	datetime	블로그 포스트를 작성한 날짜이다.
	//display	integer	검색된 검색 결과의 개수이다.
	//title	string	검색 결과 문서의 제목을 나타낸다. 제목에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
	//link	string	검색 결과 문서의 하이퍼텍스트 link를 나타낸다.
	//description	string	검색 결과 문서의 내용을 요약한 패시지 정보이다. 문서 전체의 내용은 link를 따라가면 읽을 수 있다. 패시지에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
	private String postdate;
	private int display;
	private String title;
	private String link;
	private String description;
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public int getDisplay() {
		return display;
	}
	public void setDisplay(int display) {
		this.display = display;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "NaverReiew [postdate=" + postdate + ", display=" + display + ", title=" + title + ", link=" + link
				+ ", description=" + description + "]";
	}
	
}
