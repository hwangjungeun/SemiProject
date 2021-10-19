package board.controller;

import javax.servlet.http.*;

import common.controller.AbstractController;
import member.model.*;

public class QnaWriteAction extends AbstractController {
//===========================================================================================
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   

	   String userid = "";
	   String method = request.getMethod();
	   
	   try {
		   HttpSession session = request.getSession();
		   MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		   userid = loginuser.getUserid();
	   }catch(NullPointerException e) {
		   userid = "no";
	   }
       
       
	   if("GET".equalsIgnoreCase(method) && userid != "no") {
		
			request.setAttribute("userid", userid);
			super.setViewPage("/WEB-INF/board/qnaWrite.jsp");	
		
		} else {
	         String message = "로그인 이후 가능합니다.";            
	         String loc = "javascript:history.back()";            
	           
	         request.setAttribute("message", message);           
	         request.setAttribute("loc", loc);
	                
	         super.setViewPage("/WEB-INF/msg.jsp");
		}
       

	 }

      
   }
 

   
   