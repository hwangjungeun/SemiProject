package board.model;

import java.sql.Date;

public class NoticeVO {

	private int notice_num;			// 공지사항 글 번호
	private String notice_id;		// 공지사항 글 작성자
	private String notice_subject;	// 공지사항 글 제목
	private String notice_content;	// 공지사항 글 내용
	private int notice_count;		// 공지사항 글 조회수
	private Date notice_date;		// 공지사항 글 작성일
	
	////////////////////////////////////////////////////////////////////////////////////////
		
	public NoticeVO() {}
	
	public NoticeVO(String notice_id, String notice_subject, String notice_content) {
	
	this.notice_id = notice_id;
	this.notice_subject = notice_subject;
	this.notice_content = notice_content; 
	
	}

	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(String notice_id) {
		this.notice_id = notice_id;
	}
	public String getNotice_subject() {
		return notice_subject;
	}
	public void setNotice_subject(String notice_subject) {
		this.notice_subject = notice_subject;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public int getNotice_count() {
		return notice_count;
	}
	public void setNotice_count(int notice_count) {
		this.notice_count = notice_count;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	
}
