package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO_PJW {
	

	
	// 입력받은 paraMap을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인처리)
	MemberVO_PJW selectOneMember(Map<String, String> paraMap) throws SQLException;

	// 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다.)
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려준다.)
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;

	// 암호 변경하기 
	int pwdUpdate(Map<String, String> paraMap) throws SQLException;

	// 회원의 개인 정보 변경하기
	int updateMember(MemberVO_PJW member) throws SQLException;

	
}
