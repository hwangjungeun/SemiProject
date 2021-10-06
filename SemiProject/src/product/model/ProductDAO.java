package product.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO() {
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
	public List<RecentViewProdVO> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException {
		
		List<RecentViewProdVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pname, pimage1, pimage2, price, fk_sseq, viewday " + 
						 " from tbl_recentViewProduct V JOIN tbl_product P " + 
						 " ON V.fk_pseq = P.pseq " + 
						 " where fk_userid = ? " + 
						 " order by viewday desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				RecentViewProdVO rvpvo = new RecentViewProdVO();
				
				ProductVO pvo = new ProductVO();
				pvo.setPname(rs.getString(1));
				pvo.setPimage1(rs.getString(2));
				pvo.setPimage2(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setFk_sseq(rs.getString(5));
				rvpvo.setPvo(pvo);
				
				rvpvo.setViewday(rs.getString(6));
				
				productList.add(rvpvo);
				
			}// end of while------------------------------------------------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectRecentViewProduct(Map<String, String> paraMap)------------------------------

	
	
	
	
	
}
