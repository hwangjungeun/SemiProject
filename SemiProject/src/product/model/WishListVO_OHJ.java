package product.model;

public class WishListVO_OHJ {
	
	private String wishseq; 	// 위시리스트번호
	private String fk_userid; 	// 회원아이디 
	private String fk_pseq; 	// 제품번호
	private String fk_opseq; 	// 옵션번호
	private String enrollmentday; // 등록일자
	
	
	private POptionVO_OHJ povo; // 부모테이블인 POptionVO_OHJ를 select용.
	private ProductVO_OHJ pvo;  // 부모테이블인 ProductVO_OHJ를 select용.
	
	public String getWishseq() {
		return wishseq;
	}
	
	public void setWishseq(String wishseq) {
		this.wishseq = wishseq;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public String getFk_pseq() {
		return fk_pseq;
	}
	
	public void setFk_pseq(String fk_pseq) {
		this.fk_pseq = fk_pseq;
	}
	
	public String getFk_opseq() {
		return fk_opseq;
	}
	
	public void setFk_opseq(String fk_opseq) {
		this.fk_opseq = fk_opseq;
	}

	public String getEnrollmentday() {
		return enrollmentday;
	}

	public void setEnrollmentday(String enrollmentday) {
		this.enrollmentday = enrollmentday;
	}

	////////////////////////////////////////////
	// select용
	public POptionVO_OHJ getPovo() {
		return povo;
	}

	public void setPovo(POptionVO_OHJ povo) {
		this.povo = povo;
	}
	// select용
	public ProductVO_OHJ getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_OHJ pvo) {
		this.pvo = pvo;
	}
	
	
}
