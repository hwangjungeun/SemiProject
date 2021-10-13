package order.model;

public class OderdetailVO_HJE {
	
	private int odrseqnum;
	private String fk_odrcode;
	private int fk_pseq;
	private int oqty;
	private int odrprice;
	private int deliverstatus;
	private String deliverdate;
	public int getOdrseqnum() {
		return odrseqnum;
	}
	public void setOdrseqnum(int odrseqnum) {
		this.odrseqnum = odrseqnum;
	}
	public String getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	public int getFk_pseq() {
		return fk_pseq;
	}
	public void setFk_pseq(int fk_pseq) {
		this.fk_pseq = fk_pseq;
	}
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public int getOdrprice() {
		return odrprice;
	}
	public void setOdrprice(int odrprice) {
		this.odrprice = odrprice;
	}
	public int getDeliverstatus() {
		return deliverstatus;
	}
	public void setDeliverstatus(int deliverstatus) {
		this.deliverstatus = deliverstatus;
	}
	public String getDeliverdate() {
		return deliverdate;
	}
	public void setDeliverdate(String deliverdate) {
		this.deliverdate = deliverdate;
	}
	
}
