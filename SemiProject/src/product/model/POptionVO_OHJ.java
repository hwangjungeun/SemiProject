package product.model;

public class POptionVO_OHJ {
	
	private String opseq; 	// 옵션번호
	private String fk_pseq; // 제품번호
	private String fk_cseq; // 색상번호
	private String cimage; 	// 색상이미지
	private int cnt; 		// 옵션재고량
	
	private PColorVO_OHJ pcvo; // 부모테이블인 PColorVO_OHJ를 select용.
	private ProductVO_OHJ pvo; // 부모테이블인 ProductVO_OHJ를 select용.

	
	public String getOpseq() {
		return opseq;
	}

	public void setOpseq(String opseq) {
		this.opseq = opseq;
	}

	public String getFk_pseq() {
		return fk_pseq;
	}

	public void setFk_pseq(String fk_pseq) {
		this.fk_pseq = fk_pseq;
	}

	public String getFk_cseq() {
		return fk_cseq;
	}

	public void setFk_cseq(String fk_cseq) {
		this.fk_cseq = fk_cseq;
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

	////////////////////////////////////////////
	// select용
	public PColorVO_OHJ getPcvo() {
		return pcvo;
	}

	public void setPcvo(PColorVO_OHJ pcvo) {
		this.pcvo = pcvo;
	}
	// select용
	public ProductVO_OHJ getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_OHJ pvo) {
		this.pvo = pvo;
	}

	
}
