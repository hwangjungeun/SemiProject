package order.model;

import product.model.PColorVO_OHJ;
import product.model.ProductVO_OHJ;

public class OrderdetailVO_HJE {
	
	private int odrseqnum;		// 주문상세일련번호
	private String fk_odrcode;	// 주문코드
	private int fk_pseq;		// 제품번호
	private int oqty;			// 주문량
	private int odrprice;		// 주문가격
	private int deliverstatus;	// 배송상태 ( 0이면 배송전, 1이면 배송중, 2이면 배송완료 )
	private int cancelstatus;	// 상태 ( 0이면 정상처리, 1이면 취소, 2이면 교환, 3이면 반품 )
	private String deliverdate; // 배송완료일자
	
	private ProductVO_OHJ pvo;
	private OrderVO_HJE ovo;
	private PColorVO_OHJ pcvo;
	
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
	
	public int getCancelstatus() {
		return cancelstatus;
	}
	public void setCancelstatus(int cancelstatus) {
		this.cancelstatus = cancelstatus;
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
	public ProductVO_OHJ getPvo() {
		return pvo;
	}
	public void setPvo(ProductVO_OHJ pvo) {
		this.pvo = pvo;
	}
	public OrderVO_HJE getOvo() {
		return ovo;
	}
	public void setOvo(OrderVO_HJE ovo) {
		this.ovo = ovo;
	}
	public PColorVO_OHJ getPcvo() {
		return pcvo;
	}
	public void setPcvo(PColorVO_OHJ pcvo) {
		this.pcvo = pcvo;
	}
	
	
	
}
