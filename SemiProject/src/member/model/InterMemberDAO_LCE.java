package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO_LCE {
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다) 
	boolean idDuplicateCheck(String userid) throws SQLException;
	
	// EMAIL 중복검사 (tbl_member 테이블에서 email이 존재하면 true를 리턴해주고, email이 존재하지 않으면 false를 리턴한다) 
	boolean emailDuplicateCheck(String email) throws SQLException;

	// 회원가입을 해주는 메소드 (insert into tbl_member)
	int registerMember(MemberVO_LCE member) throws SQLException;
	
	// 입력받은 paraMap을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인처리)
	MemberVO_LCE selectOneMember(Map<String, String> paraMap) throws SQLException;

	// 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다.)
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려준다.)
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;

	// 암호 변경하기 
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;
	
	// DB에 회원의 코인 및 포인트 증가하기
	int coinUpdate(Map<String, String> paraMap) throws SQLException;

	// 회원의 개인 정보 변경하기
	int updateMember(MemberVO_LCE member) throws SQLException;

	
}
