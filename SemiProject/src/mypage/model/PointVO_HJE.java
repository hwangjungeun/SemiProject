package mypage.model;


public class PointVO_HJE {
	private String fk_odrcode;	// 주문코드
	private String fk_userid;	// 회원아이디
	private String odrdate;	// 주문일
	private String start_day;
	private String end_day;
	private int p_status;
	private int p_idle;
	private int point;
	
	
	public String getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getStart_day() {
		return start_day;
	}
	public void setStart_day(String start_day) {
		this.start_day = start_day;
	}
	public String getEnd_day() {
		return end_day;
	}
	public void setEnd_day(String end_day) {
		this.end_day = end_day;
	}
	public int getP_status() {
		return p_status;
	}
	public void setP_status(int p_status) {
		this.p_status = p_status;
	}
	public int getP_idle() {
		return p_idle;
	}
	public void setP_idle(int p_idle) {
		this.p_idle = p_idle;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getOdrdate() {
		return odrdate;
	}
	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
	}	
	
}
