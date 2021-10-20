package member.model;

import java.sql.SQLException;
import java.util.List;

public interface InterMemberDAO_OHJ {

	// 회원정보를 조회하는 메소드(getParameter로 넘어온 userid를 이용)
	MemberVO_OHJ showMemberInfo(String userid) throws SQLException;

	// 해당user의 포인트에 대한 총합 구하는 메소드
	int showTotalPoint(String userid) throws SQLException;

	// 사용가능한 적립금 목록을 select하는 메소드
	List<PointVO_OHJ> showUsablePoint(String userid) throws SQLException;

}
