package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaReplyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		  String userid = "admin";
		  String method = request.getMethod();
		
		  // 관리자 로그인 시에만 글 수정이 가능 하도록 한다 //
	      HttpSession session = request.getSession();
	      
	      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

	      // 관리자로 로그인 되었을 때
	      if( loginuser != null && "admin".equals(loginuser.getUserid())) {

	    	  String board_num = request.getParameter("board_num");
	    	  String board_content = request.getParameter("board_content");
	    	  
	    	  request.setAttribute("userid", userid);
	    	  request.setAttribute("board_num", board_num);
	    	  request.setAttribute("board_content", board_content);
	    	  
	 		//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/qnaReply.jsp");	
        
	      }
	      
	      else {
	         
	         String message = "관리자만 답글 가능합니다!!";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	      }
     
  }


	}

