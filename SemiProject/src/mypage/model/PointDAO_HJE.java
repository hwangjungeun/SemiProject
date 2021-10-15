package mypage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class PointDAO_HJE implements InterPointDAO_HJE {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본 생성자
	public PointDAO_HJE() {
		
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
				
				if(rs.getInt(2) < 0  || rs.getInt(3) < 0) {
					// 시작일이 현재날짜보다 작거나 마감일이 지난 포인트는 사용할 수 없음

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
				  " where fk_userid = ? and p_status = 0 and trunc(sysdate - start_day) < 0 ";
			
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
	
	// 페이징 처리를 위한 전체포인트에 대한 총 페이지 알아오기
	@Override
	public int getTotalPage(String userid) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/5) " + 
						 " from tbl_point " + 
						 " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}

		
	// 페이징 처리를 한 포인트목록 보여주기
	@Override
	public List<PointVO_HJE> selectPagingPoint(Map<String, String> paraMap)  throws SQLException{
		
		List<PointVO_HJE> pointList =  new ArrayList<>();
		
		try {
			
				conn = ds.getConnection();
				// 주문날짜 적립금 관련주문 내용
				
				String sql = " select odrdate, point, fk_odrcode "+
							 " from "+
							 " ( "+
							 "    select rownum as rno, odrdate, point, fk_odrcode "+
							 "    from tbl_point "+
							 "    where fk_userid = ? "+
							 " ) "+
							 " where rno between ? and ? "+ 
							 " order by odrdate ";
				
				pstmt = conn.prepareStatement(sql);
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setInt(2, (currentShowPageNo * 5) - 4 );
				pstmt.setInt(3, (currentShowPageNo * 5));
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					PointVO_HJE pvo = new PointVO_HJE();
					
					pvo.setOdrdate(rs.getString(1));
					pvo.setPoint(rs.getInt(2));
					pvo.setFk_odrcode(rs.getString(3));
					
					pointList.add(pvo);
					
				}
			
		}finally {
			close();
		}
		
		return pointList;
	}

	/*
	// 미가용포인트목록 총 페이지 알아오기
	@Override
	public int getUnuseTotalPage(String userid) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/5) " + 
						 " from tbl_point " + 
						 " where fk_userid = ? and p_status = 0 and trunc(sysdate - start_day) < 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}
	*/
	
	// 페이징 처리를 한 미가용포인트목록 보여주기
	@Override
	public List<PointVO_HJE> selectPagingUnUsePoint(Map<String, String> paraMap) throws SQLException {

		List<PointVO_HJE> pointList =  new ArrayList<>();
		
		try {
			
				conn = ds.getConnection();
				// 주문날짜 적립금 관련주문 내용
				
				String sql = " select odrdate, start_day, point, fk_odrcode "+
						 	 " from "+
						 	 " ( "+
						 	 "    select rownum as rno, odrdate, start_day,  point, fk_odrcode "+
						 	 "    from tbl_point "+
						 	 "    where fk_userid = ? and p_status = 0 and trunc(sysdate - start_day) < 0 "+
						 	 " ) "+
//						 	 " where rno between ? and ? "+ 
						 	 " order by odrdate ";
				
				
				pstmt = conn.prepareStatement(sql);
				
//				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				
				pstmt.setString(1, paraMap.get("userid"));
//				pstmt.setInt(2, (currentShowPageNo * 5) - 4 );
//				pstmt.setInt(3, (currentShowPageNo * 5));
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					PointVO_HJE pvo = new PointVO_HJE();
					
					pvo.setOdrdate(rs.getString(1));
					pvo.setStart_day(rs.getString(2));
					pvo.setPoint(rs.getInt(3));
					pvo.setFk_odrcode(rs.getString(4));
					
					pointList.add(pvo);
					
				}
			
		}finally {
			close();
		}
		
		return pointList;
	}

	/*
	// 사용된 포인트목록 총 페이지 알아오기
	@Override
	public int getUsedTotalPage(String userid) throws SQLException {

		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/5) " + 
						 " from tbl_point " + 
						 " where fk_userid = ? and p_status = 1 and p_idle = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs=pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
		
	}// end of public int getUsedTotalPage(String userid)
	*/
	// 페이징 처리를 한 사용 된 포인트목록 보여주기
	@Override
	public List<PointVO_HJE> selectPagingUsedPoint(Map<String, String> paraMap) throws SQLException {

		List<PointVO_HJE> pointList =  new ArrayList<>();
		
		try {
			
				conn = ds.getConnection();
				// 주문날짜 적립금 관련주문 내용
				
				String sql = " select odrdate, start_day, point, fk_odrcode "+
						 	 " from "+
						 	 " ( "+
						 	 "    select rownum as rno, odrdate, start_day,  point, fk_odrcode "+
						 	 "    from tbl_point "+
						 	 "    where fk_userid = ? and p_status = 1 and p_idle = 0 "+
						 	 " ) "+
//						 	 " where rno between ? and ? "+ 
						 	 " order by odrdate ";
				
				
				pstmt = conn.prepareStatement(sql);
				
//				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				
				pstmt.setString(1, paraMap.get("userid"));
//				pstmt.setInt(2, (currentShowPageNo * 5) - 4 );
//				pstmt.setInt(3, (currentShowPageNo * 5));
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					PointVO_HJE pvo = new PointVO_HJE();
					
					pvo.setOdrdate(rs.getString(1));
					pvo.setStart_day(rs.getString(2));
					pvo.setPoint(rs.getInt(3));
					pvo.setFk_odrcode(rs.getString(4));
					
					pointList.add(pvo);
					
				}
			
		}finally {
			close();
		}
		
		return pointList;
		
	} // end of public List<PointVO_HJE> selectPagingUsedPoint(Map<String, String> paraMap)

}
