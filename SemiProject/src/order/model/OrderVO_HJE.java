package order.model;

public class OrderVO_HJE {
	
	private String odrcode;		// 위시리스트번호
	private String fk_userid;	// 회원아이디
	private int odrtotalprice;	// 제품번호
	private String odrdate;		// 옵션번호
	
	public String getOdrcode() {
		return odrcode;
	}

	public void setOdrcode(String odrcode) {
		this.odrcode = odrcode;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getOdrtotalprice() {
		return odrtotalprice;
	}

	public void setOdrtotalprice(int odrtotalprice) {
		this.odrtotalprice = odrtotalprice;
	}
	public String getOdrdate() {
		return odrdate;
	}

	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
	}

}
