package order.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterOrderDAO_HJE {

	// 페이징처리를 한 주문리스트를 select해 온다.
	List<OrderdetailVO_HJE> selectPagingOrder(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 주문에 대한 총 페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 총 주문 개수 구하기
	int getCountAllOrder(Map<String, String> paraMap) throws SQLException;

	

}
