
package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO_HJE implements InterMemberDAO_HJE {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes;
	
	// 기본 생성자
	public MemberDAO_HJE() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");
			
			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKeysms 우리가 만든 비밀키
			
		} catch (NamingException e) {
			e.printStackTrace();
		}catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	}
		
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
		
	//ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql =" select userid "
					   + " from tbl_member "
					   + " where userid =? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();	// 행이 있으면(중복된 userid) true,
									// 행이 없으면(사용가능한 userid) false
					
		} finally {
			close();
		}
		
		
		return isExists;
	} // end of public boolean idDuplicateCheck(String userid)

	
	// EMAIL 중복검사 (tbl_member 테이블에서 email이 존재하면 true를 리턴해주고, email이 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql =" select email "
					   + " from tbl_member "
					   + " where email =? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			// "seokj@gmail.com" ==> aes.encrypt("seokj@gmail.com") 해서 암호화되어 DB에 저장되어 있는 값과 비교
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next();	// 행이 있으면(중복된 email) true,
									// 행이 없으면(사용가능한 email) false
					
		} catch (UnsupportedEncodingException |GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return isExists;
	}// end of public boolean emailDuplicateCheck(String email)
	
	
	// 회원가입을 해주는 메소드 생성
	@Override
	public int registerMember(MemberVO_HJE member) throws SQLException {

		int n = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress,"
					   + " birthday, height, weight, topsize, bottomsize) "     
	                   + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "; 			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd()));	// 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail()));
			// 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(5, aes.encrypt(member.getMobile()));
			// 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
			pstmt.setString(6, member.getPostcode());
	        pstmt.setString(7, member.getAddress());
	        pstmt.setString(8, member.getDetailaddress());
	        pstmt.setString(9, member.getExtraaddress());
	        pstmt.setString(10, member.getBirthday());
	        pstmt.setString(11, member.getHeight());
	        pstmt.setString(12, member.getWeight());
	        pstmt.setString(13, member.getTopsize());
	        pstmt.setString(14, member.getBottomsize());
	        
	        n= pstmt.executeUpdate();
			
		} catch (GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		} 
		
		return n;
	} // end of public int registerMember(MemberVO member)

}
