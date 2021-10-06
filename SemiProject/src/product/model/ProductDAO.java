package product.model;

import java.sql.*;
import java.util.List;
import java.util.Map;

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
	public List<ProductVO> selectRecentViewProduct(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> productList = null;
		
		try {
			conn = ds.getConnection();
			
			
			
			
			
			
			/*
			 * String sql = " select imgno, imgfilename, imgbigo " + " from tbl_main_image "
			 * + " order by imgno asc ";
			 * 
			 * pstmt = conn.prepareStatement(sql);
			 * 
			 * rs = pstmt.executeQuery();
			 * 
			 * while(rs.next()) { ImageVO imgvo = new ImageVO();
			 * imgvo.setImgno(rs.getInt(1)); imgvo.setImgfilename(rs.getString(2));
			 * imgvo.setImgbigo(rs.getString(3));
			 * 
			 * imgList.add(imgvo); }// end of while------------------
			 */		
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectRecentViewProduct(Map<String, String> paraMap)------------------------------

	
	
	
	
	
}
