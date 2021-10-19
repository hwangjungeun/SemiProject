package order.model;

import product.model.OptionVO_LCE;
import product.model.ProductVO_LCE;

public class CartVO_LCE {

	private String cartseq; //장바구니번호
	private int oqty; 		//수량
	private String registerday; //입력일자

	private String fk_userid; // 회원아이디
	private ProductVO_LCE fk_pseq; // 제품번호
	private OptionVO_LCE fk_opseq; //옵션번호 
	
	private String cname; // 옵션의 색상번호 (원래 colorvo를 가져와야하지만 컬럼이 이것만 필요해서 그냥 이렇게 씀)
	
	
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCartseq() {
		return cartseq;
	}
	
	public void setCartseq(String cartseq) {
		this.cartseq = cartseq;
	}
	
	public int getOqty() {
		return oqty;
	}
	
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	
	public String getRegisterday() {
		return registerday;
	}
	
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public ProductVO_LCE getFk_pseq() {
		return fk_pseq;
	}
	
	public void setFk_pseq(ProductVO_LCE fk_pseq) {
		this.fk_pseq = fk_pseq;
	}
	
	public OptionVO_LCE getFk_opseq() {
		return fk_opseq;
	}
	
	public void setFk_opseq(OptionVO_LCE fk_opseq) {
		this.fk_opseq = fk_opseq;
	}
	
	
	
	
}
