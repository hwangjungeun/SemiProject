package mypage.model;

import java.sql.SQLException;

public interface InterPointDAO {

	// 포인트 테이블에서 총 포인트 가져오기
	int getPointInfo(String userid) throws SQLException;

}
