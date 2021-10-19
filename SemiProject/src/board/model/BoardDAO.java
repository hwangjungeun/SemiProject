package board.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

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
    } // end getSeq()---------------------------------------------
    
    
  // QNA 게시판 글 목록 보여주기
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
  		
 	}// end of public void register(String board_id, String board_subject, String board_content)----------------------------

 	
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

	
	// 글 클릭했을때 조회수 받아오는 메소드
	@Override
	public void boardCnt(String board_num) throws SQLException {

		int boardCnt = 0;
		
			try {
				conn = ds.getConnection();
				
				String sql = " select board_count "+
							 " from tbl_qna "+
							 " where board_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, board_num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					boardCnt = rs.getInt(1);
				}
				////////////////////////////////////////////////////// select문 여러개 나오면 헷갈리니까 주석치기
				sql = " update tbl_qna set board_count = ? "
					+ " where board_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, (boardCnt+1)+"");
				pstmt.setString(2, board_num);
				
			
				pstmt.executeUpdate();
				
				
			} catch(SQLException e) {   
		         e.printStackTrace();
		    } finally {
				close();
			}
		}// end of public void boardCnt(String board_num)-------------------------------

	


	// 검색이 있는 또는 검색이 없는 전체 게시물에 대한 총페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select ceil(count(*)/?) " + 
	                      " from tbl_qna " + 
	                      " where board_id != 'null' ";
	         
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

	
	// 글 정보 수정하기
	@Override
	public int updateBoard(String board_id, String board_subject, String board_content, String board_num) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_qna "+
						 " set board_id = ?, board_subject = ?, board_content = ? "+
						 " where board_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board_id);
			pstmt.setString(2, board_subject);
			pstmt.setString(3, board_content);
			pstmt.setString(4, board_num);

			n = pstmt.executeUpdate();		
			

         } finally {
            close();
         }
		
		return n;
	}// end of public int updateBoard(String board_id, String board_subject, String board_content)----------------------------

	
	// 수정한 글 보여주기
	@Override
	public BoardVO updateEnd(String board_id, String board_subject, String board_content, String board_num,
			String board_date, String board_count) throws SQLException {
		
			BoardVO bvo = null;
		
			try {
	 	        conn = ds.getConnection();
	 	         
	 	        String sql = " select board_num, board_id, board_subject, board_content, board_count, board_date "
	 	        		   + " from tbl_qna "; 
 	         
 	            
 	            pstmt = conn.prepareStatement(sql);
 
 	            rs = pstmt.executeQuery();
 	            
 	            while(rs.next()) {
 	               
 	               bvo = new BoardVO();
	               bvo.setBoard_num(rs.getInt(1));
	               bvo.setBoard_id(rs.getString(2));
	               bvo.setBoard_subject(rs.getString(3));
	               bvo.setBoard_content(rs.getString(4));
	               bvo.setBoard_count(rs.getInt(5));
	               bvo.setBoard_date(rs.getDate(6));
 	               
 	            }// end of while---------------------------
 	            
 	      } catch(SQLException e) {   
 	         e.printStackTrace();
 	      } finally {
 	         close();
 	      }
 	      
		return bvo;
	}// end of public BoardVO updateEnd(String board_id, String board_subject, String board_content, String board_num, String board_date, String board_count)----------------------

	
	// 글 삭제하기
	@Override
	public int deleteBoard(String board_num) throws SQLException {
		
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete tbl_qna "
	                  	+ " where board_num = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, board_num);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}// end of public int deleteBoard(String board_num)-----------------------------------------

	
	
	// 삭제 후 목록에서 삭제 확인
	@Override
	public List<BoardVO> deleteEnd() throws SQLException {
		
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
	}// end of public List<BoardVO> deleteEnd()-------------------------------------------------

	
	// 답글 등록하기
	@Override
	public void writeReply(String board_id, String board_subject, String board_content, String board_num) throws SQLException {

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

	}// end of public void writeReply(String board_id, String board_subject, String board_content, String board_num)------------------------

	
	// 답글 보여주기
	@Override
	public BoardVO writeReplyEnd(String board_id, String board_subject, String board_content, String board_num,
			String board_date, String board_count) throws SQLException {
		
		BoardVO bvo = null;
		
		try {
 	        conn = ds.getConnection();
 	         
 	        String sql = " select board_num, board_id, board_subject, board_content, board_count, board_date "
 	        		   + " from tbl_qna "; 
	         
	            
	            pstmt = conn.prepareStatement(sql);

	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               
	           bvo = new BoardVO();
               bvo.setBoard_num(rs.getInt(1));
               bvo.setBoard_id(rs.getString(2));
               bvo.setBoard_subject(rs.getString(3));
               bvo.setBoard_content(rs.getString(4));
               bvo.setBoard_count(rs.getInt(5));
               bvo.setBoard_date(rs.getDate(6));
	               
	            }// end of while---------------------------
	            
	      } catch(SQLException e) {   
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
		return bvo;
	 }// end of public BoardVO writeReplyEnd(String board_id, String board_subject, String board_content, String board_num, String board_date, String board_count)-----------------------------------

	
	// // 페이징 처리를 한 글목록 보여주기
	@Override
	public List<BoardVO> selectPagingBoardList(Map<String, String> paraMap) throws SQLException {
		
		 List<BoardVO> boardlist = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select board_id, board_subject, board_content " + 
	        		 	" from " + 
	        		 	" ( " + 
	        		 	" select rownum AS rno, board_id, board_subject, board_content " + 
	        		 	" from " + 
	        		 	" ( " + 
	        		 	" select board_id, board_subject, board_content " + 
	        		 	" from tbl_qna " + 
	        		 	" where board_id != 'null' ";
	         
	         String colname = paraMap.get("searchType");
	         String searchWord = paraMap.get("searchWord");
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
	            
	            sql +=  " and "+colname+" like '%'|| ? ||'%' ";
	         
	         }
	         
	            sql +=    "     order by board_date desc " + 
	               "    ) V " + 
	               " ) T " + 
	               " where rno between ? and ?";
	            
	            pstmt = conn.prepareStatement(sql);
	            
	            int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
	            int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
	            
	            if( searchWord != null && !searchWord.trim().isEmpty() ) {
	               pstmt.setString(1, searchWord);
	               pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식 
	               pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식
	            }
	            else {
	               pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식 
	               pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식
	            }
	            
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               
	               BoardVO bvo = new BoardVO();
	               bvo.setBoard_id(rs.getString(1));
	               bvo.setBoard_subject(rs.getString(2));
	               bvo.setBoard_content(rs.getString(3));
	               boardlist.add(bvo);

	            }// end of while---------------------------
	            
	      } catch(SQLException e) {   
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return boardlist;
	}// end of public List<BoardVO> selectPagingBoardList(Map<String, String> paraMap)------------------------------------------------

	


}
