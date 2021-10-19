package order.model;

public class OrderVO_HJE {
	
	private String odrcode;		// 주문코드
	private String fk_userid;	// 회원아이디
	private int odrtotalprice;	// 제품번호
	private String odrdate;		// 옵션번호
	private int totalquantity;		// 총 주문 수량
	private int totalproduct;		// 총 상품 수량
	
	
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

	public int getTotalquantity() {
		return totalquantity;
	}

	public void setTotalquantity(int totalquantity) {
		this.totalquantity = totalquantity;
	}

	public int getTotalproduct() {
		return totalproduct;
	}

	public void setTotalproduct(int totalproduct) {
		this.totalproduct = totalproduct;
	}
	
	

}
