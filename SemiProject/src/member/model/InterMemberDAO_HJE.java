
package member.model;

import java.sql.SQLException;

public interface InterMemberDAO_HJE {
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다) 
	boolean idDuplicateCheck(String userid) throws SQLException;
	
	// EMAIL 중복검사 (tbl_member 테이블에서 email이 존재하면 true를 리턴해주고, email이 존재하지 않으면 false를 리턴한다) 
	boolean emailDuplicateCheck(String email) throws SQLException;

	// 회원가입을 해주는 메소드 (insert into tbl_member)
	int registerMember(MemberVO_HJE member) throws SQLException;
	
}
