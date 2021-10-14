package board.model;

import java.sql.SQLException;
import java.util.List;

public interface InterNoticeDAO {

	// 공지사항 글 작성시키는 메소드
	void register(String notice_id, String notice_subject, String notice_content) throws SQLException;

	// QNA 게시판 글 목록 보여주기
	List<NoticeVO> selectPagingnotice() throws SQLException;

}
