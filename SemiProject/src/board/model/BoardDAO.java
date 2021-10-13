package board.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class BoardDAO implements InterBoardDAO {

	private DataSource ds;// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
	
    private AES256 aes;
    
    // 기본생성자
    public BoardDAO() {
       try {
          Context initContext = new InitialContext();
           Context envContext  = (Context)initContext.lookup("java:/comp/env");
           ds = (DataSource)envContext.lookup("jdbc/semioracle"); //web.xml => ref에 값과 동일해야한다.
           
           aes = new AES256(SecretMyKey.KEY);
           // SecretMyKey.KEY 는 우리가 만든 비밀키이다.
       } catch (NamingException e) { //NamingException
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
    
    // 시퀀스를 가져온다.
    public int getSeq()
    {
        int result = 1;
        
        try {
        	conn = ds.getConnection();
            
            // 시퀀스 값을 가져온다. 
            String sql = ("SELECT BOARD_NUM.NEXTVAL FROM TBL_QNA");
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, getSeq());
            
            // 쿼리 실행
            rs = pstmt.executeQuery();
            
            if(rs.next())    result = rs.getInt(1);
 
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
        
        close();
        return result;    
    } // end getSeq
    
 // 글 목록 보여주기
 	@Override
 	public List<BoardVO> selectPagingboard() throws SQLException {
 		
 		List<BoardVO> boardList = new ArrayList<>();
 	      
 	      try {
 	         conn = ds.getConnection();
 	         
 	         String sql = " select board_num, board_id, board_subject, board_content, board_count, board_date "
 	        		 	+ " from tbl_qna "; 
 	         
 	            
 	            pstmt = conn.prepareStatement(sql);
 
 	            rs = pstmt.executeQuery();
 	            
 	            while(rs.next()) {
 	               
 	               BoardVO bvo = new BoardVO();
 	               bvo.setBoard_num(rs.getInt(1));
 	               bvo.setBoard_id(rs.getString(2));
 	               bvo.setBoard_subject(rs.getString(3));
 	               bvo.setBoard_content(rs.getString(4));
 	               bvo.setBoard_count(rs.getInt(5));
 	               bvo.setBoard_date(rs.getDate(6));
 	               
 	               boardList.add(bvo);
 	               
 	            }// end of while---------------------------
 	            
 	      } catch(SQLException e) {   
 	         e.printStackTrace();
 	      } finally {
 	         close();
 	      }
 	      
 	      return boardList;
 	}// public List<BoardVO> selectPagingboard()----------------------

 	
 // 글 작성시키는 메소드
 	@Override
 	public void register(String board_id, String board_subject, String board_content) throws SQLException {

  		try {
  			conn = ds.getConnection();
  			
  			String sql = " insert into tbl_qna(board_num, board_id, board_subject, board_content, board_count, board_date) "
  					   + " values(board_num.nextval, ?, ?, ?, default, default) ";
  			
  			pstmt = conn.prepareStatement(sql);
  			
  			pstmt.setString(1, board_id);
  			pstmt.setString(2, board_subject);
  			pstmt.setString(3, board_content);
  			
  	        pstmt.executeUpdate();
  	        
  		} catch (SQLException e) {
  			e.printStackTrace();
  		} finally {
  			close();
  		}
  		
 	}

 	
 	
	// 검색이 있는 또는 검색이 없는 전체 게시물에 대한 총페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/?) " + 
	                      " from tbl_qna " + 
	                      " where board_id = ? ";
	         
	         String colname = paraMap.get("searchType");
	         String searchWord = paraMap.get("searchWord");
	         
	         if( "subject".equals(colname) ) {
	            // 검색대상이 subject 인 경우
	            searchWord = aes.encrypt(searchWord);
	         }
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
	            sql += " and "+colname+" like '%'|| ? ||'%' ";
	         }
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, paraMap.get("sizePerPage"));
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
	            pstmt.setString(2, searchWord);
	         }
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         totalPage = rs.getInt(1);
	         
	      } catch(GeneralSecurityException | UnsupportedEncodingException e) {   
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return totalPage;
	      
	}// end of public int getTotalPage(Map<String, String> paraMap)-------------------


	// board_num 값을 입력받아서 하나의 게시글에 대한 상세정보를 알아오기(select) 
	@Override
	public BoardVO boardOneDetail(String board_num) throws SQLException {
		
		BoardVO bvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select board_num, board_id, board_subject, board_content, board_count, board_date "
					   + " from tbl_qna " 
                       + " where board_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, board_num);
	                  
	        rs = pstmt.executeQuery();
	         
	        if(rs.next()) {  
	               
	            bvo = new BoardVO();
	            bvo.setBoard_num(rs.getInt(1));
	            bvo.setBoard_id(rs.getString(2));
	            bvo.setBoard_subject(rs.getString(3));
	            bvo.setBoard_content(rs.getString(4));
	            bvo.setBoard_count(rs.getInt(5));
	            bvo.setBoard_date(rs.getDate(6));

	        }
			
		} catch(SQLException e) {   
	         e.printStackTrace();
	    } finally {
			close();
		}
		
		return bvo;
	}// end of public BoardVO boardOneDetail(String board_num)-------------------------------------------------------

	
	

	    
}
