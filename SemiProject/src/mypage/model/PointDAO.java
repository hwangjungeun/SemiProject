package mypage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class PointDAO implements InterPointDAO {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본 생성자
	public PointDAO() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");
			
			
		} catch (NamingException e) {
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
		
	
	// 포인트 테이블에서 총 포인트 가져오기
	@Override
	public int getPointInfo(String userid) throws SQLException {
		
		int point_sum =0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select sum(point) "+
						 " from "+
						 " ( "+
						 "    select point, trunc(months_between(end_day, sysdate)) AS period\n"+
						 "    from tbl_point "+
						 "    where fk_userid= ? and p_status = 0 "+
						 " ) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				point_sum = rs.getInt(1);
			}
			
			
		} finally {
			close();
		}
		
		return point_sum;
	}

}
