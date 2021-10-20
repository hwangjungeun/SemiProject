package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO_KMK;

public class NoticeEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		  String userid = "admin";
		  String method = request.getMethod();
		
		  // 관리자 로그인 시에만 글 수정이 가능 하도록 한다 //
	      HttpSession session = request.getSession();
	      
	      MemberVO_KMK loginuser = (MemberVO_KMK) session.getAttribute("loginuser");

	      // 관리자로 로그인 되었을 때
	      if( loginuser != null && "admin".equals(loginuser.getUserid())) {

	    	 String notice_num = request.getParameter("notice_num");
	         String notice_id = request.getParameter("notice_id");
	         String notice_subject = request.getParameter("notice_subject");
	         String notice_content = request.getParameter("notice_content");
	
	         request.setAttribute("notice_num",notice_num); 
	         request.setAttribute("notice_id",notice_id); 
	         request.setAttribute("notice_subject",notice_subject); 
	         request.setAttribute("notice_content",notice_content); 
	         
	         // 글 수정을 위하여 새로운정보를 입력하도록 View 페이지로 이동한다.
	         super.setViewPage("/WEB-INF/board/noticeEdit.jsp");
         
	      }
	      
	      else {
	         
	         String message = "잘못된 접근입니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	      }
      
   }

}
