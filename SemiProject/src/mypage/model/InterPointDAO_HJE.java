package mypage.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterPointDAO_HJE {

	// 포인트 테이블에서 총 포인트 가져오기
	// int getPointSumInfo(String userid) throws SQLException;

	// 종류별 point Map에 담기
	Map<String, Integer> getPointInfo(String userid) throws SQLException;

	// 페이징 처리를 위한 전체포인트에 대한 총 페이지 알아오기
	int getTotalPage(String userid) throws SQLException;

	// 페이징 처리를 한 포인트목록 보여주기
	List<PointVO_HJE> selectPagingPoint(Map<String, String> paraMap) throws SQLException;

	// 미가용포인트목록 총 페이지 알아오기
//	int getUnuseTotalPage(String userid) throws SQLException;

	// 페이징 처리를 한 미가용포인트목록 보여주기
	List<PointVO_HJE> selectPagingUnUsePoint(Map<String, String> paraMap) throws SQLException;

	// 사용된 포인트목록 총 페이지 알아오기
//	int getUsedTotalPage(String userid) throws SQLException;

	// 페이징 처리를 한 사용 된 포인트목록 보여주기
	List<PointVO_HJE> selectPagingUsedPoint(Map<String, String> paraMap) throws SQLException;

}
