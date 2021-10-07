package mypage.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterPointDAO {

	// 포인트 테이블에서 총 포인트 가져오기
	//int getPointSumInfo(String userid) throws SQLException;
	
	// 종류별 point Map에 담기
	Map<String, Integer> getPointInfo(String userid)  throws SQLException;

}
