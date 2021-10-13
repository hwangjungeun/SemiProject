package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;


public interface InterBoardDAO {

	 // 글 목록 보여주기
	List<BoardVO> selectPagingboard() throws SQLException;

	// 검색이 있는 또는 검색이 없는 전체 게시물에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 글 작성시키는 메소드
	void register(String board_id, String board_subject, String board_content) throws SQLException;
	
	// board_num 값을 입력받아서 하나의 게시글에 대한 상세정보를 알아오기(select) 
	BoardVO boardOneDetail(String board_num) throws SQLException;

	

	



	


	
	


}
