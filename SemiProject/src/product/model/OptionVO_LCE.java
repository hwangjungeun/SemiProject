package product.model;

public class OptionVO_LCE {
	
	private String opseq;
	private String cimage;
	private int cnt;

	
	private ProductVO_LCE fk_pseq;
	private ColorVO_LCE fk_cseq;
	
	
	private int totalPrice; //수업에서 배운것 productvo 참고하기!! 
	private int totalPoint;
	
	
	
	public String getOpseq() {
		return opseq;
	}
	
	public void setOpseq(String opseq) {
		this.opseq = opseq;
	}
	
	public String getCimage() {
		return cimage;
	}
	
	public void setCimage(String cimage) {
		this.cimage = cimage;
	}
	
	public int getCnt() {
		return cnt;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public ProductVO_LCE getFk_pseq() {
		return fk_pseq;
	}
	
	public void setFk_pseq(ProductVO_LCE fk_pseq) {
		this.fk_pseq = fk_pseq;
	}
	
	public ColorVO_LCE getFk_cseq() {
		return fk_cseq;
	}
	
	public void setFk_cseq(ColorVO_LCE fk_cseq) {
		this.fk_cseq = fk_cseq;
	}

	
}
