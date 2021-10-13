package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;


public class QnaEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String board_id = request.getParameter("board_id");
			String board_subject = request.getParameter("board_subject");
			String board_content = request.getParameter("board_content");
			
	        BoardVO board = new BoardVO(board_id, board_subject, board_content);
		
	        InterBoardDAO bdao = new BoardDAO();
	        int n = bdao.updateBoard(board);
	        
	        String message = "";
	        String loc = "javascript:history.back()";
	        
	        if(n == 1) {
	        	
	        	// !!! session 에 저장된 board_num 을 변경된 사용자의 정보값으로 변경해주어야 한다. !!! //
	        	HttpSession session = request.getSession();
	        	BoardVO board_num = (BoardVO)session.getAttribute("board_num");
	        	
	        	board_num.setBoard_id(board_id);
	        	board_num.setBoard_subject(board_subject);
	        	board_num.setBoard_content(board_content);
	        	
	        	message = "글 수정 성공!!";
	        }
	        else {
	        	message = "글 수정 실패!!";
	        }
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
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
