package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class NoticeEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		 String method = request.getMethod();
         
         if("post".equalsIgnoreCase(method)) { // 수정할 글내용과 제목등을 적고 수정하기버튼을 눌러야 POST로 들어올 수 있다.
            
        	String notice_num = request.getParameter("notice_num");
        	String notice_id = request.getParameter("notice_id");
	        String notice_subject = request.getParameter("notice_subject");
	        String notice_content = request.getParameter("notice_content");       
	        
            InterNoticeDAO ndao = new NoticeDAO();
           	int n = ndao.updateNotice(notice_id, notice_subject, notice_content, notice_num);
           	
           	request.setAttribute("notice_num", notice_num);
           	request.setAttribute("notice_id", notice_id);
           	request.setAttribute("notice_subject", notice_subject);
           	request.setAttribute("notice_content", notice_content);
           	
           	String message = "";
	        String loc = "";
            

	            if(n==1) {// update 성공
	            	
	            	NoticeVO nvo = ndao.updateNoticeEnd(notice_id, notice_subject, notice_content, notice_num);
	            	
	            	message = "글 수정 성공!!";
	            	request.setAttribute("nvo", nvo);
	            	
	            	super.setViewPage("/WEB-INF/board/noticeEditEnd.jsp");
	                
	            }
	            else {// update 실패
	               message = "글 수정 실패!!";
	               loc = "javascript:history.back()";
	               
	               request.setAttribute("message", message);
			       request.setAttribute("loc", loc);
			        
			       super.setViewPage("/WEB-INF/msg.jsp");
	            }
            
	            
	         }
         
 			else {
 				
 			// **** POST 방식으로 넘어온 것이 아니라면 **** //
 			
 			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
 	        String loc = "javascript:history.back()";
 	         
 	        request.setAttribute("message", message);
 	        request.setAttribute("loc", loc);
 	         
 	        super.setViewPage("/WEB-INF/msg.jsp");
 	         
            
         }
         
         
   }

}
