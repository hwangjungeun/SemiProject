package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO_KMK;


public interface InterBoardDAO {

	// QNA 게시판 글 목록 보여주기
	List<BoardVO> selectPagingboard() throws SQLException;

	// 글 작성시키는 메소드
	void register(String board_id, String board_subject, String board_content) throws SQLException;
	
	// board_num 값을 입력받아서 하나의 게시글에 대한 상세정보를 알아오기(select) 
	BoardVO boardOneDetail(String board_num) throws SQLException;

	// 글 클릭했을때 조회수 받아오는 메소드
	void boardCnt(String board_num) throws SQLException;
	
	// 검색이 있는 또는 검색이 없는 전체 게시물에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 글 정보 수정하기
	int updateBoard(String board_id, String board_subject, String board_content, String board_num) throws SQLException;

	// 수정한 글 보여주기
	BoardVO updateEnd(String board_id, String board_subject, String board_content, String board_num, String board_date,
			String board_count) throws SQLException;

	// 글 삭제하기
	int deleteBoard(String board_num) throws SQLException;

	// 삭제 후 목록에서 삭제 확인
	List<BoardVO> deleteEnd() throws SQLException;

	// 답글 등록하기
	void writeReply(String board_id, String board_subject, String board_content, String board_num) throws SQLException;

	// 답글 보여주기
	BoardVO writeReplyEnd(String board_id, String board_subject, String board_content, String board_num,
			String board_date, String board_count) throws SQLException;

	// 페이징 처리를 한 글목록 보여주기
	List<BoardVO> selectPagingBoardList(Map<String, String> paraMap) throws SQLException;



	


}
