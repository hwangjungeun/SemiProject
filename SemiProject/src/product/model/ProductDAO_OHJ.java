package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;


public class ProductDAO_OHJ implements InterProductDAO_OHJ {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO_OHJ() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		} catch(NamingException e) {
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

    
    // 최근본상품 목록을 조회(select)하는 메소드
	@Override
	public List<RecentViewProdVO_OHJ> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException {
		
		List<RecentViewProdVO_OHJ> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pname, pimage, price, pseq " + 
						 " from tbl_recentViewProduct V JOIN tbl_product P " + 
						 " ON V.fk_pseq = P.pseq " + 
						 " where fk_userid = ? " + 
						 " order by viewday desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				RecentViewProdVO_OHJ rvpvo = new RecentViewProdVO_OHJ();
				
				ProductVO_OHJ pvo = new ProductVO_OHJ();
				pvo.setPname(rs.getString(1));
				pvo.setPimage(rs.getString(2));
				pvo.setPrice(rs.getInt(3));
				pvo.setPseq(rs.getString(4));
				rvpvo.setPvo(pvo);
				
				productList.add(rvpvo);
				
			}// end of while------------------------------------------------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectRecentViewProduct(Map<String, String> paraMap)-----------------------

	
	// 제품번호를 이용해서 옵션(색상의 종류)을 조회(select)하는 메소드
	@Override
	public List<Map<String, String>> viewColorOption(String pseq) throws SQLException {
		
		List<Map<String, String>> colorList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select C.cname " + 
						 " from tbl_product P JOIN tbl_poption O " + 
						 " ON P.pseq = O.fk_pseq " + 
						 " JOIN tbl_pcolor C " + 
						 " ON O.fk_cseq = C.cseq " + 
						 " where P.pseq = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  pseq);
			
			rs = pstmt.executeQuery();	
			
			while(rs.next()) {
				Map<String, String> map = new HashMap<>();
				map.put("CNAME", rs.getString(1));
				
				colorList.add(map);
			}// end of while--------------------------------------
			
		} finally {
			close();
		}
		
		return colorList;
	}// end of public List<Map<String, String>> viewColorOption(String pseq)-------------------------------------

	
	
	
	
	
}
