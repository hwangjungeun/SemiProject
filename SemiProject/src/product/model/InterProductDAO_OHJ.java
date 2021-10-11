package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO_OHJ {

	// 최근본상품 목록을 조회(select)하는 메소드
	List<RecentViewProdVO_OHJ> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException;

	// 제품번호를 이용해서 옵션(색상의 종류)을 조회(select)하는 메소드
	List<Map<String, String>> viewColorOption(String pseq) throws SQLException;

}
