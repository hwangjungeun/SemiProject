package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaDeleteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
	 	
		if("POST".equalsIgnoreCase(method)) { // POST로 들어왔다는 것은 팝업창에서 삭제하겠다고 동의한 것이다.
            
			String board_num = request.getParameter("board_num");
			
		//	System.out.println("확인용 board_num"+board_num);
            
            InterBoardDAO bdao = new BoardDAO();
            int n = bdao.deleteBoard(board_num); // 게시글 삭제하기
            
            request.setAttribute("board_num", board_num);
            
            String message = "";
            String loc = "";
            
            if(n==1) { // 삭제 성공
            	List<BoardVO> boardList = bdao.deleteEnd();
            	
            	message = "삭제 성공!!";
            	request.setAttribute("boardList", boardList);
            	
            	super.setViewPage("/WEB-INF/board/qnaDeleteEnd.jsp");
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
