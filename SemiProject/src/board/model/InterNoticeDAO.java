package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	// 공지사항 글 작성시키는 메소드
	void register(String notice_id, String notice_subject, String notice_content) throws SQLException;

	// 공지사항 게시판 글 목록 보여주기
	List<NoticeVO> selectPagingnotice() throws SQLException;

	// notice_num 값을 입력받아서 하나의 게시글에 대한 상세정보를 알아오기(select) 
	NoticeVO noticeOneDetail(String notice_num) throws SQLException;

	// 글 클릭했을때 조회수 받아오는 메소드
	void noticeCnt(String notice_num) throws SQLException;

	// 글 수정하기 메소드
	int updateNotice(String notice_id, String notice_subject, String notice_content, String notice_num) throws SQLException;

	// 수정한 글 보여주기
	NoticeVO updateNoticeEnd(String notice_id, String notice_subject, String notice_content, String notice_num) throws SQLException;

	// 글 삭제하기
	int deleteNotice(String notice_num) throws SQLException;

	// 삭제 후 목록에서 삭제 확인
	List<NoticeVO> deleteNoticeEnd() throws SQLException;



	

}
