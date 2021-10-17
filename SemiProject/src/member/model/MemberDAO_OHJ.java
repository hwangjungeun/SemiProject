package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class MemberDAO_OHJ implements InterMemberDAO_OHJ {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO_OHJ() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 는 우리가 만든 비밀키이다.
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
    	try {
    		if(rs != null)    {rs.close();    rs=null;}
    		if(pstmt != null) {pstmt.close(); pstmt=null;}
    		if(conn != null)  {conn.close();  conn=null;}
    	} catch(SQLException e) {
    		e.printStackTrace();
    	}
    }

    ////////////////////////////////////////////////////////////////////////////////////
    
    
    // 회원정보를 조회해서 뷰단에 보낸다.(getParameter로 넘어온 userid를 이용) -> 회원명,(포인트),주소,연락처,이메일
	@Override
	public MemberVO_OHJ showMemberInfo(String userid) throws SQLException {
		
		MemberVO_OHJ member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select name, postcode, address, detailaddress, extraaddress, mobile, email, userid " + 
						 " from tbl_member " + 
						 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO_OHJ();
				
				member.setName(rs.getString(1));
				member.setPostcode(rs.getString(2));
				member.setAddress(rs.getString(3));
				member.setDetailaddress(rs.getString(4));
				member.setExtraaddress(rs.getString(5));
				member.setMobile(aes.decrypt(rs.getString(6))); // 복호화
				member.setEmail(aes.decrypt(rs.getString(7))); // 복호화
				member.setUserid(rs.getString(8));
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return member;
	}// end of public MemberVO_OHJ showMemberInfo(String userid)----------------------------
    
  
	
}
