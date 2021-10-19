package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO_KMK;


public class QnaEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 	String method = request.getMethod();
		 	
	        if("POST".equalsIgnoreCase(method)) {
	         // 기존의 글정보를 먼저 찍어주기위해서 다음과 같이 VO에 넣어준다.
	        
	    	 String board_num = request.getParameter("board_num");
	         String board_id = request.getParameter("board_id");
	         String board_subject = request.getParameter("board_subject");
	         String board_content = request.getParameter("board_content");
	         String board_date = request.getParameter("board_date");
	         String board_count = request.getParameter("board_count");
	         

	         request.setAttribute("board_num",board_num); 
	         request.setAttribute("board_id",board_id); 
	         request.setAttribute("board_subject",board_subject); 
	         request.setAttribute("board_content",board_content); 
	         request.setAttribute("board_date", board_date);
	         request.setAttribute("board_count", board_count);
	         
	         // 글 수정을 위하여 새로운정보를 입력하도록 View 페이지로 이동한다.
	         super.setViewPage("/WEB-INF/board/qnaEdit.jsp");
	         
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
