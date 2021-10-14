package board.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class NoticeDAO implements InterNoticeDAO {
	
	private DataSource ds;// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
	
    private AES256 aes;
    
    // 기본생성자
    public NoticeDAO() {
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
            String sql = ("SELECT NOTICE_NUM.NEXTVAL FROM TBL_NOTICE");
            
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

    
    // 공지사항 글 작성시키는 메소드
	@Override
	public void register(String notice_id, String notice_subject, String notice_content) throws SQLException {
		
		try {
  			conn = ds.getConnection();
  			
  			String sql = " insert into tbl_notice(notice_num, notice_id, notice_subject, notice_content, notice_count, notice_date) "
  					   + " values(notice_num.nextval, ?, ?, ?, default, default) ";
  			
  			pstmt = conn.prepareStatement(sql);
  			
  			pstmt.setString(1, notice_id);
  			pstmt.setString(2, notice_subject);
  			pstmt.setString(3, notice_content);
  			
  	        pstmt.executeUpdate();
  	        
  		} catch (SQLException e) {
  			e.printStackTrace();
  		} finally {
  			close();
  		}
		
	}// end of public void register(String notice_id, String notice_subject, String notice_content)------------------------------

	// QNA 게시판 글 목록 보여주기
	@Override
	public List<NoticeVO> selectPagingnotice() throws SQLException {
		
		List<NoticeVO> noticeList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select notice_num, notice_id, notice_subject, notice_content, notice_count, notice_date "
	        		 	+ " from tbl_notice "; 
	         
	            
	            pstmt = conn.prepareStatement(sql);

	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               
	               NoticeVO nvo = new NoticeVO();
	               
	               nvo.setNotice_num(rs.getInt(1));
	               nvo.setNotice_id(rs.getString(2));
	               nvo.setNotice_subject(rs.getString(3));
	               nvo.setNotice_content(rs.getString(4));
	               nvo.setNotice_count(rs.getInt(5));
	               nvo.setNotice_date(rs.getDate(6));
	               
	               noticeList.add(nvo);
	               
	            }// end of while---------------------------
	            
	      } catch(SQLException e) {   
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return noticeList;
	}// end of public void register(String notice_id, String notice_subject, String notice_content)------------------------------
    

    

}
