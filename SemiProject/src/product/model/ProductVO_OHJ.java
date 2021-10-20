package product.model;

public class ProductVO_OHJ {
	
	private String pseq; 		// 제품번호
	private String fk_clseq; 	// 카테고리하위번호
	private String pname; 		// 제품명
	private String pimage; 		// 제품이미지
	private int price; 			// 제품정가
	private String pcontent; 	// 제품설명
	private int point; 			// 포인트점수
	private String pinputdate; 	// 제품입고일자
	
	public String getPseq() {
		return pseq;
	}
	
	public void setPseq(String pseq) {
		this.pseq = pseq;
	}
	
	public String getFk_clseq() {
		return fk_clseq;
	}
	
	public void setFk_clseq(String fk_clseq) {
		this.fk_clseq = fk_clseq;
	}
	
	public String getPname() {
		return pname;
	}
	
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	public String getPimage() {
		return pimage;
	}
	
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
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
