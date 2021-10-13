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
		
			super.setViewPage("/WEB-INF/board/qnaWrite.jsp");	
		
		} else {
	         String message = "관리자만 접근이 가능합니다.";            
	         String loc = "javascript:history.back()";            
	           
	         request.setAttribute("message", message);           
	         request.setAttribute("loc", loc);
	                
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
       

	}

      
   }
 

   
   