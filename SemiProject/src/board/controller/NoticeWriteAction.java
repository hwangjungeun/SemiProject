package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class NoticeWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		   String userid = "admin";
		   String method = request.getMethod();
		
		  // 관리자 로그인 시에만 글 작성이 가능 하도록 한다 //
	      HttpSession session = request.getSession();
	      
	      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

	      // 관리자로 로그인 되었을 때
	      if( loginuser != null && "admin".equals(loginuser.getUserid())) {
	    	  
	    	  request.setAttribute("userid", userid);
	    	  super.setViewPage("/WEB-INF/board/noticeWrite.jsp");				
	      }

	      else {
	         String message = "관리자만 접근이 가능합니다.";            
	         String loc = "javascript:history.back()";            
	           
	         request.setAttribute("message", message);           
	         request.setAttribute("loc", loc);
	                
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
	      
	}

		  
}
