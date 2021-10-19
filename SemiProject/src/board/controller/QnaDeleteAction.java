package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class QnaDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
	 	
        if("POST".equalsIgnoreCase(method)) {

    	 String board_num = request.getParameter("board_num");
    	 
    //	 System.out.println("####확인용 board_num"+board_num);
        
         request.setAttribute("board_num",board_num); 
         

         super.setViewPage("/WEB-INF/board/qnaDelete.jsp");
         
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
