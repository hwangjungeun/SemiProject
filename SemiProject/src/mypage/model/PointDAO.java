package mypage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

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
		
	/*
	// 포인트 테이블에서 총 포인트 가져오기
	@Override
	public int getPointSumInfo(String userid) throws SQLException {
		
		int point_sum =0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select fk_odrcode, trunc(end_day - sysdate) AS period " + 
						 " from tbl_point " + 
						 " where fk_userid= ? and p_status = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				String odrcode = rs.getString(1);
				
				if(rs.getInt(2) < 0) {
					sql = " update tbl_point set p_idle = 1 " +
						  " where fk_userid = ? and fk_odrcode = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, userid );
					pstmt.setString(2, odrcode );
					
					pstmt.executeUpdate();
				}
				
			}
			
			sql = " select sum(point) " + 
				  " from tbl_point " + 
				  " where fk_userid= ? and p_status = 0 and p_idle = 0 ";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				point_sum = rs.getInt(1);
			}
			 
		} finally {
			close();
		}
		
		return point_sum;
	} */

	@Override
	public Map<String, Integer> getPointInfo(String userid) throws SQLException {
		
		Map<String, Integer> pointMap = new HashMap<>();
		
		try {
			
			conn = ds.getConnection();
			
			/////////////////////////////////////////////////////////////////////////////
			// 사용가능 적립금 구하기  (point_canuse)
			String sql = " select fk_odrcode, trunc(sysdate - start_day) AS s_period, trunc(end_day - sysdate) AS e_period " + 
						 " from tbl_point " + 
						 " where fk_userid= ? and p_status = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				String odrcode = rs.getString(1);		
				
				if(rs.getInt(2) < 20  || rs.getInt(3) < 0) {
					// 등록일이 20일 미만이거나 마감일이 지난 포인트는 사용할 수 없음

					sql = " update tbl_point set p_idle = 1 " +
						  " where fk_userid = ? and fk_odrcode = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, userid );
					pstmt.setString(2, odrcode );
					
					pstmt.executeUpdate();
				}
				else {
					sql = " update tbl_point set p_idle = 0 " +
						  " where fk_userid = ? and fk_odrcode = ? ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, userid );
					pstmt.setString(2, odrcode );
					
					pstmt.executeUpdate();
				}
				
			}
			
			sql = " select sum(point) " + 
				  " from tbl_point " + 
				  " where fk_userid= ? and p_status = 0 and p_idle = 0 ";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int point_canuse = rs.getInt(1);
				
				pointMap.put("point_canuse", point_canuse);
			}
			
			
			//////////////////////////////////////////////////////////////////////////
			// 사용된 적립금 구하기 (point_used)
			sql = " select nvl(sum(point),0) " + 
				  " from tbl_point " + 
				  " where fk_userid = ? and p_status = 1 and p_idle = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				int point_used = rs.getInt(1);
				
				pointMap.put("point_used", point_used);
				
			}
			
			//////////////////////////////////////////////////////////////////////////
			// 미가용 적립금 구하기 (point_unuse)
			sql = " select nvl(sum(point),0) " + 
				  " from tbl_point " + 
				  " where fk_userid = ? and p_status = 0 and trunc(sysdate - start_day) < 20 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				int point_unuse = rs.getInt(1);
				
				pointMap.put("point_unuse", point_unuse);
				
			}
			
			
			//////////////////////////////////////////////////////////////////////////
			// 총 적립금 구하기 (point_sum)
			
			int point_sum = pointMap.get("point_canuse") + pointMap.get("point_unuse");
			
			pointMap.put("point_sum", point_sum);
			
//			System.out.println(pointMap.get("point_sum")+","+pointMap.get("point_canuse")+","+pointMap.get("point_used") +","+pointMap.get("point_unuse") );
			 
		} finally {
			close();
		}
		
		return pointMap;
	}

}
