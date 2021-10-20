package product.model;

public class RecentViewProdVO_OHJ {
	
	private String recentseq; // 최근본상품번호
	private String fk_userid; // 회원아이디 
	private String fk_pseq;   // 제품번호
	private String viewday;   // 최근본일자
	
	private ProductVO_OHJ pvo; 	// 부모테이블인 ProductVO를 select용.(tbl_product와 tbl_recentViewProduct의 JOIN) 
							    // 제품에 대한 모든 정보가 들어옴
	
	public String getRecentseq() {
		return recentseq;
	}
	
	public void setRecentseq(String recentseq) {
		this.recentseq = recentseq;
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
	
	public String getViewday() {
		return viewday;
	}
	
	public void setViewday(String viewday) {
		this.viewday = viewday;
	}

	////////////////////////////////////////////
	// select용
	public ProductVO_OHJ getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO_OHJ pvo) {
		this.pvo = pvo;
	}
	
	
}
