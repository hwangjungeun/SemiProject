package product.model;

public class ProductVO {
	
	
	private String pseq;		// 제품번호
	private String pname;   	// 제품명
	private String fk_cseq; 	// 카테고리대분류번호
	private String pimage1; 	// 제품이미지1
	private String pimage2; 	// 제품이미지2
	private int pqty;     		// 제품재고량
	private int price;    		// 제품정가
	private String fk_sseq; 	// 스펙번호
	private String pcontent;	// 제품설명
	private int point; 			// 포인트점수
	private String pinputdate;	// 제품입고일자
	
	
	public String getPseq() {
		return pseq;
	}
	
	public void setPseq(String pseq) {
		this.pseq = pseq;
	}
	
	public String getPname() {
		return pname;
	}
	
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	public String getFk_cseq() {
		return fk_cseq;
	}
	
	public void setFk_cseq(String fk_cseq) {
		this.fk_cseq = fk_cseq;
	}
	
	public String getPimage1() {
		return pimage1;
	}
	
	public void setPimage1(String pimage1) {
		this.pimage1 = pimage1;
	}
	
	public String getPimage2() {
		return pimage2;
	}
	
	public void setPimage2(String pimage2) {
		this.pimage2 = pimage2;
	}
	
	public int getPqty() {
		return pqty;
	}
	
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}
	
	public String getFk_sseq() {
		return fk_sseq;
	}
	
	public void setFk_sseq(String fk_sseq) {
		this.fk_sseq = fk_sseq;
	}
	
	public String getPcontent() {
		return pcontent;
	}
	
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	
	public int getPoint() {
		return point;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public String getPinputdate() {
		return pinputdate;
	}
	
	public void setPinputdate(String pinputdate) {
		this.pinputdate = pinputdate;
	}
	
	
}
