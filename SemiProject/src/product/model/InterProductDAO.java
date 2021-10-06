package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	// 최근본상품 목록을 조회(select)하는 메소드
	List<RecentViewProdVO> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException;

}
