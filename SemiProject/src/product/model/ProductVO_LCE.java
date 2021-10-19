package product.model;

public class ProductVO_LCE {
	
	private String 	pseq;
	private String 	fk_clseq; // CategoryLVO로 바꿔야함
	private String  pname;
	private String  pimage;
	private int 	price;
	private String  pcontent;
	private int     point;
	private String  pinputdate;
	
	
	
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
