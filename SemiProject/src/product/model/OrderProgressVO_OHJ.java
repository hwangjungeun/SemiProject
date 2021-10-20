package product.model;

public class OrderProgressVO_OHJ {
	
	private String odrProseq; // 주문진행번호
	private String fk_opseq; // 옵션번호
	private String fk_userid; // 회원아이디
	private int wishoqty; // 구매수량
	
	private POptionVO_OHJ povo; // 부모테이블인 POptionVO_OHJ를 select용.
	
	public String getOdrProseq() {
		return odrProseq;
	}
	
	public void setOdrProseq(String odrProseq) {
		this.odrProseq = odrProseq;
	}
	
	public String getFk_opseq() {
		return fk_opseq;
	}
	
	public void setFk_opseq(String fk_opseq) {
		this.fk_opseq = fk_opseq;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public int getWishoqty() {
		return wishoqty;
	}
	
	public void setWishoqty(int wishoqty) {
		this.wishoqty = wishoqty;
	}

	////////////////////////////////////////////
	// select용
	public POptionVO_OHJ getPovo() {
		return povo;
	}

	public void setPovo(POptionVO_OHJ povo) {
		this.povo = povo;
	}
	
	
}
