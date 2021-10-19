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

import product.model.PColorVO_OHJ;
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
			
			String sql = " select fk_odrcode, pimage, pname ,totalquantity , odrtotalprice, totalproduct " + 
					"from \r\n" + 
					"( \r\n" + 
					"    select rownum as rno, fk_odrcode, pimage, pname ,totalquantity, odrtotalprice, odrdate, rank, (select count(*) from tbl_orderdetail where fk_odrcode = A.fk_odrcode  group by fk_odrcode) as totalproduct " + 
					"    from \r\n" + 
					"    (  \r\n" + 
					"        select fk_odrcode, pimage, pname, RANK() OVER (PARTITION BY fk_odrcode ORDER BY pseq) RANK  " + 
					"        from tbl_product P join tbl_orderdetail D \r\n" + 
					"        on p.pseq = D.fk_pseq \r\n" + 
					"    )A JOIN tbl_order O \r\n" + 
					"    ON A.fk_odrcode = O.odrcode " + 
						 "    where fk_userid= ? and rank = 1 ";
			
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd') +1 ";
			}
				  sql += " ) "  
						+ " where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			
			pstmt.setString(1, paraMap.get("userid"));
			
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
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
				
				OrderVO_HJE ovo = new OrderVO_HJE();
				ovo.setTotalquantity(rs.getInt(4));
				ovo.setOdrtotalprice(rs.getInt(5));
				ovo.setTotalproduct(rs.getInt(6));
				odvo.setOvo(ovo);
				
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
						 " from tbl_order " + 
						 " where fk_userid= ? ";
							
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd')+1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
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
						 " from tbl_order " + 
						 " where fk_userid= ? ";
							
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd')+1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			if( paraMap.get("date1") !=null && paraMap.get("date2") != null ) {
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

	
	// 취소한 주문리스트 출력하기
	@Override
	public List<OrderdetailVO_HJE> showCancelOrder(Map<String, String> paraMap) throws SQLException {
		
		List<OrderdetailVO_HJE> cancelorderList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select fk_odrcode, pimage, pname ,oqty , odrprice , cancelstatus  " + 
						 " from " + 
						 " ( " + 
						 "    select fk_odrcode, pimage, pname ,oqty , odrprice , cancelstatus " + 
						 "    from tbl_product P join tbl_orderdetail D " + 
						 "    on p.pseq = D.fk_pseq " + 
						 " )A JOIN tbl_order O  " + 
						 " ON A.fk_odrcode = O.odrcode " + 
						 " where fk_userid= ? and cancelstatus != 0 ";
			
			if( !("".equals(paraMap.get("date3")) || "".equals(paraMap.get("date4"))) ) {
				  sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd')+1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			
			if( !("".equals(paraMap.get("date3")) || "".equals(paraMap.get("date4"))) ) {
				pstmt.setString(2, paraMap.get("date3"));
				pstmt.setString(3, paraMap.get("date4"));
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
				odvo.setCancelstatus(rs.getInt(6));
				
				cancelorderList.add(odvo);
			}
			
		} finally {
			close();
		}
		
		return cancelorderList;
	} // end of public List<OrderdetailVO_HJE> showCancelOrder(Map<String, String> paraMap)

	
	// 총 취소 주문 개수 구하기
	@Override
	public int getCountCancelOrder(Map<String, String> paraMap) throws SQLException {

		int cancelorder=0;
		
		try {
			
			conn= ds.getConnection();
			
			String sql = " select count(*) " + 
						 " from tbl_orderdetail D JOIN tbl_order O " + 
						 " ON D.fk_odrcode = O.odrcode " + 
						 " where fk_userid= ?  and cancelstatus != 0 ";
			
			if( paraMap.get("date3") !=null && paraMap.get("date4") != null ) {
				sql += " and odrdate between to_date( ? ,'yyyy-mm-dd') and to_date( ? ,'yyyy-mm-dd')+1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			if( paraMap.get("date3") !=null && paraMap.get("date4") != null ) {
				pstmt.setString(2, paraMap.get("date3"));
				pstmt.setString(3, paraMap.get("date4"));
			}
			
			rs= pstmt.executeQuery();
			
			rs.next();
			
			cancelorder = rs.getInt(1);
			
		}finally {
			close();
		}
		
		return cancelorder;
		
	} // end of public int getCountCancelOrder(Map<String, String> paraMap)

	
	// 해당 주문에 해당하는 주문상세 보기
	@Override
	public List<OrderdetailVO_HJE> selectOrderDetail(String odrcode) throws SQLException {

		List<OrderdetailVO_HJE> orderList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select odrseqnum, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus, cname " + 
						 " from " + 
						 " ( " + 
						 "    select fk_odrcode, odrseqnum, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus, cname " + 
						 "    from " + 
						 "    ( " + 
						 "        select fk_odrcode, odrseqnum, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus, fk_opseq " + 
						 "        from tbl_product P join tbl_orderdetail D " + 
						 "        on p.pseq = D.fk_pseq " + 
						 "    )A JOIN " + 
						 "    ( " + 
						 "        select cname, opseq " + 
						 "        from tbl_poption P JOIN tbl_pcolor C " + 
						 "        ON P.fk_cseq = C.cseq " + 
						 "    ) B " + 
						 "    ON A.fk_opseq = B.opseq " + 
						 " )D JOIN tbl_order O " + 
						 " ON D.fk_odrcode = O.odrcode " + 
						 " where odrcode= ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, odrcode);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				//  odrseqnum, pimage, pname ,oqty , odrprice ,deliverstatus, cancelstatus, cname
				
				OrderdetailVO_HJE odvo = new OrderdetailVO_HJE();
				odvo.setOdrseqnum(rs.getInt(1));
				
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				pvo.setPimage(rs.getString(2));
				pvo.setPname(rs.getString(3));
				odvo.setPvo(pvo);
				
				odvo.setOdrprice(rs.getInt(4));
				odvo.setOdrprice(rs.getInt(5));
				odvo.setDeliverstatus(rs.getInt(6));
				odvo.setCancelstatus(rs.getInt(7));
				odvo.setCancelstatus(rs.getInt(7));
				
				PColorVO_OHJ pcvo = new PColorVO_OHJ();
				pcvo.setCname(rs.getString(8));
				odvo.setPcvo(pcvo);
				
				orderList.add(odvo);
			}
			
		} finally {
			close();
		}
		
		return orderList;
		
	}

}
