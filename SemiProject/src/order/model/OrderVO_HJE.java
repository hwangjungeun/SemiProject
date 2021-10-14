package order.model;

public class OrderVO_HJE {
	
	private String odrcode;
	private String fk_userid;
	private int odrtotalprice;
	private int odrtotalpoint;
	private String odrdate;
	
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

	public int getOdrtotalpoint() {
		return odrtotalpoint;
	}

	public void setOdrtotalpoint(int odrtotalpoint) {
		this.odrtotalpoint = odrtotalpoint;
	}

	public String getOdrdate() {
		return odrdate;
	}

	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
	}

}
