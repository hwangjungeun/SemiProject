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
	
	
	
	
	// == 위시리스트 == //
	// 위시리스트 목록을 조회(select)하는 메소드
	List<WishListVO_OHJ> selectWishList(Map<String, String> paraMap) throws SQLException;

	
	
	
	// == 주문== //
	// 옵션번호를 이용하여 주문하고자 하는 내역을 조회(select)하는 메소드
	List<POptionVO_OHJ> selectOrderList(Map<String, String> paraMap) throws SQLException;

	

}
