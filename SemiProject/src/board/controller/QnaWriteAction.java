package board.controller;

import java.sql.SQLException;
import java.util.*;
import javax.servlet.http.*;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.*;

public class QnaWriteAction extends AbstractController {
//===========================================================================================
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
	   String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaWrite.jsp");	
		}
		
		else {
			 String board_id = request.getParameter("board_id"); 
			 String board_subject =request.getParameter("board_subject");
			 String board_content = request.getParameter("board_content");

	         BoardVO board = new BoardVO(board_id, board_subject, board_content);
	    
	     /*
	         String message = "";
	         String loc = "";
	         
	         try {
		         InterMemberDAO mdao = new MemberDAO();
		         int n = mdao.registerMember(member);
		         
		         
		         if(n==1) {
		        	 message = "회원가입 성공";
		        	 loc = request.getContextPath()+"/index.up"; // 시작 페이지로 이동한다.
		         }
	         } catch(SQLException e) {
	        	 message = "SQL구문 에러 발생";
	        	 loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는 것. 	 
	         }
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	     //  super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	    */
	         
	         try {
	        	 InterBoardDAO bdao = new BoardDAO();
		         int n = bdao.registerQna(board);
		         
		         if(n==1) {
		        	request.setAttribute("board_id", board_id);
		        	request.setAttribute("board_subject", board_subject);
		        	request.setAttribute("board_content", board_content);
		        	
		        //  super.setRedirect(false);
		        	super.setViewPage("/WEB-INF/board/qnaRegister.jsp");
		         }
	         } catch(SQLException e) {
	        	 String message = "SQL구문 에러 발생";
	        	 String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는 것.
	        	 
	        	 request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		     //  super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
	         }
	         
	      
	         
		}
	         
      }
      
   }
 

   
   