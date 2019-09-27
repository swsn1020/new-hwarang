package hwarang.artg.community.model;

public class TicketImageVO {
	private String ticketuuid;
	private int ticketnum;
	private String uploadpath;
	private String filename;
	
	public String getTicketuuid() {
		return ticketuuid;
	}
	public void setTicketuuid(String ticketuuid) {
		this.ticketuuid = ticketuuid;
	}
	public int getTicketnum() {
		return ticketnum;
	}
	public void setTicketnum(int ticketnum) {
		this.ticketnum = ticketnum;
	}
	public String getUploadpath() {
		return uploadpath;
	}
	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "TicketImageVO [ticketuuid=" + ticketuuid + ", ticketnum=" + ticketnum + ", uploadpath=" + uploadpath
				+ ", filename=" + filename + "]";
	}
}
