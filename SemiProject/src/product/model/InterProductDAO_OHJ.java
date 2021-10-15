package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO_OHJ {

	// == 최근본상품 == //
	
	// 최근본상품 목록을 조회(select)하는 메소드
	List<RecentViewProdVO_OHJ> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException;

	// 제품번호를 이용해서 옵션(색상의 종류)을 조회(select)하는 메소드
	List<Map<String, String>> viewColorOption(String pseq) throws SQLException;
	
	// 최근본상품에서 해당제품의 목록을 삭제(delete)하는 메소드
	boolean deleteRecentViewProd(String recentseq) throws SQLException;
	
	// 페이지바를 만들기 위해서 해당userid의 최근본상품 목록에 대한 총페이지수 알아오기(select) 
	int getRecentTotalPage(String userid) throws SQLException;
	
	
	
	
	// == 위시리스트 == //
	
	// 위시리스트 목록을 조회(select)하는 메소드
	List<WishListVO_OHJ> selectWishList(Map<String, String> paraMap) throws SQLException;

	// 위시리스트에서 해당제품의 목록을 삭제(delete)하는 메소드
	boolean deleteWishList(String wishseq) throws SQLException;
	
	// 페이지바를 만들기 위해서 해당userid의 위시리스트 목록에 대한 총페이지수 알아오기(select) 
	int getWishTotalPage(String userid) throws SQLException;
	
	// 위시리스트에서 해당 사용자의 위시리스트를 비우는(delete) 메소드
	boolean deleteAllWishList(String fk_userid) throws SQLException;
	
	
	
	
	// == 주문== //
	// 옵션번호를 이용하여 주문하고자 하는 내역을 조회(select)하는 메소드
//	List<POptionVO_OHJ> selectOrderList(Map<String, String> paraMap) throws SQLException;

	
	
	
	
	
	// 장바구니번호를 이용하여 fk_opseq(옵션번호)와 oqty(주문량)을 조회(select)하는 메소드
	Map<String, String> selectFromCart(String cartseq) throws SQLException;

	// 주문진행중 테이블에 insert하는 메소드
	int insertOdrProg(Map<String,String> map) throws SQLException;

	// 주문원하는테이블인 tbl_orderProgress을 이용해, 주문서폼이 원하는 정보(이미지,제품명,옵션컬러명,가격,수량,적립금)인 orderProgList를 보내준다.
	List<OrderProgressVO_OHJ> showOdrProg() throws SQLException;

	

	

	

	

	

}
