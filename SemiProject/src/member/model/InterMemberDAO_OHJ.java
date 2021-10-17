package member.model;

import java.sql.SQLException;

public interface InterMemberDAO_OHJ {

	// 회원정보를 조회해서 뷰단에 보낸다.(getParameter로 넘어온 userid를 이용)
	MemberVO_OHJ showMemberInfo(String userid) throws SQLException;

}
