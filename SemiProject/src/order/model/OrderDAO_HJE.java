package order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import product.model.ProductVO_OHJ;

public class OrderDAO_HJE implements InterOrderDAO_HJE {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본 생성자
	public OrderDAO_HJE() {
		
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
		
	
	
	// 페이징처리를 한 주문리스트를 select해 온다.
	@Override
	public List<OrderdetailVO_HJE> selectPagingOrder(Map<String, String> paraMap) throws SQLException{
		
		List<OrderdetailVO_HJE> orderList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select fk_odrcode, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus " + 
						 " from " + 
						 " ( " + 
						 "    select rownum as rno, fk_odrcode, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus, odrdate " + 
						 "    from " + 
						 "    (  " + 
						 "        select fk_odrcode, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus " + 
						 "        from tbl_product P join tbl_orderdetail D " + 
						 "        on p.pseq = D.fk_pseq " + 
						 "    )A JOIN tbl_order O " + 
						 "    ON A.fk_odrcode = O.odrcode " + 
						 "    where fk_userid= ? ";
			
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd') ";
			}
				  sql += " ) " + 
						 " where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			
			pstmt.setString(1, paraMap.get("userid"));
			
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				pstmt.setString(2, paraMap.get("date1"));
				pstmt.setString(3, paraMap.get("date2"));
				pstmt.setInt(4, (currentShowPageNo * 5) - 4 );
				pstmt.setInt(5, (currentShowPageNo * 5));
			}
			else {
				pstmt.setInt(2, (currentShowPageNo * 5) - 4 );
				pstmt.setInt(3, (currentShowPageNo * 5));
			}
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderdetailVO_HJE odvo = new OrderdetailVO_HJE();
				odvo.setFk_odrcode(rs.getString(1));
				
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				pvo.setPimage(rs.getString(2));
				pvo.setPname(rs.getString(3));
				
				odvo.setPvo(pvo);
				
				odvo.setOqty(rs.getInt(4));
				odvo.setOdrprice(rs.getInt(5));
				odvo.setDeliverstatus(rs.getInt(6));
				odvo.setCancelstatus(rs.getInt(7));
				
				orderList.add(odvo);
			}
			
		} finally {
			close();
		}
		
		return orderList;
	}// end of public List<OrderdetailVO_HJE> selectPagingOrder(Map<String, String> paraMap)

	// 페이징 처리를 위한 주문에 대한 총 페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage=0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/5) " + 
						 " from tbl_orderdetail D JOIN tbl_order O " + 
						 " ON d.fk_odrcode = O.odrcode " + 
						 " where fk_userid= ? ";
							
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd') ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				pstmt.setString(2, paraMap.get("date1"));
				pstmt.setString(3, paraMap.get("date2"));
			}
			
			rs= pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return totalPage;
	}

	// 총 주문 개수 구하기
	@Override
	public int getCountAllOrder(Map<String, String> paraMap) throws SQLException {
		int allorder=0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) " + 
						 " from tbl_orderdetail D JOIN tbl_order O " + 
						 " ON d.fk_odrcode = O.odrcode " + 
						 " where fk_userid= ? ";
							
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd') ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			if( ("".equals(paraMap.get("date1")) || "".equals(paraMap.get("date2"))) ) {
				pstmt.setString(2, paraMap.get("date1"));
				pstmt.setString(3, paraMap.get("date2"));
			}
			
			rs= pstmt.executeQuery();
			
			rs.next();
			
			allorder = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return allorder;
	} 

}
