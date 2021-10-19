package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO_KMK;

public class NoticeDeleteAction extends AbstractController {

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
	    //	 System.out.println("$$$$$$$$$notice_num"+notice_num);
	
	         request.setAttribute("notice_num",notice_num); 
	         

	         super.setViewPage("/WEB-INF/board/noticeDelete.jsp");
       
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
