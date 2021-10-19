package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardVO;
import board.model.InterNoticeDAO;
import board.model.NoticeDAO;
import board.model.NoticeVO;
import common.controller.AbstractController;

public class NoticeDeleteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
        
        if("post".equalsIgnoreCase(method)) { // 수정할 글내용과 제목등을 적고 수정하기버튼을 눌러야 POST로 들어올 수 있다.
           
        	String notice_num = request.getParameter("notice_num");
        //	System.out.println("notice_num"+notice_num);
	        
            InterNoticeDAO ndao = new NoticeDAO();
          	int n = ndao.deleteNotice(notice_num);
          	
          	request.setAttribute("notice_num", notice_num);
          	
          	String message = "";
	        String loc = "";
           

	            if(n==1) {// 삭제 성공
	            	
	            	List<NoticeVO> noticeList = ndao.deleteNoticeEnd();
	            	
	            	message = "삭제 성공!!";
	            	request.setAttribute("noticeList", noticeList);
	            	
	            	super.setViewPage("/WEB-INF/board/noticeDeleteEnd.jsp");
	            }
	            else {// 삭제 실패
	               message = "삭제 실패!!";
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
